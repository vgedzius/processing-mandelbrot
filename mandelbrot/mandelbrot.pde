int maxIterations = 5000;
float escapeRadius = 2;
float potential = 8;

Renderer renderer;

void setup() {
  //fullScreen();
  size(800, 600);
  background(0);
  pixelDensity(1);
  
  renderer = new Renderer();
  renderer.init();
  renderer.renderImage();
}

void draw() {
  background(0);

  renderer.renderImage();
  renderer.renderStats();
}

void mousePressed() {
  renderer.zoom(mouseX, mouseY, 3);
}
