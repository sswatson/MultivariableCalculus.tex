import graph;
picture vectorfieldmid(path vector(pair), pair a, pair b,
		       int nx=nmesh, int ny=nx, bool truesize=false,
		       real maxlength=truesize ? 0 : maxlength(a,b,nx,ny),
		       bool cond(pair z)=null, pen p=currentpen,
		       arrowbar arrow=Arrow, margin margin=PenMargin)
{
  picture pic;
  real dx=1/nx;
  real dy=1/ny;
  bool all=cond == null;
  real scale;

  if(maxlength > 0) {
    real size(pair z) {
      path g=vector(z);
      return abs(point(g,size(g)-1)-point(g,0));
    }
    real max=size(a);
    for(int i=0; i <= nx; ++i) {
      real x=interp(a.x,b.x,i*dx);
      for(int j=0; j <= ny; ++j)
	max=max(max,size((x,interp(a.y,b.y,j*dy))));
    }
    scale=max > 0 ? maxlength/max : 1;
  } else scale=1;

  for(int i=0; i <= nx; ++i) {
    real x=interp(a.x,b.x,i*dx);
    for(int j=0; j <= ny; ++j) {
      real y=interp(a.y,b.y,j*dy);
      pair z=(x,y);
      if(all || cond(z)) {
	path g=scale(scale)*vector(z);
	if(truesize)
	  draw(z,pic,g,p,arrow);
	else
	  draw(pic,shift(-point(g,size(g)-1)/2)*shift(z)*g,p,arrow,margin);
      }
    }
  }
  return pic;
}
