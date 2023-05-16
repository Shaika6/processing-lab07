/**
 * SNAKE GAME
 * Rules:
 *     Eat the food
 *     Do not bite your own tail
 *     Do not hit a wall
 * Specifications:
 *     The snake grows when eat food
 *     The speed increases when the snake grows
 *     Food is displayed randomly
 *     Food and parts of the snake body are squares
 */

// global variables
ArrayList<PVector> snake = new ArrayList<PVector>(); // snake body (not included the head)
PVector pos; // snake position (position of the head)

StringList mode_list = new StringList(new String[] {"border", "no_border"}); // if you implement both functionalities
int mode_pos = 1; // mode 1 by default - if hits wall wraps around
String actual_mode = mode_list.get(mode_pos); // current mode name

PVector food; // food position

PVector dir = new PVector(0, 0); // snake direction (up, down, left right)

int size = 40; // snake and food square size
int w, h; // how many snakes can be allocated

int spd = 20; // reverse speed (smaller spd will make the snake move faster)
int len = 1; // snake body

void setup() {
  size(1080, 720);
  w = width/size;
  h = height/size;

  pos = new PVector(w/2, h/2); // Initial snake position
  newFood(); // create 2D vector

  noStroke();
  fill(0);
}

void draw() {
  background(#000000);
  drawSnake();
  drawFood();
  drawScore();

  // update snake if frameCount is a multiple of spd which is 20 at the begining
  if(frameCount % spd == 0) {
    updateSnake();
  }
}

// draw the food item (square) which size is tha variable size
void drawFood() {
   fill(#FF5555);
   square(food.x * size, food.y * size, size);
}

// declare a new pVector (random) for food
void newFood() {
  int x = int(random(w));
  int y = int(random(h));
  food = new PVector(x,y);
}

// draw snake, consider the snake array size (each square of size size) + square of the current pos
void drawSnake() {
  // Snake head
  fill(#6DFFB6);
  rect(pos.x * size, pos.y * size, size, size);
  
  // Snake body
  for (int i = 0; i < snake.size(); i++) {
    PVector body = snake.get(i);
    rect(body.x * size, body.y * size, size, size);
  }
}

void drawScore() {
  textSize(20);
  textAlign(LEFT);
  fill(0);
  text("Score: " + snake.size(), 10, 30);
}

void updateSnake() {
  // Add current position(head) to snake ArrayList
    // if(dir.x != 0 && dir.y != 0)
     snake.add(new PVector(pos.x, pos.y));
  // Check the size of snake. Remove some items from snake ArrayList if needed
     while (len < snake.size()){
     snake.remove(0);
     }
  // Calculate new position of snake (head). You must use the direction vector for this calculation
     pos.add(dir);
  // If snake (head) hits food, add +1 to the snake size and create a new food
     if (pos.equals(food)){
         len++;
         spd--;
         newFood();
     }
  // If snake (head) eat itself, gameover, reset()
    boolean hitSelf = false;
    for (PVector x : snake) {
        if (pos.equals(x) && (len > 1)) {
        hitSelf = true;
        } 
    }
    if (hitSelf) {
    reset();
    }
    
  // If mode 'no_border', snake is out of screen, wraps around
  // If mode 'border', when snake hit a border, gameover, reset()
     if (actual_mode.equals("no_border")) {
     if (pos.x < 0) pos.x = w - 1;
     if (pos.x > w - 1) pos.x = 0;
     if (pos.y < 0) pos.y = h - 1;
     if (pos.y > h - 1) pos.y = 0;
   } 
   else if (actual_mode.equals("border")) {
     if (pos.x < 0 || pos.x > w - 1 || pos.y < 0 || pos.y > h - 1) {
         reset();
    }
  }
}

void reset() {
  spd = 20;
  len = 1;
  pos = new PVector(w/2, h/2);
  dir = new PVector(0,0);
  newFood();
  snake = new ArrayList<PVector>();
}

void keyPressed() {
  // if UP is pressed => dir = new PVector(...)
  // same thing for DOWN, LEFT, RIGHT
  // UP (0,-1)
  // DOWN(0,1)
  // LEFT(-1,0)
  // RIGHT(1,0)
  if (key == CODED) {
    if (keyCode == UP) dir = new PVector(0,-1);
    else if (keyCode == DOWN) dir = new PVector(0,1);
    else if (keyCode == LEFT) dir = new PVector(-1,0);
    else if (keyCode == RIGHT) dir = new PVector(1,0);
  }

}
