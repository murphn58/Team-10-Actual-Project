class Button {
  int x, y, width, height;
  String label; 
  int event;
  color buttonColor, labelColor, lineColor; 
  PFont buttonFont;
  
  static final int EVENT_NULL = 0;

  Button(int x, int y, int width, int height, String label, color buttonColor, int event) {
    this.x = x; 
    this.y = y; 
    this.width = width; 
    this.height = height; 
    this.label = label; 
    this.event = event; 
    this.buttonColor = buttonColor; 
    this.labelColor = color(0); 
    this.lineColor = color(0);
  }
  
  void draw() {
    fill(buttonColor); 
    stroke(lineColor); 
    rect(x, y, width, height); 
    fill(labelColor);
    textAlign(CENTER, CENTER); // Center text horizontally and vertically
    textSize(40);
    
    // Calculate the x-coordinate for centering the text
    float textX = x + width / 2;
    float textY = y + height / 2;
    
    text(label, textX, textY);
  }
  
     void mouseOver() { 
    lineColor = color(255);
  }
  
  void mouseNotOver() {
    lineColor = color(0); 
  }
  
  int getEvent(int mX, int mY) {
    if (mX > x && mX < x + width && mY > y && mY < y + height) {
      return event;
    }
    return EVENT_NULL;
  }
}
