public class Kernel {
  float[][] kernel;

  /**Constructor takes the kernel that will be applied to the image
  *This implementation only allows 3x3 kernels
  */

  public Kernel(float[][]init) {
  try {
    kernel = new float[3][3];
    for (int row = 0; row < init.length; row++) {
      for (int col = 0; col < init[0].length; col++) {
        kernel[row][col] = init[row][col]; 
      }
    }
   }

    catch(IllegalArgumentException ex) {
      println("Kernel must be 3x3");
    }
  }

  /**If part of the kernel is off of the image, return black, Otherwise
  *Calculate the convolution of r/g/b separately, and return that color\
  *if the calculation for any of the r,g,b values is outside the range
  *     0-255, then clamp it to that range (< 0 becomes 0, >255 becomes 255)
  */
  color calcNewColor(PImage img, int x, int y) {
    float r = 0;
    float g = 0;
    float b = 0;
    color[][] pxls = new color[][] { {img.get(x-1,y-1), img.get(x, y-1), img.get(x+1, y-1)}, {img.get(x-1,y), img.get(x, y), img.get(x+1, y)},{img.get(x-1,y+1), img.get(x, y+1), img.get(x+1, y+1)}
   };
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        r += red(pxls[i][j]) * kernel[i][j];
        g += green(pxls[i][j]) * kernel[i][j];
        b += blue(pxls[i][j]) * kernel[i][j];
      }
    }
        
    return color(r, g, b);
  }

  /**Apply the kernel to the source,
  *and saves the data to the destination.*/
  void apply(PImage source, PImage destination) {
    for (int x = 0; x < source.width; x++) {
      for (int y = 0; y < source.height; y++) {
        color newC = calcNewColor(source, x, y);
        destination.set(x, y, newC);
      }
    }
  }

}
