
import three;
import graph3; 
import tube;
import x11colors;
usepackage("mathpazo"); 
size(8cm);
settings.outformat="pdf";
settings.render=8;
draw(O--1.2*X,Arrow3());
draw(O--1.15*Y,Arrow3());
draw(O--1.1*Z,Arrow3());

currentprojection = perspective(5,2,2);
currentlight.background = rgb(0.98, 0.98, 0.9); 
  
real theta = pi/4; 

real f(pair p){ if (p.x == p.y && p.y == 0) {return 0.0;}
  return -p.x^2*p.y/(p.x^4 + p.y^2);
}

label("$\displaystyle{f(x,y) = -\frac{x^2y}{x^4+y^2}}$",(0,0,0.95),0.4*LightSeaGreen,align=3*E); 

surface s = surface(f,(-1,-1),(1,1),1000);
draw(s,LightSeaGreen);

shipout(bbox(3.0,invisible));
