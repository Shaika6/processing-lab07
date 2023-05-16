int currentKernel = 0;

String[] names = new String[]{
    "Identity", "Blur", "Sharpen",
    "Outline", "Left Sobel", "Right Sobel",
    "Top Sobel", "Emboss"
  };
  
PImage car;
PImage output;

void setup(){
  size(1450,500);
   car = loadImage("redcar.png");
   output = car.copy();
}
void draw() {
  if ( currentKernel == kernels.length ) currentKernel=0;
  kernels[currentKernel].apply(car, output);
  println(names[currentKernel]);
  image(car,0,0);
  image(output,car.width,0);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT && currentKernel < kernels.length) currentKernel++;
    else if (keyCode == LEFT && currentKernel < 0) currentKernel--;
  }
}

  Kernel[] kernels = new Kernel[] {
    new Kernel( new float[][] {
      {0, 0, 0},
      {0, 1, 0},
      {0, 0, 0} 
    }) ,
    new Kernel( new float[][] {
      {.111, .111, .111},
      {.111, .111, .111},
      {.111, .111, .111} // 1
    }) ,
    new Kernel( new float[][] {
      {0, -1, 0},
      {-1, 5, -1},
      {0, -1, 0} 
    }) ,
    new Kernel( new float[][] {
      {-1, -1, -1},
      {-1, 8, -1},
      {-1, -1, -1} 
    }) ,
    new Kernel( new float[][] {
      {1, 0, -1},
      {2, 0, -2},
      {1, 0, -1} 
    }) ,
    new Kernel( new float[][] {
      {-1, 0, 1},
      {-2, 0, 2},
      {-1, 0, 1} 
    }) ,
    new Kernel( new float[][] {
      {1, 2,  1},
      {0, 0, 0},
      {-1, -2, -1} 
    }),
    new Kernel( new float[][] {
      {-2, -1,  0},
      {-1, 1, 1},
      {0, 1, 2} 
    })
  };
