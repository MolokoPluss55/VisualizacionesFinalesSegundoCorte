/**
Jessica Fernanda Cifuentes Jaramillo
100051413
Taller 3 - Vehículos en Bogotá. 
*/

 //ESTILO
  PFont fuente;
  PFont fuente2;
  PFont fuente3;

//CONTROL P5
  import controlP5.*;
  ControlP5 cp5;
  int valorSlider;
  
  boolean [] vis;
//VARIABLES PARA LA LECTURA DE DATOS  
  boolean unaVez = false;
  boolean unaVezS = false;
  boolean unaVezK = false;
  boolean unaVezB = false;
  boolean unaVezE = false;
  
  
  ArrayList<Particle> m; //Partículas en sí mismas 
  ArrayList<ParticleBig> b; //Partículas en sí mismas 
  ArrayList<ParticleBig> a1;
  ArrayList<ParticleBig> a2;
  ArrayList<ParticleBig> a3;
  ArrayList<ParticleBig> a4;
  ArrayList<ParticleBig> a5;
  ArrayList<ParticleBig> a6;
  ArrayList<ParticleBig> a7;
  ArrayList<ParticleBig> a8;
  ArrayList<ArrayList<ParticleBig>> padre;
  //Cantidad de Partículas
  float spdLimit = 230; //Velocidad de las partículas 
    float spdLimit2 = 800;
  float girar;
  //el valor en donde se encuentra el slider

  //numero de filas en el archivo
  int rowCount;

  //columna tiempo
  String [] tiempo; 
  
  Table tabla;

  //columna total
  int [] totalC;
  
  //columna suba
  int [] subaC;
  
  //columna kennedy
  int [] kennedyC;
  
  //columna bosa
  int [] bosaC;
  
  //columna engativá
  int [] engativaC;
  
  //DATO TOTAL, respecto a lo que hace el slider
  int datoTotal;
  
  //VARIBALES PARA DISTINTAS PÁGINAS

  int numPagina;
  int MAX_PAG;
   
  Boton continuar, total, localidades;
  
 
 void setup(){
   size(1280, 768);
   colorMode(HSB, 360, 100, 100);
  
  fuente = loadFont("NunitoSans-Bold-32.vlw");
  fuente2 = loadFont("NunitoSans-SemiBold-26.vlw");
  fuente3 = loadFont("NunitoSans-Light-15.vlw");
  
  tabla = loadTable("vehiculosBogota.csv", "header");
  rowCount = tabla.getRowCount();
  println(rowCount + " filas en la tabla");
  
  tiempo = new String [rowCount];
  
  totalC = new int [rowCount];
  
  subaC = new int [rowCount];
  
  bosaC = new int [rowCount];
  
  engativaC = new int [rowCount];
  
  kennedyC = new int [rowCount];
  
  vis = new boolean[8];
 
  
  
  vis[0] = false;
  vis[1] = false;
  vis[2] = false;
  vis[3] = false;
  vis[4] = false;
  vis[5] = false;
  vis[6] = false;
  vis[7] = false;
  
  
    for(int i = 0; i < rowCount; i++)
  {
    //creamos un objeto que guarda la información de las filas de la tabla
    //creamos un objeto que guarda la información de las filas de la tabla
    TableRow row = tabla.getRow(i);
    
    tiempo[i] = row.getString("tiempo");
    
    totalC[i]= row.getInt("total");
    
    subaC[i]= row.getInt("suba");
    
    kennedyC[i]= row.getInt("kennedy");
    
    bosaC[i]= row.getInt("bosa");
    
    engativaC[i]= row.getInt("engativa");
  
  }
  

  
  textAlign(CENTER, CENTER);
  
  color colorB1 = color(0,0,100);
  color colorT1 = color(0,0,0);
  
  // texto, radio de la esquina, posición en x, posición en y, color estático, color en hover, color de texto
  continuar = new Boton("CONTINUAR", 13, width/2-50, height/2+90, colorB1, #37c9ef, colorT1);
  total = new Boton("TOTAL", 13, width/2-500, 240, 0, #2b2827, colorB1);
  localidades = new Boton("LOCALIDADES", 13, width/2-500, 400, 0, #2b2827, colorB1);
  
    
 //Lista de arreglo que contiene a las partículas
     m = new ArrayList<Particle>();
     b = new ArrayList<ParticleBig>();
     a1 = new ArrayList<ParticleBig>();
     a2 = new ArrayList<ParticleBig>();
     a3 = new ArrayList<ParticleBig>();
     a4 = new ArrayList<ParticleBig>();
     a5 = new ArrayList<ParticleBig>();
     a6 = new ArrayList<ParticleBig>();
     a7 = new ArrayList<ParticleBig>();
     a8 = new ArrayList<ParticleBig>();
     padre = new ArrayList<ArrayList<ParticleBig>>();
    
     cp5 = new ControlP5(this);  

      gui();
  

 }
 
 void draw(){
     background(0,0,0); 
       
     if (numPagina == 0) {
       continuar.mostrarBoton();
     }
     if (numPagina > 0) {
       background(0,0,100);
       total.mostrarBoton();
       localidades.mostrarBoton();
     }
    method("pagina" + numPagina);
    
    
    for (Particle a : m) {
      a.update();
      a.draw();
    }
    
    for (ParticleBig q : b) {
      q.update();
      q.draw();
    }
    if(vis[0]){
      for (ParticleBig q : a1) {
        q.update();
        q.draw();
      }
    }
    if(vis[1]){  
      for (ParticleBig q : a2) {
        q.update();
        q.draw();
      }
    }
    if(vis[2]){  
      for (ParticleBig q : a3) {
        q.update();
        q.draw();
      }
    }
    if(vis[3]){ 
      for (ParticleBig q : a4) {
        q.update();
        q.draw();
      }
    }
    if(vis[4]){
      for (ParticleBig q : a5) {
        q.update();
        q.draw();
      }
    }
    if(vis[5]){
      for (ParticleBig q : a6) {
      q.update();
      q.draw();
    }
   }
    if(vis[6]){
      for (ParticleBig q : a7) {
      q.update();
      q.draw();
      }
    }
    if(vis[7]){
      for (ParticleBig q : a8) {
        q.update();
        q.draw();
      }
    }
      
     //seleccionarPagina();
 }
 
 
 //Método que evalúa si los botones son presionados y a dónde enviarlos. 
 void mousePressed() {
  if (numPagina == 0 && continuar.sobreBoton) {
    numPagina = 1;
    total.colorUno =  #2b2827;
    localidades.colorUno =  0;
    
  }
  else if (numPagina >= 1  && localidades.sobreBoton){
    numPagina = 2;
    localidades.colorUno =  #2b2827;
    total.colorUno =  0;
    
    
  } 
   else if (numPagina >= 1  && total.sobreBoton){
    
    numPagina = 1;
    total.colorUno =  #2b2827;
    localidades.colorUno =  0;
    
  } 
}

void mouseMoved() {
  continuar.isHovering();
  localidades.isHovering();
  total.isHovering();
  redraw();
}

 void pagina0(){
   mostrarSlider();
   pushMatrix();
   fill(0,0,100);
   textFont(fuente);
   text("El 45% de los Bogotanos considera a la mala ", width/2, 280);
   text("calidad del aire como el principal problema", width/2, 330);
   text("ambiental de la ciudad.", width/2, 380);
   popMatrix();
   
 }
 
  void pagina1(){
    mostrarSlider();
    fill(0);
    pushMatrix();
    textSize(30);
    textFont(fuente);
    text("Cantidad de Vehículos en Bogotá", width/2, 80);
   //mostrarParticulas(b, 3, width/2, height/2-40, width/2, height/2);
   //verParticulasPrin();
  verParticulasPrin();

    popMatrix();

     //Se crearán la cantidad de partículas que se especifiquen en count. AQUÍ SE DEBEN LEER LOS DATOS. 

 }
  void pagina2(){
    mostrarSlider();
    fill(0);
    stroke(0,0,0);
    strokeWeight(2);
    line(width/2, 150, width/2, 550);
    strokeWeight(2);
    line(430, height/2-40, 830, height/2-40);
    pushMatrix();
    textFont(fuente);
    textSize(32);
    text("Cantidad de Vehículos en el 2017", width/2, 80);
    textFont(fuente2);
    textSize(20);
    text("SUBA", width/2-250, 180);
    text(subaC[7], width/2-250, 200);
    text("KENNEDY", width/2+250, 180);
    text(kennedyC[7], width/2+250, 200);
    text("BOSA", width/2-250, 530);
    text(bosaC[7], width/2-250, 550);
    text("ENGATIVÁ", width/2+250, 530);
    text(engativaC[7], width/2+250, 550);
    popMatrix();
    textSize(16);
    mostrarParticulasS(m, subaC, 3, width/2, height/2-40, width/2-120, 220);
    mostrarParticulasK(m, kennedyC, 3, width/2, height/2-40, width/2+120, 220);
    mostrarParticulasB(m, bosaC, 2, width/2, height/2-40, width/2-120, 450);
    mostrarParticulasE(m, engativaC, 2, width/2, height/2-40, width/2+120, 450);
 }
 
 /* for (int i = 0; i<subaC[7]/1000; i++) {
      m.add(new Particle(theme, width/2,height/2-40, width/2-120, 220));
    }
    for (int i = 0; i<kennedyC[7]/1000; i++) {
      m.add(new Particle(2, width/2,height/2-40, width/2+120, 220));
    }
    for (int i = 0; i<bosaC[7]/1000; i++) {
      m.add(new Particle(2, width/2,height/2-40, width/2-120, 450));
    }
    for (int i = 0; i<engativaC[7]/1000; i++) {
      m.add(new Particle(2, width/2,height/2-40, width/2+120, 450));
    }*/
  
  
 /*
 Creación de la clase botón. 
 Esta clase recibe texto, radio de la esquina, posición en x, posición en y, color estático, color en hover, color de texto
 */
class Boton{
  static final int widthB = 130;
  static final int heightB = 40;
  
  final String texto;
  final int x, y, hoverW, hoverH;
  boolean sobreBoton;
  final int radio;
  color colorUno;
  final color colorDos;
  final color colorTxt;
  
  Boton(String textoBoton, int radBoton, int posX, int posY, color colorEstatico, color colorHover, color colorTexto){
    texto = textoBoton;
    x = posX;
    y = posY;
    radio = radBoton;
    colorUno = colorEstatico;
    colorDos = colorHover;
    colorTxt = colorTexto;
    
    //Define la zona en la que se hará hover 
    hoverW = posX + widthB;
    hoverH = posY + heightB;
   
  }
  
  void mostrarBoton(){
    noStroke();
    fill(colorUno);
    rect(x,y, widthB, heightB, radio);
    fill(colorTxt);
    textSize(14);
    text(texto, x + widthB/2, y + heightB/2);
  }
  
  //Este método evalúa si el mouse está sobre el área del botón. 
  boolean isHovering() {
    return sobreBoton = mouseX > x & mouseX < hoverW & mouseY > y & mouseY < hoverH;
  }
 
}

//CREACIÓN DE PARTÍCULAS
class Particle {

  PVector prev, pos, mouse = new PVector(), spd, acc;
  color col;
  //FORMA EN LA QUE GIRAN LA PARTÍCULAS EN UNA POSICIÓN ESTÁTICA
  int iX;
  int iY;
  int fX;
  int fY;
  int colorTheme;
  float turnFactor = random(3,10);

  public Particle(int tema, int inicioX, int inicioY, int finX, int finY) {
    iX = inicioX;
    iY = inicioY;
    fX = finX;
    fY = finY;
    pos = new PVector(iX, iY);//PUNTO DE INICIO
    //LARGO de la línea
    prev = new PVector(pos.x, pos.y);
    spd = new PVector(random(2), random(2));
    acc = new PVector();
    colorTheme = tema;

    //DEFINICIÓN DE COLOR
    switch(colorTheme) {
        case 1:
            col = color(random(320, 420) % 360, 90, 100);
            break;
        case 2:
            col = color(random(155, 210), random(40, 100), 100);
            break;
        case 3:
            col = color(random(45), 90, 100);
            break;
        default:
            col = color(random(360), 90, 100);
            break;
    }

  }

  void update() {
    if(numPagina == 2){
      prev = new PVector(pos.x, pos.y);
    if (pos.x > width || pos.x < 0) {
      spd.x *= -0.9;
    }
    if (pos.y < 0 || pos.y > height ) {
      spd.y *= -0.9;
    }
    mouse.set(mouseX, mouseY);
    PVector attraction = new PVector(fX, fY);
    attraction.sub(pos);
    acc.set(attraction);
    acc.normalize();
    acc.div(turnFactor);
    spd.add(acc);
    spd.limit(spdLimit * (1f/60));
    pos.add(spd);
    }
  }

  void draw() {

    //noStroke();
    //fill(col);
    //ellipse(pos.x, pos.y, size, size);
    //ellipse(pos.x, pos.y, size, size);
    if(numPagina == 2) {
       stroke(col);
    strokeWeight(6);
    line(prev.x, prev.y, pos.x, pos.y);
    }
   
  }
  
}




//CREACIÓN DE PARTÍCULAS
class ParticleBig {

  PVector prev, pos, mouse = new PVector(), spd, acc;
  color col;
  //FORMA EN LA QUE GIRAN LA PARTÍCULAS EN UNA POSICIÓN ESTÁTICA
  int iX;
  int iY;
  int fX;
  int fY;
  int colorTheme;
  float turnFactor = random(8,20);
  int cantidad = totalC[valorSlider];

  public ParticleBig(int tema, int inicioX, int inicioY, int finX, int finY) {
    iX = inicioX;
    iY = inicioY;
    fX = finX;
    fY = finY;
    pos = new PVector(iX, iY);//PUNTO DE INICIO
    //LARGO de la línea
    prev = new PVector(pos.x, pos.y);
    spd = new PVector(random(3), random(3));
    acc = new PVector();
    colorTheme = tema;

    //DEFINICIÓN DE COLOR
    switch(colorTheme) {
        case 1:
            col = color(random(320, 420) % 360, 90, 100);
            break;
        case 2:
            col = color(random(155, 210), random(40, 100), 100);
            break;
        case 3:
            col = color(random(45), 90, 100);
            break;
        default:
            col = color(random(360), 90, 100);
            break;
    }

  }

  void update() {
    if(numPagina == 1){
      prev = new PVector(pos.x, pos.y);
    if (pos.x > width || pos.x < 0) {
      spd.x *= -0.9;
    }
    if (pos.y < 0 || pos.y > height ) {
      spd.y *= -0.9;
    }
    mouse.set(mouseX, mouseY);
    PVector attraction = new PVector(fX, fY);
    attraction.sub(pos);
    acc.set(attraction);
    acc.normalize();
    acc.div(turnFactor);
    spd.add(acc);
    spd.limit(spdLimit2 * (1f/60));
    pos.add(spd);
    }
  }

  void draw() {

    //noStroke();
    //fill(col);
    //ellipse(pos.x, pos.y, size, size);
    //ellipse(pos.x, pos.y, size, size);
    if(numPagina == 1) {
       stroke(col);
    strokeWeight(6);
    line(prev.x, prev.y, pos.x, pos.y);
    }
   
  }
  
  
}

void mostrarParticulasB(ArrayList<Particle> miau, int [] loc, int theme, int begX, int begY, int endX, int endY){
  if(unaVezB == false){
    for (int i = 0; i<loc[7]/1000; i++) {
      miau.add(new Particle(theme, begX, begY, endX, endY));
    }
  }
  unaVezB = true;
    

 /* for (int i = 0; i<subaC[7]/1000; i++) {
      m.add(new Particle(theme, width/2,height/2-40, width/2-120, 220));
    }
    for (int i = 0; i<kennedyC[7]/1000; i++) {
      m.add(new Particle(2, width/2,height/2-40, width/2+120, 220));
    }
    for (int i = 0; i<bosaC[7]/1000; i++) {
      m.add(new Particle(2, width/2,height/2-40, width/2-120, 450));
    }
    for (int i = 0; i<engativaC[7]/1000; i++) {
      m.add(new Particle(2, width/2,height/2-40, width/2+120, 450));
    }*/
}
void mostrarParticulasK(ArrayList<Particle> miau, int [] loc, int theme, int begX, int begY, int endX, int endY){
  if(unaVezK == false){
    for (int i = 0; i<loc[7]/900; i++) {
      miau.add(new Particle(theme, begX, begY, endX, endY));
    }
  }
  unaVezK = true;
    
}
void mostrarParticulasS(ArrayList<Particle> miau, int [] loc, int theme, int begX, int begY, int endX, int endY){
  if(unaVezS == false){
    for (int i = 0; i<loc[7]/800; i++) {
      miau.add(new Particle(theme, begX, begY, endX, endY));
    }
  }
  unaVezS = true;
    

 /* for (int i = 0; i<subaC[7]/1000; i++) {
      m.add(new Particle(theme, width/2,height/2-40, width/2-120, 220));
    }
    for (int i = 0; i<kennedyC[7]/1000; i++) {
      m.add(new Particle(2, width/2,height/2-40, width/2+120, 220));
    }
    for (int i = 0; i<bosaC[7]/1000; i++) {
      m.add(new Particle(2, width/2,height/2-40, width/2-120, 450));
    }
    for (int i = 0; i<engativaC[7]/1000; i++) {
      m.add(new Particle(2, width/2,height/2-40, width/2+120, 450));
    }*/
}
void mostrarParticulasE(ArrayList<Particle> miau, int [] loc, int theme, int begX, int begY, int endX, int endY){
  if(unaVezE == false){
    for (int i = 0; i<loc[7]/800; i++) {
      miau.add(new Particle(theme, begX, begY, endX, endY));
    }
  }
  unaVezE = true;
   
}


void verParticulasPrin(){
     
     for (int i = 0; i < totalC[0]/1000000; i++){
       a1.add(new ParticleBig(2, width/2-50, height/2+10, width/2, height/2-80));
       println(totalC[1]/1000000);
     }
     for (int i = 0; i < totalC[1]/1000000; i++){
       a2.add(new ParticleBig(2, width/2-50, height/2+10, width/2, height/2-80));
       println(totalC[1]/1000000);
     }
     for (int i = 0; i < totalC[2]/1000000; i++){
       a3.add(new ParticleBig(2, width/2-50, height/2+10, width/2, height/2-80));
       println(totalC[2]/1000000);
     }
     for (int i = 0; i < totalC[3]/1000000; i++){
       a4.add(new ParticleBig(2, width/2-50, height/2+10, width/2, height/2-80));
       println(totalC[3]/1000000);
     }
     for (int i = 0; i < totalC[4]/1000000; i++){
       a5.add(new ParticleBig(1, width/2-70, height/2+10, width/2, height/2-80));
       println(totalC[4]/1000000);
     }
     for (int i = 0; i < totalC[5]/1000000; i++){
       a6.add(new ParticleBig(1, width/2-70, height/2+10, width/2, height/2-80));
       println(totalC[5]/1000000);
     }
     for (int i = 0; i < totalC[6]/1000000; i++){
       a7.add(new ParticleBig(3, width/2-70, height/2+10, width/2, height/2-80));
       println(totalC[6]/1000000);
     }
     for (int i = 0; i < totalC[7]/1000000; i++){
       a8.add(new ParticleBig(3, width/2-70, height/2+10, width/2, height/2-80));
       println(totalC[7]/1000000);
     }
     
     padre.add(a1);
     padre.add(a2);
     padre.add(a3);
     padre.add(a4);
     padre.add(a5);
     padre.add(a6);
     padre.add(a7);
     padre.add(a8);
     
    if(valorSlider == 0){
        vis[0] = true;
        vis[1] = false;
        vis[3] = false;
        vis[4] = false;
        vis[5] = false;
        vis[6] = false;
        vis[7] = false;
        padre.get(0);
    }
    else if(valorSlider == 1){
        vis[0] = false;
        vis[1] = true;
        vis[3] = false;
        vis[4] = false;
        vis[5] = false;
        vis[6] = false;
        vis[7] = false;
      padre.get(0);
    }
    else if(valorSlider == 2){
        vis[0] = false;
        vis[1] = false;
        vis[3] = true;
        vis[4] = false;
        vis[5] = false;
        vis[6] = false;
        vis[7] = false;
      padre.get(0);
    }
    else if(valorSlider == 3){
        vis[0] = false;
        vis[1] = false;
        vis[3] = true;
        vis[4] = false;
        vis[5] = false;
        vis[6] = false;
        vis[7] = false;
      padre.get(0);
    }
    else if(valorSlider == 4){
        vis[0] = false;
        vis[1] = false;
        vis[3] = false;
        vis[4] = true;
        vis[5] = false;
        vis[6] = false;
        vis[7] = false;
      padre.get(0);
    }
    else if(valorSlider == 5){
        vis[0] = false;
        vis[1] = false;
        vis[3] = false;
        vis[4] = false;
        vis[5] = true;
        vis[6] = false;
        vis[7] = false;
      padre.get(0);
    }
    else if(valorSlider == 6){
        vis[0] = false;
        vis[1] = false;
        vis[3] = false;
        vis[4] = false;
        vis[5] = false;
        vis[6] = true;
        vis[7] = false;
      padre.get(0);
    }
    else if(valorSlider == 7){
        vis[0] = false;
        vis[1] = false;
        vis[3] = false;
        vis[4] = false;
        vis[5] = false;
        vis[6] = false;
        vis[7] = true;
      padre.get(0);
    }
}



//FUNCIONES DE SLIDER
void gui()
{ 
     cp5.addSlider("valSlider")
     .setPosition(400,600)
     .setWidth(600)
     .setRange(0,7)
     .setValue(0)
     .setNumberOfTickMarks(8)
     .setSliderMode(Slider.FLEXIBLE)
     .setColorForeground(color(255))
     .setColorActive(color(#37c9ef))
     .setColorBackground(color (0,0,0));
     ;       
}

//segundo
//función que se ejecuta cuando el slider se mueve 
    void valSlider(int valor ) 
    { 
      //el valor en donde se encuentra el slider
      valorSlider = valor;
      println(valorSlider + "    " + datoTotal);
      unaVez = false;
     
    }
    
    void mostrarSlider(){
       if(numPagina != 1){
           cp5.get("valSlider").hide();
       }
       else {
         cp5.get("valSlider").show();
       for(int i = 0; i < rowCount; i++)
       { 
        float x = map(i, 0, rowCount-1, 250, 840);
        pushMatrix();
        fill(0);
        translate(x,35);
        rotate(PI/2);
        text(tiempo[i],620,-160);
        popMatrix();    
        
        fill(0);
        text("Total de Vehículos: "+totalC[valorSlider], 690, 550);
       } 
     }
    }
