
import graph3; 

void undersurface(picture pic=currentpicture,
		  real f(pair),
		  pair[] base, 
		  pen surfacepen=gray,
		  pen wirepen=black)
{
  triple embed(pair p) {return (p.x,p.y,0);}
  
  guide3 g = embed(base[0]);
  for(int i=1; i<base.length; ++i){
    g = g -- embed(base[i]);
  }
  
  draw(pic,surface(g--cycle),surfacepen); // draw base surface
  for(int i=1; i<base.length; ++i){
    path3 q = graph(new triple (real t) {
	pair pt = base[i-1]*t + base[i]*(1-t); 
	return (pt.x,pt.y,f(pt));
      },
      0,1,20); 
    draw(pic,surface(embed(base[i-1])--
		     embed(base[i])--
		     q--
		     cycle),surfacepen); // draw lateral surfaces
    draw(pic, q, wirepen); 
  }

  // draw edges
  for(int i=1; i<base.length; ++i){
    real x = base[i].x, y = base[i].y, z = f((x,y)); 
    draw(pic,(x,y,0)--(x,y,z),wirepen);
    draw(pic,embed(base[i])--embed(base[i-1]),wirepen);
  }
}

void test() {
  unitsize(1cm); 
  undersurface(new real(pair p) {return p.x^2 + p.y^2;},
	       new pair[] {(0,0), (1,0), (1,1), (0,1), (0,0)},
	       white+opacity(0.2),
	       blue
	       );
}

picture VectorPlot3D(path3 vector(triple t), triple a, triple b,
		     int nx=nmesh, int ny=nx, int nz=nx,bool truesize=false,
		     real maxlength=truesize ? 0 : min(abs(b.x-a.x)/nx,abs(b.y-a.y)/ny,abs(b.z-a.z)/nz),
		     real minlength=0.0, real lambda = 20.0, 
		     //  bool cond(pair z)=null,
		     pen p=currentpen,
		     arrowbar3 arrow=Arrow3, margin3 margin=PenMargin3,
		     string name="", render render=defaultrender)
{
  picture pic;
  real dx=1/nx;
  real dy=1/ny;
  real dz=1/nz;
  real scale;
  real size(triple t) {
    path3 g=vector(t);
    return abs(point(g,size(g)-1)-point(g,0));
  }
  real max=size((0,0,0));
  if(maxlength > 0) {
    for(int i=0; i <= nx; ++i) {
      real x=interp(a.x,b.x,i*dx);
      for(int j=0; j <= ny; ++j)
	{
	  real y=interp(a.y,b.y,j*dy);
	  for(int k=0; k <= nz; ++k)
	    max=max(max,size((x,y,interp(a.z,b.z,k*dz))));
	}}
    scale = max > 0 ? maxlength/max : 1;
  } else scale=1;
  real f(real t, real k) {
    return minlength + (maxlength-minlength)/(pi/2)*atan(k*t); 
  }
  bool group=name != "" || render.defaultnames;
  if(group)
    begingroup3(pic,name == "" ? "vectorfield" : name,render);
  for(int i=0; i <= nx; ++i) {
    real x=interp(a.x,b.x,i*dx);
    for(int j=0; j <= ny; ++j) {
      real y=interp(a.y,b.y,j*dy);
      for(int k=0; k <= nz; ++k)
	{
	  triple z=(x,y,interp(a.z,b.z,k*dz));
	  {
	    path3 g = scale3(scale)*vector(z);
	    triple v = point(g,size(g)-1); 
	    g = length(v) == 0 ? g : scale3(f(length(v),lambda)/length(v))*g; 
	    string name="vector";
	    if(truesize) {
	      picture opic;
	      draw(opic,g,p,arrow,margin,name,render);
	      add(pic,opic,z);
	    } else
	      draw(pic,shift(z)*g,p,arrow,margin,name,render);
	  }
	}
    }}
  if(group)
    endgroup3(pic);
  return pic;

}
