class RendererThread extends Thread {
  Renderer renderer;
  
  RendererThread(Renderer renderer) {
    this.renderer = renderer;
  }
  
  void run () {
    PGraphics img = createGraphics(width, height);
    img.beginDraw();
    img.loadPixels();
    int total = width * height;
    int current = 1;
    
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        float a = map(x - width / 8, 0, width, minA, maxA);
        float b = map(y, 0, height, minB, maxB);
  
        float ca = a;
        float cb = b;
  
        int n = 0;
  
        while (n < maxIterations) {
          float aa = a * a - b * b;
          float bb = 2 * a * b;
  
          a = aa + ca;
          b = bb + cb;
  
          if (a * a + b * b > escapeRadius * escapeRadius) {
            break;
          }
  
          n++;
        }
        
        int i = x + width*y;
        img.pixels[i] = smoothColor(n, a, b);
        renderer.progress = (int) Math.round((float)current / total * 100);
        current++;
        
      }
    }
    
    img.updatePixels();
    img.endDraw();
    
    renderer.img = img;
  }
}
