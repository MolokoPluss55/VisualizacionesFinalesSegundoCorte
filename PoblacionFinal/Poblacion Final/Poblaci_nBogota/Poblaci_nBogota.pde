/**
 Cristián Sebastián Zorrilla
 1072673236
 Taller 3 - Población en Bogotá
*/
import controlP5.*;
ControlP5 cp55;

Table datos;

int valSlider;

int rowCount;

String [] tiempo;

int [] kennedy;

int maxDato;

boolean toggleValue = false;

PImage mapImage;

/*
Particles text effects
 
Controls:
- Left-click for a new word.
- Drag right-click over particles to interact with them.
- Press any key to toggle draw styles.

Thanks to Daniel Shiffman for explanation on arrival behavior (shiffman.net)
Author: Jason Labbe
Site: jasonlabbe3d.com
*/


// Global variables
ArrayList<Particle> particles = new ArrayList<Particle>();
int pixelSteps = 6; // Amount of pixels to skip
boolean drawAsPoints = false;
ArrayList<String> words = new ArrayList<String>();
int wordIndex = 0;
color bgColor = color(255, 100);
String fontName = "Arial Bold";


class Particle {
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  PVector target = new PVector(0, 0);

  float closeEnoughTarget = 50;
  float maxSpeed = 4.0;
  float maxForce = 0.1;
  float particleSize = 5;
  boolean isKilled = false;

  color startColor = color(0);
  color targetColor = color(0);
  float colorWeight = 0;
  float colorBlendRate = 0.025;

  void move() {
    // Check if particle is close enough to its target to slow down
    float proximityMult = 1.0;
    float distance = dist(this.pos.x, this.pos.y, this.target.x, this.target.y);
    if (distance < this.closeEnoughTarget) {
      proximityMult = distance/this.closeEnoughTarget;
    }

    // Add force towards target
    PVector towardsTarget = new PVector(this.target.x, this.target.y);
    towardsTarget.sub(this.pos);
    towardsTarget.normalize();
    towardsTarget.mult(this.maxSpeed*proximityMult);

    PVector steer = new PVector(towardsTarget.x, towardsTarget.y);
    steer.sub(this.vel);
    steer.normalize();
    steer.mult(this.maxForce);
    this.acc.add(steer);

    // Move particle
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }

  void draw() {
    // Draw particle
    color currentColor = lerpColor(this.startColor, this.targetColor, this.colorWeight);
    if (drawAsPoints) {
      stroke(currentColor);
      point(this.pos.x, this.pos.y);
    } else {
      noStroke();
      fill(currentColor);
      ellipse(this.pos.x, this.pos.y, this.particleSize, this.particleSize);
    }

    // Blend towards its target color
    if (this.colorWeight < 1.0) {
      this.colorWeight = min(this.colorWeight+this.colorBlendRate, 1.0);
    }
  }

  void kill() {
    if (! this.isKilled) {
      // Set its target outside the scene
      PVector randomPos = generateRandomPos(width/2, height/2, (width+height)/2);
      this.target.x = randomPos.x;
      this.target.y = randomPos.y;

      // Begin blending its color to black
      this.startColor = lerpColor(this.startColor, this.targetColor, this.colorWeight);
      this.targetColor = color(0);
      this.colorWeight = 0;

      this.isKilled = true;
    }
  }
}


// Picks a random position from a point's radius
PVector generateRandomPos(int x, int y, float mag) {
  PVector sourcePos = new PVector(x, y);
  PVector randomPos = new PVector(random(0, width), random(0, height));

  PVector direction = PVector.sub(randomPos, sourcePos);
  direction.normalize();
  direction.mult(mag);
  sourcePos.add(direction);

  return sourcePos;
}


// Makes all particles draw the next word
void nextWord(String word) {
  // Draw word in memory
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  pg.fill(0);
  pg.textSize(100);
  pg.textAlign(CENTER);
  PFont font = createFont(fontName, 100);
  pg.textFont(font);
  pg.text(word, width/2, height/2);
  pg.endDraw();
  pg.loadPixels();

  // Next color for all pixels to change to
  color newColor = color(random(0.0, 255.0), random(0.0, 255.0), random(0.0, 255.0));

  int particleCount = particles.size();
  int particleIndex = 0;

  // Collect coordinates as indexes into an array
  // This is so we can randomly pick them to get a more fluid motion
  ArrayList<Integer> coordsIndexes = new ArrayList<Integer>();
  for (int i = 0; i < (width*height)-1; i+= pixelSteps) {
    coordsIndexes.add(i);
  }

  for (int i = 0; i < coordsIndexes.size (); i++) {
    // Pick a random coordinate
    int randomIndex = (int)random(0, coordsIndexes.size());
    int coordIndex = coordsIndexes.get(randomIndex);
    coordsIndexes.remove(randomIndex);
    
    // Only continue if the pixel is not blank
    if (pg.pixels[coordIndex] != 0) {
      // Convert index to its coordinates
      int x = coordIndex % width;
      int y = coordIndex / width;

      Particle newParticle;

      if (particleIndex < particleCount) {
        // Use a particle that's already on the screen 
        newParticle = particles.get(particleIndex);
        newParticle.isKilled = false;
        particleIndex += 1;
      } else {
        // Create a new particle
        newParticle = new Particle();
        
        PVector randomPos = generateRandomPos(width/2, height/2, (width+height)/2);
        newParticle.pos.x = randomPos.x;
        newParticle.pos.y = randomPos.y;
        
        newParticle.maxSpeed = random(2.0, 5.0);
        newParticle.maxForce = newParticle.maxSpeed*0.025;
        newParticle.particleSize = random(3, 6);
        newParticle.colorBlendRate = random(0.0025, 0.03);
        
        particles.add(newParticle);
      }
      
      // Blend it from its current color
      newParticle.startColor = lerpColor(newParticle.startColor, newParticle.targetColor, newParticle.colorWeight);
      newParticle.targetColor = newColor;
      newParticle.colorWeight = 0;
      
      // Assign the particle's new target to seek
      newParticle.target.x = x;
      newParticle.target.y = y;
    }
  }

  // Kill off any left over particles
  if (particleIndex < particleCount) {
    for (int i = particleIndex; i < particleCount; i++) {
      Particle particle = particles.get(i);
      particle.kill();
    }
  }
}


void setup() { 
  datos = loadTable("datos.csv", "header");
  size(1280,768);
  rowCount = datos.getRowCount();
   cp55 = new ControlP5(this);  

  guiSup();
  
  tiempo = new String [rowCount];
  kennedy = new int [rowCount];
  for(int i = 0; i < rowCount; i++)
  {
    //creamos un objeto que guarda la información de las filas de la tabla
    TableRow row = datos.getRow(i);
    
    tiempo[i] = row.getString("tiempo");
    
    //segundo
   kennedy [i] = row.getInt("Kennedy");
        
    //tercero
    
    if(kennedy[i] > maxDato) 
    {
      maxDato =  kennedy[i];
    }
    
    
    //cuarto
    kennedy [i]= row.getInt("Kennedy");
    
    //quinto
    //suba[i]= row.getInt("Suba");
    
    //fontibon[i]= row.getInt("Fontibon");
    
    //usme[i]= row.getInt("Usme");
    
    //chapinero[i]= row.getInt("Chapinero");
    
    //usaquen[i]= row.getInt("Usaquen");
  
  }
  
  words.add("PoblacioBogota 2019");
  words.add("Usaquen: 476,184");
  words.add("Chapinero: 125,750");
  words.add("Santa Fe: 92,490");
  words.add("Usme: 345,689");
  words.add("Tunjuelito: 184,743");
  words.add("Bosa: 1,348,372");
  words.add("Kennedy: 1,252,014");
  words.add("Fontibon: 1,252,014");
  words.add("Engativa: 887,886");
  words.add("Suba: 1,348,372");
  words.add("BarriosUnidos: 273,396");
  words.add("Teusaquillo: 139,776");
  words.add("LosMartires: 92,755");
  words.add("AntonioNariño: 109,104");
  words.add("PuneteAranda: 215,191");
  words.add("LaCandelaria: 22,041");
  words.add("UribeUribe: 344,990");
  words.add("CiudadBolivar: 762,184");
  words.add("Sumapaz: 7,711");
  
  

  nextWord(words.get(wordIndex));
}


void draw() {
  // Background & motion blur
 background(mapImage = loadImage("mapa.png"));
  fill(bgColor);
  noStroke();
  rect(0, 0, width*2, height*2);

  for (int x = particles.size ()-1; x > -1; x--) {
    // Simulate and draw pixels
    Particle particle = particles.get(x);
    particle.move();
    particle.draw();

    // Remove any dead pixels out of bounds
    if (particle.isKilled) {
      if (particle.pos.x < 0 || particle.pos.x > width || particle.pos.y < 0 || particle.pos.y > height) {
        particles.remove(particle);
      }
    }
  }
}


// Show next word
void mousePressed() {
  if (mouseButton == LEFT) {
    wordIndex += 1;
    if (wordIndex > words.size()-1) { 
      wordIndex = 0;
    }
    nextWord(words.get(wordIndex));
  }
}


// Kill pixels that are in range
void mouseDragged() {
  if (mouseButton == RIGHT) {
    for (Particle particle : particles) {
      if (dist(particle.pos.x, particle.pos.y, mouseX, mouseY) < 50) {
        particle.kill();
      }
    }
  }
}


// Toggle draw modes
void keyPressed() {
  drawAsPoints = (! drawAsPoints);
  if (drawAsPoints) {
    background(0);
    bgColor = color(0, 40);
  } else {
    background(255);
    bgColor = color(255, 100);
  }
}
void guiSup()
{ 
    //slider
    cp55.addSlider("valSlider")
     .setPosition(600,70)
     .setWidth(450)
     .setRange(0,21) 
     .setValue(0)
     .setNumberOfTickMarks(21)
     .setSliderMode(Slider.FLEXIBLE)
     .setColorForeground(color(255))
     .setColorActive(color(#37c9ef))
     .setColorBackground(color(0,0,0));
     
     
}
