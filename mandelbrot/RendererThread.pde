class RendererThread extends Thread {
  Renderer renderer;
  
  RendererThread(Renderer renderer) {
    this.renderer = renderer;
  }
  
  void run () {
    renderer.render();
  }
}
