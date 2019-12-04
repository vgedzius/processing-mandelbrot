class Renderer {
  float startMinA;
  float startMaxA;
  float startMinB;
  float startMaxB;
  
  float minA;
  float maxA;
  float minB;
  float maxB;
  
  int progress = 0;

  
  PGraphics img;
  RendererThread thread;
  
  Renderer() {
    img = createGraphics(width, height);
  }
  
  void init() {
    startMinA = -2;
    startMaxA = 2;
    startMinB = (height * startMinA) / width;
    startMaxB = (height * startMaxA) / width; 
  
    minA = startMinA;
    maxA = startMaxA;
    minB = startMinB;
    maxB = startMaxB;
  }
  
  void zoom (int x, int y, int zoom) {
    float mappedX = map(x, 0, width, minA, maxA);
    float aLength = abs(maxA - minA);
    minA = mappedX - aLength / zoom;
    maxA = mappedX + aLength / zoom;
  
    float mappedY = map(y, 0, height, minB, maxB);
    float bLength = abs(maxB - minB);
    minB = mappedY - bLength / zoom;
    maxB = mappedY + bLength / zoom;
    
    run();
  }
  
  void zoom (int x, int y) {
    zoom(x, y, 4);
  }

  void run() {
    thread = new RendererThread(this);
    thread.start();
  }
  
  void render () {
    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    pg.loadPixels();
    int total = width * height;
    int current = 1;
    
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        double a = map(x - width / 8, 0, width, renderer.minA, renderer.maxA);
        double b = map(y, 0, height, renderer.minB, renderer.maxB);
  
        double ca = a;
        double cb = b;
  
        int n = 0;
  
        while (n < maxIterations) {
          double aa = a * a - b * b;
          double bb = 2 * a * b;
  
          a = aa + ca;
          b = bb + cb;
  
          if (a * a + b * b > potential) {
            break;
          }
  
          n++;
        }
        
        int i = x + width*y;
        pg.pixels[i] = getColor(n, a, b);
        renderer.progress = (int) Math.round((float)current / total * 100);
        current++;
        
      }
    }
    
    pg.updatePixels();
    pg.endDraw();
    
    img = pg;
  }
  
  void renderProgress(int x, int y) {
    fill(255);
    textSize(35);
    text(renderer.progress + "%", x, y);
  }
  
  color getColor(int n, double a, double b) {
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

    double logZn = Math.log(a * a + b * b) / escapeRadius;
    double nu = Math.log(logZn / Math.log(escapeRadius)) / Math.log(escapeRadius);
    double iteration = n + 2 - nu;
    float it = (float)iteration;
    
    color clr1 = pallete.get(floor(it) % pallete.size());
    color clr2 = pallete.get((floor(it) + 1) % pallete.size());

    return lerpColor(clr1, clr2, it % 1);
  }
}
}
