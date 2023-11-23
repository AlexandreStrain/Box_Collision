//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Variables used in Game

color yes_Colour, no_Colour, collide_Colour;

GameObject object_A, object_B;

boolean overlaps;

int overlap_Text_X;

int speed_X, speed_Y; // to move object_B
int size_W, size_H; //to increase or decrease object_B size

int overlap_window_X, overlap_window_y, overlap_window_w, overlap_window_h;

//......................................................................

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Important Notes

/*


All shapes drawn in Processing start at the top left corner.
This is because the origin (0x, 0y) of the Game's graph is there.

The BIGGER the y value, the further DOWN in the game window you are
The SMALLER the y value, the further UP in the game window you are

The BIGGER the x value, the further RIGHT in the game window you are
The SMALLER the x value, the further LEFT in the game window you are


The Right Side of an Object is usually it's x position plus its width
     Right Side = Object.x + Object.w
     
     
The Bottom Side of an Object is usually it's y position plus its height
     Bottom Side = Object.y + Object.h  

*/

//......................................................................

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Loads Game
void setup() {
  //Creates the game window with a particular size (width, height)
  size(800, 600);

  //setup the two objects as new GameObject instances, store them into variables
  object_A = new GameObject(mouseX, mouseY, 75, 75, "Object A");
  object_A.mouseControl = true;
  object_B = new GameObject(
    width / 2 - 75,
    height / 2 - 25,
    150,
    150,
    "Object B"
  );

  //define the colours use to better illustrate when overlapping occurs between two Objects
  yes_Colour = color(0, 150, 0);
  no_Colour = color(200, 0, 0);
  collide_Colour = color(0, 0, 255);
  speed_X = 0;
  speed_Y = 0;
  size_W = 0;
  size_H = 0;

  overlap_Text_X = width - 200;
  overlap_window_X = 0;
  overlap_window_y = 0;
  overlap_window_w = width;
  overlap_window_h = 200;
}
//......................................................................

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Draws and Updates Game
void draw() {
  background(220);
  strokeWeight(1);

  //CONTROLS
  fill(0);
  strokeWeight(1);
  stroke(0);
  textSize(18);
  text("'WASD' or Arrow Keys moves Object_B", width - 200, height - 50);
  text("'IJKL' changes size of Object_B", width - 200, height - 25);
  text("Mouse moves Object_A", 150, height - 25);
  text("Click to Start using Controls!", 150, height - 50);

  overlaps = false;

  //Update and Center Object_A's location around mouse
  object_A.x = mouseX - object_A.w / 2;
  object_A.y = mouseY - object_A.h / 2;

  //Display Object_B with a white background and black outline
  object_B.changePosition(speed_X, speed_Y);
  object_B.changeSize(size_W, size_H);

  fill(255);
  stroke(0);
  object_B.display();

  //Set Transparency of Object_A so we can see overlap better on Object_B
  fill(200, 200, 200, 0.5);
  stroke(10, 10, 10);
  object_A.display();

  if (object_A.w <= object_B.w || object_A.h <= object_B.h) {
    checkObjectOverlap(false);
    checkObjectCollision(object_A, object_B);
  } else {
    checkObjectOverlap(true);
    checkObjectCollision(object_B, object_A);
  }
}
//......................................................................

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Checks Key Input on key down
void keyPressed() {
  // Check "WASD" and Arrow Keys for moving Object_B
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    speed_X = -3;
  } else if (key == 'd' || key == 'D' || keyCode == RIGHT) {
    speed_X = 3;
  }

  if (key == 'w' || key == 'W' || keyCode == UP) {
    speed_Y = -3;
  } else if (key == 's' || key == 'S' || keyCode == DOWN) {
    speed_Y = 3;
  }

  //Check "IJKL" decrease/increase Object_B size
  if (key == 'j' || key == 'J') {
    size_W = -3;
  } else if (key == 'l' || key == 'L') {
    size_W = 3;
  }

  if (key == 'i' || key == 'I') {
    size_H = 3;
  } else if (key == 'k' || key == 'K') {
    size_H = -3;
  }
}
//......................................................................
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Checks Key Input on key up
void keyReleased() {
  if (
    key == 'a' ||
    key == 'A' ||
    keyCode == LEFT ||
    key == 'd' ||
    key == 'D' ||
    keyCode == RIGHT
  ) {
    speed_X = 0;
  }

  if (
    key == 'w' ||
    key == 'W' ||
    keyCode == UP ||
    key == 's' ||
    key == 'S' ||
    keyCode == DOWN
  ) {
    speed_Y = 0;
  }

  if (key == 'j' || key == 'J' || key == 'l' || key == 'L') {
    size_W = 0;
  }

  if (key == 'i' || key == 'I' || key == 'k' || key == 'K') {
    size_H = 0;
  }
}
//......................................................................

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Check for Overlap between Object_A and Object B

void checkObjectOverlap(boolean reverse) {
  //Used to confirm all 4 sides of Object_A are overlapping Object_B or vice versa
  int count = 0;

  //Text size for confirmation of all sides overlapping is a little bigger
  textSize(18);
  strokeWeight(1);
  fill(200);
  rect(overlap_window_X, overlap_window_y, overlap_window_w, overlap_window_h);

  //If Left Side of Object_A is greater than the Left Side of Object_B
  if (!reverse && object_A.x > object_B.x) {
    //one side overlaps, increase count towards all sides overlap
    count++;

    //set colour for text to show it is overlapping
    fill(yes_Colour);
    stroke(yes_Colour);
    text("Object_A.Left > Object_B.Left = True", overlap_Text_X, 70);
  } else if (reverse && object_B.x > object_A.x) {
    //one side overlaps, increase count towards all sides overlap
    count++;

    //set colour for text to show it is overlapping
    fill(yes_Colour);
    stroke(yes_Colour);
    text("Object_B.Left > Object_A.Left = True", overlap_Text_X, 70);
  } else {
    //set colour for text to show it's not overlapping
    fill(no_Colour);
    stroke(no_Colour);
    text("Object_A.Left > Object_B.Left = False", overlap_Text_X, 70);
  }

  //If Right Side of Object_A is less than the Right Side of Object_B

  //SEE IMPORTANT NOTES ABOVE

  if (!reverse && object_A.x + object_A.w < object_B.x + object_B.w) {
    //one side overlaps, increase count towards all sides overlap
    count++;

    //set colour for text to show it is overlapping
    fill(yes_Colour);
    stroke(yes_Colour);
    text("Object_A.Right < Object_B.Right = True", overlap_Text_X, 105);
  } else if (reverse && object_B.x + object_B.w < object_A.x + object_A.w) {
    //one side overlaps, increase count towards all sides overlap
    count++;

    //set colour for text to show it is overlapping
    fill(yes_Colour);
    stroke(yes_Colour);
    text("Object_B.Right < Object_A.Right = True", overlap_Text_X, 105);
  } else {
    //set colour for text to show it's not overlapping
    fill(no_Colour);
    stroke(no_Colour);
    text("Object_A.Right < Object_B.Right = False", overlap_Text_X, 105);
  }

  //If Top Side of Object_A is greater than the BOTTOM Side of Object_B

  if (!reverse && object_A.y > object_B.y) {
    //one side overlaps, increase count towards all sides overlap
    count++;

    //set colour for text to show it is overlapping
    fill(yes_Colour);
    stroke(yes_Colour);
    text("Object_A.Top > Object_B.Top = True", overlap_Text_X, 140);
  } else if (reverse && object_B.y > object_A.y) {
    //one side overlaps, increase count towards all sides overlap
    count++;

    //set colour for text to show it is overlapping
    fill(yes_Colour);
    stroke(yes_Colour);
    text("Object_B.Top > Object_A.Top = True", overlap_Text_X, 140);
  } else {
    //set colour for text to show it's not overlapping
    fill(no_Colour);
    stroke(no_Colour);
    text("Object_A.Top > Object_B.Top = False", overlap_Text_X, 140);
  }

  //If BOTTOM Side of Object_A is less than the BOTTOM Side of Object_B
  //SEE IMPORTANT NOTES ABOVE

  if (!reverse && object_A.y + object_A.h < object_B.y + object_B.h) {
    //one side overlaps, increase count towards all sides overlap
    count++;

    //set colour for text to show it is overlapping
    fill(yes_Colour);
    stroke(yes_Colour);
    text("Object_A.Bottom < Object_B.Bottom = True", overlap_Text_X, 175);
  } else if (reverse && object_B.y + object_B.h < object_A.y + object_A.h) {
    //one side overlaps, increase count towards all sides overlap
    count++;

    //set colour for text to show it is overlapping
    fill(yes_Colour);
    stroke(yes_Colour);
    text("Object_B.Bottom < Object_A.Bottom = True", overlap_Text_X, 175);
  } else {
    //set colour for text to show it's not overlapping
    fill(no_Colour);
    stroke(no_Colour);
    text("Object_A.Bottom < Object_B.Bottom = False", overlap_Text_X, 175);
  }

  //This confirms/checks if all 4 sides of Object_A overlap with Object_B
  if (count == 4) {
    //set colour for text to show Object_A does Collide with Object_B
    fill(yes_Colour);
    stroke(yes_Colour);
    textSize(24);
    text("Overlaps!", width - 200, 30);
    overlaps = true;
  } else {
    //set colour for text to show Object_A doe not Collide with Object_B
    fill(no_Colour);
    stroke(no_Colour);
    textSize(24);
    text("No Overlap ...", width - 200, 30);
  }
}

//......................................................................

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Check for collision between Object_A and Object B

void checkObjectCollision(GameObject obj_1, GameObject obj_2) {
  //Text size for confirmation of all sides overlapping is a little bigger
  textSize(18);
  strokeWeight(1);
  boolean collision = false;

  //Object_A right
  if (obj_1.x + obj_1.w > obj_2.x && obj_1.x + obj_1.w < obj_2.x + obj_2.w) {
    //check if object_A's y position is found between object_B's y position and height coordintates

    if (obj_1.y < obj_2.y + obj_2.h && obj_1.y + obj_1.h > obj_2.y) {
      fill(collide_Colour);
      stroke(collide_Colour);
      strokeWeight(6);
      line(obj_1.x + obj_1.w, obj_1.y, obj_1.x + obj_1.w, obj_1.y + obj_1.h);

      //Object_B left
      line(obj_2.x, obj_2.y, obj_2.x, obj_2.y + obj_2.h);

      collision = true;
      strokeWeight(1);
      if (obj_1.mouseControl) {
        text("Object_A's Right Hits Object_B's Left", 175, 70);
      } else {
        text("Object_B's Right Hits Object_A's Left", 175, 70);
      }
    }
  }

  //Object_A left
  if (obj_1.x < obj_2.x + obj_2.w && obj_1.x > obj_2.x) {
    //check if object_A's y position is found between object_B's y position and height coordintates

    if (obj_1.y < obj_2.y + obj_2.h && obj_1.y + obj_1.h > obj_2.y) {
      fill(collide_Colour);
      stroke(collide_Colour);
      strokeWeight(6);
      line(obj_1.x, obj_1.y, obj_1.x, obj_1.y + obj_1.h);

      //Object_B right
      line(obj_2.x + obj_2.w, obj_2.y, obj_2.x + obj_2.w, obj_2.y + obj_2.h);
      collision = true;
      strokeWeight(1);
      if (obj_1.mouseControl) {
        text("Object_A's Left Hits Object_B's Right", 175, 105);
      } else {
        text("Object_B's Left Hits Object_A's Right", 175, 105);
      }
    }
  }

  //Object_A top
  if (obj_1.y < obj_2.y + obj_2.h && obj_1.y > obj_2.y) {
    //check if object_A's x position is found between object_B's x position and width coordintates

    if (obj_1.x < obj_2.x + obj_2.w && obj_1.x + obj_1.w > obj_2.x) {
      fill(collide_Colour);
      stroke(collide_Colour);

      strokeWeight(6);
      line(obj_1.x, obj_1.y, obj_1.x + obj_1.w, obj_1.y);

      //Object_B bottom
      line(obj_2.x, obj_2.y + obj_2.h, obj_2.x + obj_2.w, obj_2.y + obj_2.h);
      collision = true;
      strokeWeight(1);
      strokeWeight(1);
      if (obj_1.mouseControl) {
        text("Object_A's Top Hits Object_B's Bottom", 175, 140);
      } else {
        text("Object_B's Top Hits Object_A's Bottom", 175, 140);
      }
    }
  }

  //Object_A bottom
  if (obj_1.y + obj_1.h > obj_2.y && obj_1.y + obj_1.h < obj_2.y + obj_2.h) {
    //check if object_A's x position is found between object_B's x position and width coordintates

    if (obj_1.x < obj_2.x + obj_2.w && obj_1.x + obj_1.w > obj_2.x) {
      fill(collide_Colour);
      stroke(collide_Colour);
      strokeWeight(6);
      line(obj_1.x, obj_1.y + obj_1.h, obj_1.x + obj_1.w, obj_1.y + obj_1.h);

      //Object_B top
      line(obj_2.x, obj_2.y, obj_2.x + obj_2.w, obj_2.y);
      collision = true;
      strokeWeight(1);
      if (obj_1.mouseControl) {
        text("Object_A's Bottom Hits Object_B's Top", 175, 175);
      } else {
        text("Object_B's Bottom Hits Object_A's Top", 175, 175);
      }
    }
  }

  strokeWeight(1);
  textSize(24);
  if (collision) {
    text("Collision!", 120, 30);
  } else {
    text("No Collision ...", 120, 30);
  }
}
//......................................................................

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GAMEOBJECT CLASS
class GameObject {
  //******************************* CONSTRUCTOR
  int x, y, w, h;
  String msg;
  boolean mouseControl;
  int start_W, start_H;
  GameObject(int x, int y, int w, int h, String msg) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.msg = msg;
    this.mouseControl = false;
    this.start_W = w;
    this.start_H = h;
  }

  //******************************** DRAW GAMEOBJECT
  void display() {
    rect(this.x, this.y, this.w, this.h);
    fill(0);
    textSize(16);
    textAlign(CENTER);
    text(this.msg, this.x + this.w / 2, this.y + this.h / 2);

    //stationary gameobjects have their sides labelled
    if (!this.mouseControl) {
      text("Top", this.x + this.w / 2, this.y - 20);
      text("Bottom", this.x + this.w / 2, this.y + this.h + 20);
      text("Right", this.x + this.w + 24, this.y + this.h / 2);
      text("Left", this.x - 24, this.y + this.h / 2);
    }
  }

  void changePosition(int new_X, int new_Y) {
    this.x += new_X;

    //when x position goes off screen, keep within window
    if (this.x + this.w >= width) {
      this.x = width - this.w;
    } else if (this.x <= 0) {
      this.x = 0;
    }

    this.y += new_Y;

    //when y position goes off screen, keep within window
    if (this.y + this.h >= height) {
      this.y = height - this.h;
    } else if (this.y <= overlap_window_h) {
      this.y = overlap_window_h;
    }
  }

  void changeSize(int new_W, int new_H) {
    this.w += new_W;

    //if width becomes too big or small (fixed 4 times the size), then don't go further
    if (this.w >= this.start_W * 4) {
      this.w = this.start_W * 4;
    } else if (this.w <= this.start_W / 4 + 25) {
      this.w = this.start_W / 4 + 25;
    }

    this.h += new_H;

    //if height becomes too big or small (fixed 3 times the size), then don't go further

    if (this.h >= this.start_H * 3) {
      this.h = this.start_H * 3;
    } else if (this.h <= this.start_H / 3) {
      this.h = this.start_H / 3;
    }
  }
}
//......................................................................





































/* 
Code created by: Alexandre Strain | github.com/alexandrestrain
(C) All rights reserved, granted permission for Real Programming 4 Kids (RP4K) use
 */
