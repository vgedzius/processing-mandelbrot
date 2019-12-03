class Renderer {
  public int progress = 0;

  
  private PGraphics img;
  private RendererThread thread;
  
  Renderer() {
    img = createGraphics(width, height);
  }

  void render() {
    thread = new RendererThread(this);
    thread.start();
  }
}
