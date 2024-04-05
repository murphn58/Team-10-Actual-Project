// widget class for buttons on screen - ANNA

class Widget {
  int x, y, width, height;
  String label;
  int event;
  color widgetColor, labelColor, lineColor;
  PFont widgetFont;
  PImage image;  
 
  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event){
    this.x = x; this.y = y; this.width = width; this.height = height; 
    this.label = label; this.event = event; 
    this.widgetColor = widgetColor; this.widgetFont = widgetFont;
    this.labelColor = color(0); this.lineColor = color(0);
  }
  
// Second Widget constructor to be used for buttons that will appear as images, written by Niamh 28/03/24 17:00 and 01/04/24 13:00
  Widget(int x, int y, PImage image, int event){
    this.x = x; this.y = y; 
    this.event = event; 
    this.image = image;
  }
  
  void draw(){
    // Specific cases for buttons, written by Niamh 01/04/24 
    if(event == HOME_BUTTON)           // For home button  
    {
         image(houseImg, x, y);        // House Image, not rectangle
         height = 55;                  // Height that works for specific image
         width = 45;                   // Width that works for specific image
    }
    else if (event == SUBMIT_BUTTON)   // For submit button
    {     
      image(submitImg, x, y);          // Submit Image, not rectangle
         height = 70;                  // Height that works for specific image
         width = 70;                   // Width that works for specific image
    }
    else if (event == RESET_BUTTON)    // For reset button
    {     
      image(resetImg, x, y);          // Reset Image, not rectangle
         height = 50;                 // Height that works for specific image
         width = 50;                  // Width that works for specific image
    }
    else{                             // Or if it's any other button
         fill(widgetColor);
         stroke(lineColor);
         rect(x, y, width, height);
         fill(labelColor);
         textAlign(LEFT, BOTTOM);
         textSize(16);
         text(label, x + 10, y + height - 10);
    }
  }
  
  void mouseOver() { 
    labelColor = color(255);
    //lineColor = color(255);
  }
  
  void mouseNotOver() {
    labelColor = color(0); 
    //lineColor = color(0);
  }
  
  int getEvent(int mX, int mY){
     if (mX > x && mX < x + width && mY > y && mY < y + height){
        return event;
     }
     return EVENT_NULL;
  }
}
