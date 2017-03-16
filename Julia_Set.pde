//float angle;

void setup() {
  size(640, 480);
  colorMode(RGB, 1);
  //angle = 0;
}

void draw() {
 background(255);
 
 loadPixels();
 
 //float ca = cos(5 * angle);
 //float cb = sin(2 * angle);
 //angle += .02;
 
 float w = 5; //Some width of possible values
 float h = w * height / width; //Same ratio as height and width already
 
 float xmin = -w / 2; //Start at the negative of w/2 so total width will be w
 float ymin = -h / 2; //Start at the negative of h/2 so total height will be h
 
 float xmax = w / 2; //Make total width w
 float ymax = h / 2; //Make total height h
 
 float dx = w / width; //An iterator for mapping points to pixels
 float dy = h / height; //An iterator for mapping points to pixels
 /* Note: by points I mean complex values contained within w and h */
 
 int it = 100; //A threshold for us to stop calculating values
 
 float xco = xmin; //Begin at the minimum value, and iterate through values
 
 for (int x = 0; x < width; x ++) {
  float yco = ymin; //Begin at the minimum value, and iterate through values
  
  for (int y = 0; y < height; y ++) {
    float r = xco; //Set real part to the current x-coordinate
    float c = yco; //Set complex value to the current y-coordinate
    int i = 0; //Iterator starts at 0
    
    while (i < it) {
      float trc = 2 * r * c; //Saves value so it doesn't use new r and c
      
      r = r* r - c * c + xco; //(r+ci)(r+ci) = (r^2 - c^2)<--Real part + 2rci
      c = trc + yco; //(r+ci)(r+ci) = r^2 - c^2 + (2rci) <-- Complex Part
      
      if (r * r + c * c > 16.0) {
        //If this value goes over some threshold, stop so we don't include all pixels
        break;
      }
      
      i++; //Increase iterator
    }
    
    if (i == it) {
      //If it iterated fully without breaking
      pixels[x + y * width] = color(0); //Set pixel color to black
    } else {
      //If it didn't
      //Cool colors
      float col = map(i, 0, 100, 0, 5);
      pixels[x + y * width] = color(sqrt(float(i)) / (it / (i + 1)), col, col * i / map(i, 0, 100, 0, 125));
    }
    
    yco += dy; //Iterate through x-coordinates for each pixel within w
  }
  xco += dx; //Iterate through y-coordinates for each pixel within h
 }
 
 updatePixels(); //Show
}

/*

Quick pixel array lesson:
The array iterates through all of the x values [[0, 0], [1, 0], [2, 0],...] first,
then proceeds to iterate through the y values after each iteration. So, for setting
pixel colors, we would need to go to it's x-coordinate under y=0 [xco, 0], then jump
to the y value, which would then be y * (how many x-pixels there are). This value is
obviously going to be the width, since that is defined as being that specifically.

*/
