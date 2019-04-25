class Punto{
  int x, y;
  Punto (int xpos, int ypos){
    x=xpos;
    y=ypos;
  }
}

Punto a = new Punto(300,300);
Punto b = new Punto(500,100);
Punto c = new Punto(100,75);
Punto d = new Punto(0,0);

void setup(){
  size(1080,720);
  stroke(0);
  textSize(20);
  textAlign(CENTER,CENTER);
  surface.setTitle("MovAut");
}

Punto f;

void draw(){
  d.x=mouseX;
  d.y=mouseY;
  background(255);
  drawPoint(a);
  drawPoint(b);
  drawPoint(c);
  drawPoint(d);
  line(a,b);
  line(c,d);
  f=corte(a,b,c,d);
  drawPoint(f);
  fill(0);
  text(f.x,50,50);
  text(f.y,100,50);  
}

void drawPoint(Punto p){  //dibuja un punto de una forma mas visual que point()
   fill(255);
   circle(p.x,p.y,6);
   circle(p.x,p.y,2);
}

void line(Punto p1, Punto p2){ //como la funcion line, pero toma puntos en vez de coordenadas
  line(p1.x,p1.y,p2.x,p2.y);
}

void mouseClicked(){
  switch(key){
    case 'a':
      a.x=mouseX;
      a.y=mouseY;
      break;
    case 'b':
      b.x=mouseX;
      b.y=mouseY;
      break;
    case 'c':
      c.x=mouseX;
      c.y=mouseY;
      break;
    case 'd':
      d.x=mouseX;
      d.y=mouseY;
      break;
  }
}

Punto corte(Punto a, Punto b, Punto c, Punto d){
  float m1=float(b.y-a.y)/float(b.x-a.x);
  float n1=float(a.y)-m1*float(a.x);
  float m2=float(d.y-c.y)/float(d.x-c.x);
  float n2=float(c.y)-m2*float(c.x);
  
  int x = (int)((n1-n2)/(m2-m1));
  int y = (int)(m1*x+n1);
  
  if(x>=min(a.x,b.x) && x<=max(a.x,b.x) && y>=min(a.y,b.y) && y<=max(a.y,b.y) &&
     x>=min(c.x,d.x) && x<=max(d.x,b.x) && y>=min(c.y,d.y) && y<=max(c.y,d.y))
    return new Punto (x,y);
  else
    return new Punto (0,0);
}
