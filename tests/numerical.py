import ctypes as C, math as m, random
lib=C.CDLL('./build/libbone-ik.so'); A=C.c_double*8; O=C.c_double*25
for f in (lib.ik_solve,lib.fk_solve): f.argtypes=[C.POINTER(C.c_double)]*2; f.restype=C.c_int
count=0
def run(v,f=lib.ik_solve):
 o=O(); assert f(A(*v),o)==1; assert all(m.isfinite(x) for x in o); return o
def close(a,b,tol=1e-7): assert abs(a-b)<=tol*max(1,abs(a),abs(b)),(a,b)
def check(v):
 global count
 o=run(v); l1,l2=v[3:5]; e=list(o[9:12]); w=list(o[12:15])
 close(m.dist(e,[0,0,0]),l1);close(m.dist(e,w),l2)
 close(o[15],m.dist(w,v[:3])); assert v[5]-1e-12<=o[4]<=v[6]+1e-12
 # Independent radial closest-distance oracle, stable near folded chains.
 radii=[m.hypot(l1-l2,2*m.sqrt(l1*l2)*m.cos(a/2)) for a in (v[6],v[5])]
 r=m.hypot(*v[:3]); expected=max(radii[0]-r,0,r-radii[1]);close(o[15],expected)
 count+=1
for target in [(2,0,0),(1,0,1),(0,0,0),(0,0,2),(0,0,-2),(-1,-1,-1),(5,2,3),(1e-12,0,0)]:
 for lengths in [(1,1),(2,1),(1,2)]:
  for limits in [(0,m.pi),(.2,2.6),(1,1)]:
   for branch in [-1,1]:check([*target,*lengths,*limits,branch])
rng=random.Random(104)
for _ in range(3000):
 l1,l2=[rng.uniform(.01,20) for _ in range(2)]; lo=rng.uniform(0,1);hi=rng.uniform(lo,m.pi)
 check([*[rng.uniform(-40,40) for _ in range(3)],l1,l2,lo,hi,rng.choice([-1,1])])
 # Independent FK geometry and IK round-trip.
 yaw=rng.uniform(-m.pi,m.pi);pitch=rng.uniform(-m.pi,m.pi);phi=rng.uniform(lo,hi);b=rng.choice([-1,1])
 v=[yaw,pitch,phi,l1,l2,lo,hi,b];o=run(v,lib.fk_solve)
 e=[l1*m.cos(pitch)*m.cos(yaw),l1*m.cos(pitch)*m.sin(yaw),l1*m.sin(pitch)]
 w=[e[0]+l2*m.cos(pitch-b*phi)*m.cos(yaw),e[1]+l2*m.cos(pitch-b*phi)*m.sin(yaw),e[2]+l2*m.sin(pitch-b*phi)]
 for a,c in zip(o[9:15],e+w):close(a,c)
 inv=run([*w,l1,l2,lo,hi,b]);close(inv[15],0);count+=1
for i,value in [(0,float('nan')),(1,float('inf')),(3,0),(4,-1),(5,-.1),(6,4),(7,0),(0,1e9)]:
 v=[1,1,1,2,1,0,m.pi,1];v[i]=value;o=O(*([9]*25));assert lib.ik_solve(A(*v),o)==0;assert list(o)==[0]*25
v=[0,0,2,1,1,0,1,1];assert lib.fk_solve(A(*v),O())==0
p=C.CDLL('./build/libprojection.so').project;p.argtypes=[C.POINTER(C.c_double)]*3
for _ in range(1000):
 x,y,z,a,e=[rng.uniform(-5,5) for _ in range(5)];s=rng.uniform(1,200);o=(C.c_double*3)();p((C.c_double*3)(x,y,z),(C.c_double*5)(a,e,s,310,260),o)
 close(o[0],310+s*(-m.sin(a)*x+m.cos(a)*y));close(o[1],260-s*(m.cos(e)*z-m.sin(e)*(m.cos(a)*x+m.sin(a)*y)))
 close(o[2],m.cos(e)*(m.cos(a)*x+m.sin(a)*y)+m.sin(e)*z)
 close(((o[0]-310)/s)**2+((o[1]-260)/s)**2+o[2]**2,x*x+y*y+z*z)
# Regression: near-folded cases previously lost the small target radius.
for length,target in [(10,1e-7),(1e6,.1),(1e6,1e-7)]:
 o=run([target,0,0,length,length,0,m.pi,1]);close(o[15],0,1e-8)
 flags=C.cast(C.byref(o,192),C.POINTER(C.c_uint64))[0]
 assert flags & 1 == 0, (length,target,flags,o[15])
o=run([0,0,0,1e6,999999.999,0,m.pi,1]);close(o[16],.001,1e-8)
print(f'PASS: {count} IK/FK cases, invalid-input rejection, 1000 projection/orbit cases')
