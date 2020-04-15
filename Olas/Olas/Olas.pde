/**
David Santiago Carreño 
1192757741
Taller 3 - Calidad del Aire en Bogotá. 
*/
import controlP5.*;

ControlP5 control;

int valSlider;

Boolean buton;

Table dataTable;

int rowCount;

PFont letraFuente;

String [] tiempo2;

int [] KennedyAire;
int datoKennedy = 0;

int [] SubaAire;
int datoSuba = 0;

int [] FontibonAire;
int datoFontibon = 0;

int [] FeriasAire;
int datoFerias = 0;

Slider2D sliderPunto;


void setup() {
  dataTable = loadTable("ctable.tsv", "header");
  rowCount = dataTable.getRowCount();
  letraFuente = loadFont("NunitoSans-SemiBold-30.vlw");
  textFont(letraFuente);
  println(rowCount);
   KennedyAire = new int [rowCount];
   FontibonAire = new int [rowCount];
   SubaAire = new int [rowCount];
   FeriasAire = new int [rowCount];
   tiempo2 = new String [rowCount];
 
    
   for(int i = 0; i < rowCount; i++)
  {
    //creamos un objeto que guarda la información de las filas de la tabla
    TableRow row = dataTable.getRow(i);
   tiempo2[i] = row.getString("Tiempo");
    KennedyAire[i]= row.getInt("Kennedy");
    FontibonAire[i]= row.getInt("Fontibon");
    SubaAire[i]= row.getInt("Suba");
    FeriasAire[i]= row.getInt("Las Ferias");
    //tercero
    
    
  }
  
  
  size(1366, 768);
  fill(0);
  noStroke();
  rectMode(CENTER);
  frameRate(60);
  
 
}

void draw() {
  textFont(letraFuente, 32);
  background(255);
   text("Cálidad del aire en Bogotá a través del tiempo", 360, 60);
    graphic();
    newGui();
}



void graphic(){
 for (int x = 20; x < 300; x += 20) {
    for (int y = 20; y < 300; y += 20) {
      float n = noise(x * 0.05, y * 0.05, frameCount * 0.05);
       fill(0);
      pushMatrix();
      translate(x,y);
      translate(80, 100);
      scale(8 * n);
      noiseDetail(KennedyAire[valSlider]/10, 1);
      ellipse(0, 0, 1, 1);
      popMatrix();
      text("Kennedy", 165, 450);
      text(KennedyAire[valSlider], 180, 550);
    }   
    
  }
  



 for (int x = 20; x < 300; x += 20) {
    for (int y = 20; y < 300; y += 20) {
      float n = noise(x * 0.05, y * 0.05, frameCount * 0.05);
       fill(0);
      pushMatrix();
      translate(x,y);
      translate(380, 100);
      scale(8 * n);
      ellipse(0, 0, 1, 1);
      noiseDetail(SubaAire[valSlider]/10, 1);
      popMatrix();
      text("Suba", 485, 450);
      text(SubaAire[valSlider], 500, 550);
    }

  }
  


 for (int x = 20; x < 300; x += 20) {
    for (int y = 20; y < 300; y += 20) {
      float n = noise(x * 0.05, y * 0.05, frameCount * 0.05);
       fill(0);
      pushMatrix();
      translate(x,y);
      translate(680, 100);
      scale(8 * n);
      noiseDetail(FontibonAire[valSlider]/10, 1);
      ellipse(0, 0, 1, 1);
      popMatrix();
      text("Fontibon", 770, 450);
      text(FontibonAire[valSlider], 810, 550);
    }  
    
  }
  


 for (int x = 20; x < 300; x += 20) {
    for (int y = 20; y < 300; y += 20) {
      float n = noise(x * 0.05, y * 0.05, frameCount * 0.05);
       fill(0);
      pushMatrix();
      translate(x,y);
      translate(980, 100);
      scale(8 * n);
      noiseDetail(FeriasAire[valSlider]/10, 1);
      ellipse(0, 0, 1, 1);
      popMatrix();
      text("Las Ferias", 1060, 450);
      text(FeriasAire[valSlider], 1110, 550);
    }
    
    
    
      for(int i = 0; i < rowCount; i++)
    { 
      float o = map(i, 0, rowCount-1, 30, 1254);
      text(tiempo2[i], o, 690);
      fill(#000000);
      pushMatrix();
      translate(o+60,370);
      rotate(PI/2);
      //se coloca el texto en cada linea
      //text(tiempo[i], 0, 0);
      popMatrix();      
    }
    
  }
  control = new ControlP5(this);
}

/*void botonKennedy(){
  control.addToggle("buton").setColorBackground(color(#464545))
  .setColorForeground(color(#939393)).setColorActive(color(#1A1919))
     .setPosition(370,70)
     .setSize(50,20); 
}*/

void newGui(){
   control.addSlider("valSlider")
     .setPosition(60,635)
     .setHeight(30)
     .setWidth(1250)
     .setRange(0,rowCount-1) 
     .setNumberOfTickMarks(rowCount)
     .setSliderMode(Slider.FLEXIBLE)
     .setColorBackground(color(#BFBFBF))
     .setColorValue(color(0, 0, 0))
      .setColorActive(color(0,0,0))
      .setColorForeground(color(#646464))
     ;
}
