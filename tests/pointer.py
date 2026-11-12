"""Route synthetic GDK events through the actual offscreen GTK widget.
No physical pointer movement, visible window, or external data is involved.
"""
import ctypes
import sys
from pathlib import Path
import gi

gi.require_version('Gtk', '3.0')
gi.require_version('Gdk', '3.0')
from gi.repository import Gdk, Gtk

root = Path(__file__).resolve().parent.parent
fixture = ctypes.CDLL(str(root / 'build/libui-fixture.so'))
status = fixture.main()
if status == 77:
    sys.exit(77)
assert status == 0, status
window = next(w for w in Gtk.Window.list_toplevels() if w.get_title() == 'Bone Lab • Assembly IK + FK')

def descendants(widget):
    yield widget
    if isinstance(widget, Gtk.Container):
        for child in widget.get_children():
            yield from descendants(child)
widgets = list(descendants(window))
canvas = next(w for w in widgets if isinstance(w, Gtk.DrawingArea))
fields = {w.get_text(): w.get_mnemonic_widget() for w in widgets if isinstance(w, Gtk.Label) and w.get_mnemonic_widget() is not None}
az = fields['Camera azimuth °']
el = fields['Camera elevation °']
reset = next(w for w in widgets if isinstance(w, Gtk.Button) and w.get_label() == 'Reset view')
reset.clicked()
# Restore a valid IK state after the fixture's invalid-input regression.
fields['Elbow minimum °'].set_value(0)
fields['Elbow maximum °'].set_value(180)
fields['Target X'].set_value(2)
next(w for w in widgets if isinstance(w, Gtk.ComboBoxText)).set_active(0)
while Gtk.events_pending():
    Gtk.main_iteration_do(False)
window.check_resize()
notebook = next(w for w in widgets if isinstance(w, Gtk.Notebook))
results_scroll = notebook.get_nth_page(0)
adjustment = results_scroll.get_vadjustment()
assert adjustment.get_upper() <= adjustment.get_page_size(), (adjustment.get_upper(), adjustment.get_page_size())
assert canvas.get_allocated_height() == 230
assert window.get_allocated_width() <= 1120 and window.get_allocated_height() <= 760
# Both complete mathematical representations remain present.
assert notebook.get_n_pages() == 4
assert any(isinstance(w, Gtk.TextView) and w.get_buffer().get_char_count() > 500 for w in widgets)
device = Gdk.Display.get_default().get_default_seat().get_pointer()
clock = 1000

def send(kind, x, y, button=2, state=0):
    global clock
    clock += 20
    event = Gdk.Event.new(kind)
    event.window = canvas.get_window()
    event.send_event = True
    event.time = clock
    event.x = x
    event.y = y
    event.x_root = x
    event.y_root = y
    event.state = state
    if kind in (Gdk.EventType.BUTTON_PRESS, Gdk.EventType.BUTTON_RELEASE):
        event.button = button
    event.set_device(device)
    canvas.event(event)
    while Gtk.events_pending():
        Gtk.main_iteration_do(False)

def pose():
    return az.get_value(), el.get_value()

# A left-button drag must not rotate the camera.
send(Gdk.EventType.BUTTON_PRESS, 100, 100, button=1)
send(Gdk.EventType.MOTION_NOTIFY, 200, 150, state=Gdk.ModifierType.BUTTON1_MASK)
send(Gdk.EventType.BUTTON_RELEASE, 200, 150, button=1, state=Gdk.ModifierType.BUTTON1_MASK)
assert pose() == (-45, 25), pose()
# Middle press and held movement update the view. Crossing the canvas boundary
# remains a valid sequence, then release must stop subsequent motion.
send(Gdk.EventType.BUTTON_PRESS, 100, 100)
send(Gdk.EventType.MOTION_NOTIFY, 200, 150, state=Gdk.ModifierType.BUTTON2_MASK)
assert pose() == (-5, 5), pose()
send(Gdk.EventType.MOTION_NOTIFY, -50, 450, state=Gdk.ModifierType.BUTTON2_MASK)
assert pose() == (-105, -85), pose()
send(Gdk.EventType.BUTTON_RELEASE, -50, 450, state=Gdk.ModifierType.BUTTON2_MASK)
send(Gdk.EventType.MOTION_NOTIFY, 250, 100)
assert pose() == (-105, -85), pose()
# A new drag starts from the most recent view and reset remains independent.
send(Gdk.EventType.BUTTON_PRESS, 100, 100)
send(Gdk.EventType.MOTION_NOTIFY, 150, 50, state=Gdk.ModifierType.BUTTON2_MASK)
assert pose() == (-85, -65), pose()
send(Gdk.EventType.BUTTON_RELEASE, 150, 50, state=Gdk.ModifierType.BUTTON2_MASK)
reset.clicked()
assert pose() == (-45, 25), pose()
window.destroy()
print('PASS: scroll-free Results, compact bounds, full plaintext, clean teardown; GDK event routing, left-button rejection, MMB drag, boundary crossing, release, repeated drag, reset')
