float startMinA;
float startMaxA;
float startMinB;
float startMaxB;

float minA;
float maxA;
float minB;
float maxB;

int maxIterations = 5000;
float escapeRadius = 2;

Renderer renderer;

void setup() {
  pixelDensity(1);
  //fullScreen();
  background(0);
  size(800, 600);
  
  startMinA = -2;
  startMaxA = 2;
  startMinB = (height * startMinA) / width;
  startMaxB = (height * startMaxA) / width; 

  minA = startMinA;
  maxA = startMaxA;
  minB = startMinB;
  maxB = startMaxB;
  
  renderer = new Renderer();
  
  renderer.render();
  image(renderer.img, 0, 0);
}

void draw() {
  background(0);

  image(renderer.img, 0, 0);
  
  fill(255);
  textSize(35);
  text(renderer.progress + "%", 10, 50);
}

void mousePressed() {
  float mappedX = map(mouseX, 0, width, minA, maxA);
  float aLength = abs(maxA - minA);
  minA = mappedX - aLength / 4;
  maxA = mappedX + aLength / 4;

  float mappedY = map(mouseY, 0, height, minB, maxB);
  float bLength = abs(maxB - minB);
  minB = mappedY - bLength / 4;
  maxB = mappedY + bLength / 4;
  
  renderer.render();
}

color smoothColor(int n, float a, float b) {
  if (n == maxIterations) {
    return color(0, 0, 0);
  } else {
    ArrayList<Integer> pallete = new ArrayList<Integer>();
    pallete.add(color(60, 30, 15));
    pallete.add(color(25, 7, 26));
    pallete.add(color(9, 1, 47));
    pallete.add(color(4, 4, 73));
    pallete.add(color(0, 7, 100));
    pallete.add(color(12, 44, 138));
    pallete.add(color(24, 82, 177));
    pallete.add(color(57, 125, 209));
    pallete.add(color(134, 181, 229));
    pallete.add(color(211, 236, 248));
    pallete.add(color(241, 233, 191));
    pallete.add(color(248, 201, 95));
    pallete.add(color(255, 170, 0));
    pallete.add(color(204, 128, 0));
    pallete.add(color(153, 87, 0));
    pallete.add(color(106, 52, 3));

    float logZn = log(a * a + b * b) / escapeRadius;
    float nu = log(logZn / log(escapeRadius)) / log(escapeRadius);
    float iteration = n + 2 - nu;

    color clr1 = pallete.get(floor(iteration) % pallete.size());
    color clr2 = pallete.get((floor(iteration) + 1) % pallete.size());

    return lerpColor(clr1, clr2, iteration % 1);
  }
}
