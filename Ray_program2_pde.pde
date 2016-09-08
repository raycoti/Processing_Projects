//Raymond Coti


//this program uses examples and tutorials from the processing website applied to 3d primatives
//this "game" is played by having the user drag the center box into the center of the moving object
//each time the user does so the object gets smaller and faster. 

float bx;//location for the box
float by;//x and y coordinates for it
int boxSize = 30;//size of the box
boolean overBox = false;//if the mouse is over the box it is true
boolean locked = false;//if the mouse is clicked over the box it is true
float xOffset = 0.0; 
float yOffset = 0.0; 
int colorNum=255;
int rad = 60;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 5.8;  // Speed of the shape
float yspeed = 8.9;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom


void setup() 
{
  size(760, 415,P3D);//size of window
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);
  // Set the starting position of the shape,middle of the window
  xpos = width/2;
  ypos = height/2;
  bx = width/2.0;
  by = height/2.0;
  rectMode(RADIUS);
  
}

void draw() 
{ 
  background(200);
 
  if (rad<25){//if the sphere gets to a certain point
    xpos=width/2;//reset the position, color, speed and size
    ypos=height/2;
    rad=60;
    xspeed=7.8;
    yspeed=12.9;
    colorNum=255;
  }
  if (xpos > width-rad || xpos < rad) {
    xdirection *= -1;
  }
  if (ypos > height-rad || ypos < rad) {
    ydirection *= -1;
  }
  // Test if the cursor is over the box 
  if (mouseX > bx-boxSize && mouseX < bx+boxSize && 
      mouseY > by-boxSize && mouseY < by+boxSize) {
    overBox = true;  
    if(!locked) { 
      stroke(255); 
      fill(153);
    } 
  } else {
    stroke(153);
    fill(153);
    overBox = false;
  }
  // Update the position of the shape
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  // Draw the box
  fill(colorNum,50,120);
  pushMatrix();
  noStroke();
  lights();
  translate(bx, by,0);//when dragged have the box follow the cursor
  box(boxSize);
  popMatrix();
  
  fill(colorNum,50,120);
  
  //this is the object it is a simple cirle and box
  pushMatrix();
  stroke(255);
  lights();
  translate(xpos, ypos, 0);
  sphere(rad);
  stroke(255);
  box(rad*1.5);
  popMatrix();
  //drawing th background for the room
  pushMatrix();
  rect(395,0,10,200);
  stroke(0);
  line(0,200,400,200);
  line(400,200,710,415);
  rect(740,0,30,415);
  popMatrix();
  
}

void mousePressed() {
  if(overBox) { 
    locked = true; 
    fill(255, 255, 255);
    
  } else {
    locked = false;
  }
  xOffset = mouseX-bx; 
  yOffset = mouseY-by; 

}

void mouseDragged() {
  if(locked) {
    bx = mouseX-xOffset; 
    by = mouseY-yOffset; 
  }
    if(((mouseX+25)>xpos && (mouseX-25< xpos)) && ((mouseY+25)>ypos && (mouseY-25< ypos))){
      //when dragging object if mouse position is in the range of the center of the object it will:
    rad=rad-2;//shrink by 2
    xspeed=xspeed +3;//speed up
    yspeed=yspeed + 2;
    xdirection *= -1;//change x and y directions
    ydirection *= -1;
    colorNum=colorNum-20;
  }
}

void mouseReleased() {
  locked = false;
}

