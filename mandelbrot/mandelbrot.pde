int maxIterations = 5000;
float escapeRadius = 2;
float potential = 8;

Renderer renderer;

void setup() {
  pixelDensity(1);
  //fullScreen();
  background(0);
  size(800, 600);
  
  renderer = new Renderer();
  
  renderer.init();
  renderer.run();
  image(renderer.img, 0, 0);
}

void draw() {
  background(0);

  image(renderer.img, 0, 0);
  renderer.renderProgress(10, 50);
}

void mousePressed() {
  renderer.zoom(mouseX, mouseY, 3);
}
