// switch screen when button is pressed - ELLA

public int SCREENX = 300;
public int SCREENY = 300;
boolean home = true;                                    // determines whether the home screen is to be shown or not

class Screen{
  ArrayList screenWidgets;      
  color     screenColour;
  
  Screen(color screenColour, ArrayList screenWidgets){                              // constructor for graphs
    this.screenColour = screenColour;
     this.screenWidgets = screenWidgets;
      home = false;
  }
  
  Screen( ArrayList screenWidgets){                                                // constructor for home screen
    this.screenWidgets = screenWidgets;
    home = true;
  }
  
  
  void draw(){
    if( home == false){                                                            // background and return home button for graphs
      background(screenColour);
      for(int i = 0; i<screenWidgets.size(); i++){
         Widget aWidget = (Widget)screenWidgets.get(i);
         aWidget.draw();
      }
    }
    else{                                                                         // bgd img for home screen
      background(bgImg);
      for(int i = 0; i<screenWidgets.size(); i++){
        Widget aWidget = (Widget)screenWidgets.get(i);
        aWidget.draw();
      }
    }
  }
  
   
   
  int getEvent(int mouseX, int mouseY){
    int event =0;                                                   // if ( widget pressed ){ determines outcome, return home etc...}
    for(int i = 0; i<screenWidgets.size(); i++){
      Widget aWidget = (Widget) screenWidgets.get(i);
      event = aWidget.getEvent(mouseX,mouseY);            
      if(event != EVENT_NULL){
        return event;
      }
    }
    return EVENT_NULL;
  }
  
   
  
  void add(Widget w){
    screenWidgets.add(w);
  }
  
             
  ArrayList getWidgets(){
    return screenWidgets;
  }
}      
