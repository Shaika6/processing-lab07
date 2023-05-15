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
int len = 4; // snake body

void setup() {
  size(1080, 720);
  w = width/size;
  h = height/size;

  pos = new PVector(w/2, h/2); // Initial snake position
  newFood(); // create 2D vector

  noStroke();
  fill(0);
  frameRate(150);
}

void draw() {
  background(#000000);
  drawSnake();
  drawFood();

  // update snake if frameCount is a multiple of spd which is 20 at the begining
  if(frameCount % spd == 0) {
    updateSnake();   
  }
}

// draw the food item (square) which size is tha variable size
void drawFood() {
  fill(#ff133a);
  square(food.x,food.y,size);
}

// declare a new pVector (random) for food
void newFood() {
  int x = (int) random(0,width/size) * size;
  int y = (int) random(0,height/size) * size;
  food = new PVector(x,y);
}

// draw snake, consider the snake array size (each square of size size) + square of the current pos
void drawSnake() {
  fill(#FFFFFF);
  square(pos.x * size, pos.y * size, size);

  for (int i = 0; i < snake.size(); i++) {
    PVector body = snake.get(i);
    square(body.x * size, body.y * size, size);
  }
}

void updateSnake() {
  boolean biteTail = false;
  // Add current position(head) to snake ArrayList
 // if (dir.x != 0 && dir.y != 0)
  snake.add(new PVector(pos.x, pos.y));

  // Check the size of snake. Remove some items from snake ArrayList if needed
  while(len < snake.size())
  snake.remove(0);
  // Calculate new position of snake (head). You must use the direction vector for this calculation
  pos.add(dir);
  // If snake (head) hits food, add +1 to the snake size and create a new food
  if (pos.x == food.x && pos.y == food.y) {
    len++;
    newFood();
    drawFood();
  }

  // If snake (head) eat itself, gameover, reset()
  for (PVector sqr : snake) {
    if (pos.equals(sqr) && len > 1) {
      biteTail = !biteTail;
    }
    if (biteTail) reset();
  }
  // If mode 'no_border', snake is out of screen, wraps around
  // If mode 'border', when snake hit a border, gameover, reset()

}

void reset() {
  spd = 20;
  len = 4;
  pos = new PVector(w/2, h/2);
  dir = new PVector(0, 0);
  newFood();
  snake = new ArrayList<PVector>();
}

void keyPressed() {
  if (key == CODED) {
  if (keyCode == UP) {
    dir = new PVector(0,-1);
    // for debugging println("up");
  }
  else if (keyCode == DOWN) dir = new PVector(0,1);
  else if (keyCode == LEFT) dir = new PVector(-1,0);
  else if (keyCode == RIGHT) dir = new PVector(1,0);
  }
}
