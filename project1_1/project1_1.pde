//Raymond Coti Project 1


float Xangle= 155;//bat angle
boolean gameover = false;//to check if the player has lost yet
float Zangle=310;//bat angle
float anglespeed=-0;
int combo=0;//keep track of combo
float Sx=0;
float Batx;
int out = 0;
boolean hitable =true;
PFont f; //font of text
PFont h;

boolean swing=false;
float x = 300;
float y=100;
String astring=" ";
String hstring="";
String Score = "Score: ";
String Strike = "Stikes: ";
String Combo=" ";
String PlayAgain= " Press a Key to Play Again";
int score = 0;
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
float swingspeed;
float xpos, ypos,zpos,spos,batpos;    // Starting position of shape    
float rad =5.5;
float xspeed = 0;  // Speed of the shape
float yspeed =.79;  // Speed of the shape, .95 lower limit,.79 middle,.7 hig
float zspeed=-10;
float szpeed=-9;
float sspeed=.79;
boolean hit=false;
int xdirection = 1;  // Left or Right
int ydirection = -1;  // Top to Bottom
int zdirection = -1;
int sizedirection = 1;
float r = .001;
float rx=.1;
int q = 1;
float ry=50;
boolean strike;

void setup() {
  size(800, 550, P3D);

  ellipseMode(RADIUS);
     xpos = width/2;
     ypos = 222 ;
     zpos=-500;
     batpos=175;
     Batx=175;
     spos=ypos+70;
      f = createFont("Arial",32,true); 
      h = createFont("Arial",50,true);
     // textFont(f,36);
      //
}


void draw() 
{ 

  background(140,175,100);
lights();
cursor(CROSS);
drawbackground();
drawBatter();
   Zangle += (anglespeed/20);
     Xangle += anglespeed;//increase the angle
     Batx +=Sx;//increase bat coordinate to animate swing better
     
  
  if (Xangle< -115){
    anglespeed = -anglespeed;//when it reaches a certain point move in the opposite direction
    Sx=-Sx;
    Xangle +=anglespeed;
  }
  
  if(Xangle > 154){
    anglespeed = 0;//when the bat reaches back to the original angle, it will stop moving
    Sx=0;//stop increasing the bat x coordinate
  }
if(mouseX<(width/2+68) && mouseX >(width/2 -68)&& mouseY>280 && mouseY < 410){//if cursor is in strike zone
  if(swing == false){//if you can still swing
    batpos=mouseX-205;//move the batter around
    Batx=mouseX-230;//move bat as well
  }
  
}
      pushMatrix();
      textFont(f);
      
      text(astring,x,y);//display the called ball/strike text, default is empty
      popMatrix();
       text(hstring,random(200,600),random(100,250));//display homerun text, keep changing the location for dramatic effect
//  if (ypos > height-rad || ypos < rad) {
//    ydirection *= -1;
//  }
  if(zpos<-2100 && hit==true){ //if ball is hit and reaches a "vanishing point" reset it back to the pitchers mound 
    hit=false;
     xpos = width/2;
     ypos = 230 ;
     zpos=-500;
     spos=222+70;
     xdirection *= -1;  
     ydirection *= -1;  
     zdirection  *= -1;
     xspeed=0;
     zspeed=-10;
     yspeed=.79;
  }
  if( zpos< -500 && hit ==false){//if the ball was not hit, pitch the ball again,
   astring="";// blank messages
   hstring="";
   hitable=true;//ball can be hit again
  swing=false;// bat is not swung, allowed to swing

  zspeed=-10;
   yspeed=random(.64,1.2);
  
   sspeed=.68;
   xspeed=random(-.47,.47);
 if (yspeed<.73 || yspeed > 1.2 || abs( xspeed) > .424){
    strike = false;
    
  }
  else{
    strike = true;
  }
    zdirection *= -1;
    ydirection *=-1;
    xdirection *= -1;
    
    sizedirection *=-1;
  }

  if(zpos >400){
   // zspeed=0;
  
  CallStrike();// function to say if it is a ball or strike and create text and sound accordingly
  //  xspeed=0;
  //  yspeed=0;
    zdirection *=-1;
    xdirection *= -1;
    ydirection *= -1;
  hitable=false;
    
  }
  // Update the position of the shape
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  zpos=zpos - (zspeed*zdirection);
  spos=spos + (sspeed*ydirection);
  rad=rad + (rx*sizedirection);//leftover code
  ry=ry +(rx*9*sizedirection);
  r = r + .2;
  Score= "Score:" + score;//update text to display current score and number of strikes
  Strike = "Strike:" + out;
  pushMatrix();
  fill(100,20,90);
  text(Score,500,100);//display text
  text(Combo,500,150);
  text(Strike,500,200);
  popMatrix();
  text(hstring,random(200,600),random(100,250));//display text, default blank
  
  
  if (out > 2){ //if the user gets 3 strikes or more, game is over, 
  gameover=true;  
  fill(0);
    textFont(h);   
  text(PlayAgain,width/2-200,height/2-100);//displayes to show that user can restart game by pressing key
  
  }
  if (keyPressed == true) {
    if (out>2){//iif key is pressed reset the number of outs, score and combo
    out=0;
    score=0;
    combo=0;
    Combo="";
    gameover=false;
    
   
    }
  }

  
  //this is the object it is a simple cirle and box
//  pushMatrix();
//  translate(350,ypos-100,zpos);
//  rotateZ(r);
//  rotateX(rx);
//  fill(190,100,120);
//  box(rad+25);
//  popMatrix();
// 
 pushMatrix(); // this draws the baseball and the shadow
 fill(120,30,155);
 stroke(2);
// rotateZ(25);
 translate(xpos,ypos,zpos);
 rotateZ(r);
   sphere(8);
  popMatrix();
  pushMatrix();
  fill(0);
  noStroke();
  
  translate(xpos,spos,zpos);
 
  sphere(7);
 
  popMatrix();
}

void drawBatter(){ //draws the batter
  
  pushMatrix();
  //batpos=175
  
  fill(20,54,139);
  noStroke();
  translate(batpos,275,0);
  sphere(50);
  popMatrix();
  pushMatrix();
  translate(batpos,375,-20);
  sphere(65);
  popMatrix();
  pushMatrix();
  stroke(0);
  fill(10);
  ellipse(batpos,480,60,20);
   pushMatrix();
   
  noStroke();
   translate(Batx,310,75);
  rotateZ(radians(Zangle));
  rotateX(radians(Xangle));
  //rotateZ(radians(45));
  
  fill(120,115, 90);
  drawCylinder(10,30,100,100);//calls function taken from processing tutorial
  popMatrix();
  pushMatrix();
  translate(batpos+33,260,-20);
  rotateX(radians(75));
  rotateZ(radians(90));
  fill(76,155,40);
  drawCylinder(15,20,30,5);
  popMatrix();
  popMatrix();
 
}
void drawbackground(){//draws the background, fences 

    pushMatrix();
  noStroke();
  
  pushMatrix();
  fill(25,230,55);
  translate(1500,-230,-2500);
  
  rotateZ(radians(5));
  rect(-500,-100,1000,500);
  popMatrix();
   pushMatrix();
 fill(20,135,55);
 translate(3000, -200,-2500);
 rotate(radians(4));
 rect(-500,-100,700,490);
 popMatrix();
 pushMatrix();
 fill(255);
 translate(width/2,-1000,-2600);
 rect(-3000,-1000,6000,2000);
 popMatrix();
  pushMatrix();
  fill(30,235,100);
  
  translate(2400,-220,-2500);
  rotate(radians(-4));
  rect(-500,-100,700,500);
  popMatrix();
  pushMatrix();
  fill(255);
  translate(width/2,325,-2500);

  rect(-75,-5,150,10);
  popMatrix();
  pushMatrix();
  fill(25,230,55);
  translate(-1900,-200,-2500);
   rotateZ(radians(-5));
   rect(-1000,-100,2000,500);
   popMatrix();
   pushMatrix();
   fill(55,245,75);
   translate(0,-250,-2500);
   rect(-1000,-370,2100,750);
   popMatrix();
   popMatrix();
pushMatrix();
  noStroke();
  fill(20,225,165);


translate(width/2,700,0);
rotateX(radians(90));


quad(-5000,10000,0,-100000,5000,10000,0,0);
  popMatrix();
  
 
  pushMatrix();
  noStroke();
  fill(255);
 
  //rotateX(-100);
   triangle(width/2-65,490,width/2+65,490,width/2,515);
   //rect(width/2-35,415,70,35);
  quad(width/2-60,430,width/2+60,430,width/2+65,490,width/2-65,490);
   triangle(0,375,-10,375,width/2,515);
   triangle(width,375,width+10,375,width/2,515);
    popMatrix();
  pushMatrix();
  //  PShape s = createShape();
//  s.beginShape();
stroke(12,12,12);
fill(12,12,12);
  line((width/2-68),290,(width/2+68),290);
  line((width/2-68),290,(width/2-68),440);
  line((width/2-68),440,(width/2 +68),440);
  line((width/2+68),290,(width/2+68),440);


  
 // line(width/2-50,450,width/2-45,500);
 // line(width/2+50,450,width/+45,500);
//  s.vertex(width/2 + 50, 450);
//  s.vertex(width/2 + 45, 500);
//  s.vertex(width/2, 525);
//  s.vertex(width/2 - 45, 500);
//  s.endShape();
  
  popMatrix();
}
  void mouseClicked(){
   //if the mouse is clicked then the bat is swung
    
       Minim minim; //sounds for swinging and hits
      minim = new Minim(this);
    AudioPlayer miss;
    AudioPlayer Hit ;
    AudioPlayer HW;
    AudioPlayer glass;
    AudioPlayer can;
    Hit = minim.loadFile("baseball_hit.wav");
    HW = minim.loadFile("holy_cow_x.wav");
    miss= minim.loadFile("miss.wav");
    glass= minim.loadFile("glass_shatter2.wav");
    can = minim.loadFile("cannon_x.wav");
    
    if (swing==false){ //if you can still swing
    
    miss.play(0);// starts swing animation by changing speeds
    anglespeed=-25;
    
     Sx=14;
      if(zpos>200 && zpos<350 && hitable==true && gameover ==false){//if you swing while ball is hitable
        swingspeed=zpos;
        
         if( mouseX > xpos-40 && mouseX < xpos +40){//if your cursor/hitbox is near the ball ball 
           Hit.play(0);//ball is hit sound
           float num=random(0,6);//random sound is played
           num=round(num);
           if (num<2){
             HW.play(0);
           }
           else if (num > 2 && num < 3){
              glass.play(0);
         }
         else{
        can.play(0);
         }
        score=score + 120*(1+combo)*(abs(out)+1);//scoring system, score increase, more points for combo and hits while strikes
             if (swingspeed > 200 && swingspeed < 250){//swing early ball goes to left
               xspeed= 6+ (250-swingspeed)/6;
             }
           else if(swingspeed < 301 && swingspeed > 250){//swing medium ball goes to center
             xspeed= -6 + (301-swingspeed)/6;
           }
           else{
             xspeed = -15 + (350-swingspeed)/6;//swing late ball goes to right feild
           }
                         // STEP 4 Specify font to be used
           combo = combo +1;       //if ball is hit combo increases
       Combo= combo + "X Combo!!!";    
          hstring= "HomeRun!!!!!";
           
          
    //if(mousePressed==true){
    zspeed=13;
     // xspeed=random(-13,13);
     //xspeed=-4;
      yspeed=random(-8,-8.5);
       sspeed=yspeed/10;
      
      sizedirection *=0;
       q=0;
       hit=true;
    }
  
         }
         else{
    strike=true;//swing and miss
    
    miss.play(0);
  }
          swing=true; //you swung and missed
    }
  }
  void CallStrike(){ //function that calls stike and balls displays it
     Minim minim; 
      minim = new Minim(this);
    AudioPlayer AStrike;
    AStrike = minim.loadFile("gdi_success.wav");
     x=random(200,600);
     y=random(100,400);
    if (strike==false){
     textFont(f);                 // STEP 4 Specify font to be used
     fill(0);                        // STEP 5 Specify font color 
    astring= "Ball!!! Good EYE"; // STEP 6 Display Text
     // println("ball");
      out = out-1;
      
      
    }
    else{
      
      textFont(f);
      fill(100,20,40);
      astring="STRIKE";
      //println("strike");
      out= out + 1;
      if (out==2){ //when you are one strike away from game over play this
      AStrike.play(0);
      }
      combo=0;
      Combo="";
      //combo=combo + 1;
    }
  }
      
void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) { //this function was taken from processing
  float angle = 0;
  float angleIncrement = TWO_PI / sides;
  beginShape(QUAD_STRIP);
  for (int i = 0; i < sides + 1; ++i) {
    vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
    vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
    angle += angleIncrement;
  }
  endShape();
  
  // If it is not a cone, draw the circular top cap
  if (topRadius != 0) {
    angle = 0;
    beginShape(TRIANGLE_FAN);
    
    // Center point
    vertex(0, -50, 0);//edited to create bat shape
    for (int i = 0; i < sides + 1; i++) {
      vertex(topRadius * cos(angle), 0, topRadius * sin(angle));
      angle += angleIncrement;
    }
    endShape();
  }

  // If it is not a cone, draw the circular bottom cap
  if (bottomRadius != 0) {
    angle = 0;
    beginShape(TRIANGLE_FAN);

    // Center point
    vertex(0, tall, 0);
    for (int i = 0; i < sides + 1; i++) {
      vertex(bottomRadius * cos(angle), tall, bottomRadius * sin(angle));
      angle += angleIncrement;
    }
    endShape();
  }
}


