"""Offscreen GTK integration of pose history, guided examples and atlas search."""
import ctypes
import re
import sys
from pathlib import Path
import gi

gi.require_version('Gtk', '3.0')
gi.require_version('Gdk', '3.0')
from gi.repository import Gtk, Gdk
root = Path(__file__).resolve().parent.parent
fixture = ctypes.CDLL(str(root / 'build/libui-fixture.so'))
status = fixture.main()
if status == 77:
    sys.exit(77)
assert status == 0
window = next(w for w in Gtk.Window.list_toplevels() if w.get_title() == 'Bone Lab • Assembly IK + FK')
def descendants(w):
    yield w
    if isinstance(w, Gtk.Container):
        for c in w.get_children():
            yield from descendants(c)
widgets = list(descendants(window))
fields = {w.get_text(): w.get_mnemonic_widget() for w in widgets if isinstance(w, Gtk.Label) and w.get_mnemonic_widget() is not None}
buttons = {w.get_label(): w for w in widgets if isinstance(w, Gtk.Button) and w.get_label()}
mode = next(w for w in widgets if isinstance(w, Gtk.ComboBoxText) and w.get_active_text().startswith(('IK —', 'FK —')))
examples = next(w for w in widgets if isinstance(w, Gtk.ComboBoxText) and w is not mode)
notebook = next(w for w in widgets if isinstance(w, Gtk.Notebook))
branch = buttons['Bend the elbow the other way']
atlas_status = next(w for w in widgets if isinstance(w, Gtk.Label) and w.get_text().startswith('Choose IK mode'))
def drain():
    while Gtk.events_pending():
        Gtk.main_iteration_do(False)
    window.check_resize()
def load(index):
    examples.set_active(index)
    buttons['Load example'].clicked()
    drain()
def val(name):
    return fields[name].get_value()
def setval(name, value):
    fields[name].set_value(value)
load(0)
setval('Target X',3)
buttons['Undo pose'].clicked()
assert val('Target X') == 2
buttons['Redo pose'].clicked()
assert val('Target X') == 3
setval('Target Y',2)
buttons['Undo pose'].clicked()
assert val('Target Y') == 1
setval('Target X',4)
assert not buttons['Redo pose'].get_sensitive()
buttons['Front'].clicked()
assert val('Camera azimuth °') == -90 and val('Camera elevation °') == 0
buttons['Undo pose'].clicked()
assert val('Target X') == 3
assert val('Camera azimuth °') == -90, 'Pose history changed the camera'
buttons['Side'].clicked()
assert val('Camera azimuth °') == 0
buttons['Above'].clicked()
assert val('Camera elevation °') == 85
buttons['Reset view'].clicked()
for i in range(7):
    load(i)
    assert mode.get_active() == (1 if i == 5 else 0)
    assert branch.get_active() == (i == 4)
    assert val('Bone 2') == (2 if i == 3 else 1.5)
    if i == 6:
        assert val('Yaw minimum °') == -30 and val('Pitch maximum °') == 45
load(0)
setval('Yaw minimum °',20)
setval('Yaw maximum °',25)
setval('Pitch minimum °',0)
setval('Pitch maximum °',10)
buttons['Find sampled pose'].clicked()
assert '124 eligible samples' in atlas_status.get_text(), atlas_status.get_text()
match=re.search(r'yaw ([\d.-]+)° • pitch ([\d.-]+)° • flexion ([\d.-]+)°',atlas_status.get_text())
selected=tuple(map(float,match.groups()))
assert buttons['Use sampled pose in FK'].get_sensitive()
buttons['Use sampled pose in FK'].clicked()
assert mode.get_active() == 1
assert tuple(val(n) for n in ['Shoulder yaw °','Shoulder pitch °','Elbow flexion °']) == selected
assert 20 <= selected[0] <= 25 and 0 <= selected[1] <= 10
buttons['Undo pose'].clicked()
assert mode.get_active() == 0 and val('Target X') == 2
assert not buttons['Use sampled pose in FK'].get_sensitive()
# A stale search cannot apply after an input or bend change.
buttons['Find sampled pose'].clicked()
branch.set_active(True)
assert not buttons['Use sampled pose in FK'].get_sensitive()
assert 'changed' in atlas_status.get_text()
setval('Yaw minimum °',-30)
setval('Yaw maximum °',30)
setval('Pitch maximum °',45)
buttons['Find sampled pose'].clicked()
assert '3224 eligible samples' in atlas_status.get_text(),atlas_status.get_text()
buttons['Use sampled pose in FK'].clicked()
assert branch.get_active() and 0 <= val('Shoulder pitch °') <= 45
buttons['Undo pose'].clicked()
setval('Yaw minimum °',.1)
setval('Yaw maximum °',.2)
buttons['Find sampled pose'].clicked()
assert atlas_status.get_text().startswith('No grid samples'), atlas_status.get_text()
assert not buttons['Use sampled pose in FK'].get_sensitive()
setval('Yaw minimum °',20)
setval('Yaw maximum °',10)
buttons['Find sampled pose'].clicked()
assert atlas_status.get_text().startswith('Invalid bounds'), atlas_status.get_text()
assert mode.get_active() == 0
# Scroll-wheel zoom is handled by the actual canvas event controller path.
canvas = next(w for w in widgets if isinstance(w, Gtk.DrawingArea))
assert int(canvas.get_events()) & 10485760 == 10485760, 'Discrete and smooth scroll masks must both be subscribed'
device = Gdk.Display.get_default().get_default_seat().get_pointer()
def wheel(direction, dy=None):
    event=Gdk.Event.new(Gdk.EventType.SCROLL)
    event.window=canvas.get_window()
    event.send_event=True
    event.time=1000
    event.x=100
    event.y=100
    event.direction=direction
    if dy is not None:
        event.delta_y=dy
        event.delta_x=0
    event.set_device(device)
    canvas.event(event)
wheel(Gdk.ScrollDirection.UP)
assert abs(val('Zoom ×')-1.1)<1e-12
wheel(Gdk.ScrollDirection.DOWN)
assert abs(val('Zoom ×')-1)<1e-12
wheel(Gdk.ScrollDirection.LEFT)
assert val('Zoom ×')==1
wheel(Gdk.ScrollDirection.SMOOTH, -1)
assert abs(val('Zoom ×')-1.1)<1e-12
wheel(Gdk.ScrollDirection.SMOOTH, float('nan'))
assert abs(val('Zoom ×')-1.1)<1e-12
wheel(Gdk.ScrollDirection.SMOOTH, .5)
assert abs(val('Zoom ×')-1.1**.5)<1e-12
buttons['Reset view'].clicked()
for name in ['Show grid','Show axes','Show IK target']:
    buttons[name].set_active(False)
    drain()
    buttons[name].set_active(True)
    drain()
# Capture only synthetic test contents from the application's own tool page.
load(6)
buttons['Find sampled pose'].clicked()
notebook.set_current_page(3)
drain()
fixture.features_capture.argtypes = [ctypes.c_char_p]
assert fixture.features_capture(str(root/'evidence/pose-tools.png').encode()) == 0
window.destroy()
print('PASS: native pose undo/redo/branching, seven presets, constrained atlas search/apply, reverse branch, invalid/empty/stale results, camera views, wheel zoom, scene toggles')
