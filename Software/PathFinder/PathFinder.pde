class Punto{
  int x, y;
  Punto (int xpos, int ypos){
    x=xpos;
    y=ypos;
  }
}

ArrayList<ArrayList<Punto>> objetos= new ArrayList<ArrayList<Punto>>(); //este array contiene a los obstaculos, que son a su vez arrays de puntos
Punto origen = new Punto(540,360); //un punto colocado en el centro del mapa, mas adelante sera la posicion del robot
float a1,a2;
int max,min;
boolean cortado;  //determina si el camino esta cortado

void setup(){
  size(1080,720);
  stroke(0);
  textSize(20);
  textAlign(CENTER,CENTER);
  surface.setTitle("MovAut");
}

void draw(){
  cortado=false;
  background(255);
  
  a1=anguloY(mouseX,mouseY,origen.x,origen.y);
  
  for(int i=0;i<objetos.size();i++){  //recorre todos los objetos, calcula en cada uno de ellos cual es el punto mas a la derecha y a la izquierda, y determina si esta en medio de la ruta
    for(int j=0;j<objetos.get(i).size();j++){
      stroke(0);
      drawPoint(objetos.get(i).get(j));
      a2=anguloY(objetos.get(i).get(j),origen);
      max=angMax(a1,objetos.get(i));
      min=angMin(a1,objetos.get(i));
      line(origen,objetos.get(i).get(max));
      line(origen,objetos.get(i).get(min));
      if(angulo2(a1,anguloY(objetos.get(i).get(max),origen))*angulo2(a1,anguloY(objetos.get(i).get(min),origen))<0)
        cortado=true;
    }
  }
  
  fill(0);
  text("Haga click para añadir puntos. Los puntos demasiado cercanos serán ignorados.\nLos puntos cercanos formaran grupos.", width*0.5, height*0.1);
  
  if(cortado){ 
     stroke(255,0,0);
     drawPoint(origen);
     fill(255,0,0);
  }else{
    stroke(0,255,0);
    drawPoint(origen);
    fill(0,255,0);
  }
  line(origen.x,origen.y,mouseX,mouseY);
  text(a1*360.0/(2*PI),mouseX,mouseY);
}

void drawPoint(Punto p){  //dibuja un punto de una forma mas visual que point()
   fill(255);
   circle(p.x,p.y,6);
   circle(p.x,p.y,2);
}

void addPoint(int x, int y){ //añade un punto al grupo que este suficientemente cerca, en caso de que no lo haya crea uno para el nuevo punto
  boolean perteneceGrupo = false;
  boolean demasiadoCerca = false;
  int grupo=-1;
  for(int i=0;i<objetos.size();i++){ //este for comprueba que el punto no esta demasiado cerca a ningun otro grupo
    for(int j=0;j<objetos.get(i).size();j++){
      if(dist(objetos.get(i).get(j).x,objetos.get(i).get(j).y,x,y)<10)
        demasiadoCerca=true;
    }
    obstacles:
    for(int j=0;j<objetos.get(i).size();j++){
      if(dist(objetos.get(i).get(j).x,objetos.get(i).get(j).y,x,y)<20 && !demasiadoCerca){
        if(grupo==-1){  //si es el primer grupo al que se une, simplemente se une
          objetos.get(i).add(new Punto(x,y));
          grupo=i;
        }
        else{ //si ya se unió a otro grupo, une ambos grupos
          objetos.get(grupo).addAll(objetos.get(i));
          objetos.remove(i);
          i--;
        }
        perteneceGrupo = true;
        break obstacles;        
      }
    }
  }
  if(!perteneceGrupo && !demasiadoCerca){ //aqui se crea el nuevo grupo
    objetos.add(new ArrayList<Punto>());
    objetos.get(objetos.size()-1).add(new Punto(x,y));
  }
}

void line(Punto p1, Punto p2){ //como la funcion line, pero toma puntos en vez de coordenadas
  line(p1.x,p1.y,p2.x,p2.y);
}

float anguloY(int x1, int y1, int x2, int y2){ //mide el angulo entre una recta y el eje de abcisas
   float angulo = -1;
   if(x1>x2)
     angulo = atan(float(y2-y1)/float(x2-x1))+PI/2;
   if(x2>x1)
     angulo = atan(float(y2-y1)/float(x2-x1))+3*PI/2;
   if(x1==x2 && y2<y1)
     angulo = PI;
   if(x1==x2 && y2>y1)
     angulo = 0;
   return angulo;
}

float anguloY(Punto p1, Punto p2){ //hace lo mismo que el otro anguloY, pero coje puntos en vez de coordenadas
   float angulo = -1;
   if(p1.x>p2.x)
     angulo = atan(float(p2.y-p1.y)/float(p2.x-p1.x))+PI/2;
   if(p2.x>p1.x)
     angulo = atan(float(p2.y-p1.y)/float(p2.x-p1.x))+3*PI/2;
   if(p1.x==p2.x && p2.y<p1.y)
     angulo = PI;
   if(p1.x==p2.x && p2.y>p1.y)
     angulo = 0;
   return angulo;
}

float angulo2(float a1, float a2){ //mide la diferencia entre dos angulos, con valores entre -pi y pi
  float angulo=0;
  angulo = a2-a1;
  if(angulo>PI)
    angulo = angulo - 2*PI;
  if(angulo<-PI)
    angulo = angulo + 2*PI;
  return angulo;
}

int angMax(float a1,ArrayList<Punto> objeto){ //devuelve el indice del punto con la diferencia angular mayor respecto a un agulo a1
  int max= 0;
  float angMax, ang;
  angMax=angulo2(a1,anguloY(objeto.get(max),origen));
  for(int i=0;i<objeto.size();i++){
    ang=angulo2(a1,anguloY(objeto.get(i),origen));
    if(ang>angMax){
      max=i;
      angMax=angulo2(a1,anguloY(objeto.get(max),origen));
    }
  }
  return max;
}

int angMin(float a1,ArrayList<Punto> objeto){  //devuelve el indice del punto con la diferencia angular menor respecto a un agulo a1
  int min= 0;
  float angMin, ang;
  angMin=angulo2(a1,anguloY(objeto.get(min),origen));
  for(int i=0;i<objeto.size();i++){
    ang=angulo2(a1,anguloY(objeto.get(i),origen));
    if(ang<angMin){
      min=i;
      angMin=angulo2(a1,anguloY(objeto.get(min),origen));
    }
  }
  return min;
}

void mouseClicked(){
  addPoint(mouseX, mouseY); //añade puntos al hacer click;
}
