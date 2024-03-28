import controlP5.*;
import java.util.Scanner;
import java.util.Date;
import java.text.SimpleDateFormat;

// YUE PAN
Parse parser;
Table table;

Table dateTable;
Table mKTCarrierTable;
String[] lines;
int currentLineIndex = 0;

PImage bgImg;
PImage mouseImg; // declare a variable for the mouse image

ControlP5 cp5;
Textlabel myTextlabel;
Textarea myTextarea;
Gui gui;
Screen currentScreen, homeScreen, pieScreen;
LineGraph lineGraph;
Query query;

 // TEXTBOX - ANNA 
String userInput;

// search bar - ANNA 
boolean isAirlineTextboxVisible = false;    // to track whether the textboxes are currently visible or not. 
boolean isDestinationTextboxVisible = false;
boolean isDateTextboxVisible = false;

// AOIFE 20/3/24
BarGraph barGraph;

int tempSwitch = 0;

//Interactive buttons - SADHBH
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_BUTTON4 = 4;      
final int EVENT_BUTTON5 = 5;
final int EVENT_BUTTON6 = 6;
final int HOME_BUTTON   = 7;
final int EVENT_NULL = 0;
final int SUBMIT_BUTTON = 8;
final int RESET_BUTTON = 9;
ArrayList<Widget> widgetList;

void setup() {
  cp5 = new ControlP5(this);      
  size(1407, 946);
  bgImg = loadImage("bgImg.png");
  PFont myFont = loadFont("Phosphate-Solid-28.vlw");
  textFont(myFont);
  
  // YUE PAN
  parser = new Parse();
  table = parser.createTable("flights2k.csv");
  gui = new Gui();                    
  gui.textBox("results", 0, 100, 1407, 400,table);
  
  // NIAMH AND SADHBH
  lines = loadStrings("flights2k.csv");
  StoreData storeData = new StoreData();
  storeData.setup();
  
  // Interactive buttons - ANNA
  Widget widget1, widget2, widget3, widget4, widget5, widget6, homeWidget, submitWidget, resetWidget;
  widget1 = new Widget(40, 40, 180, 40, "Airline", color(33, 76, 180), myFont, EVENT_BUTTON1);
  widget2 = new Widget(260, 40, 180, 40, "Airport", color(80, 142, 228), myFont, EVENT_BUTTON2);
  widget3 = new Widget(480, 40, 180, 40, "Date", color(167, 195, 247), myFont, EVENT_BUTTON3);
  widget4 = new Widget(140, 600, 200, 55, "Pie Chart", color(211, 190, 247), myFont, EVENT_BUTTON4);
  widget5 = new Widget(590, 600, 200, 55, "Line Graph", color(164, 84, 245), myFont, EVENT_BUTTON5);
  widget6 = new Widget(1040, 600, 200, 55, "Bar Graph", color(100, 0, 200), myFont, EVENT_BUTTON6);
  homeWidget = new Widget(1250, 750, 65, 40, "Home", color(200, 50, 100), myFont, HOME_BUTTON);
  submitWidget = new Widget(1200, 45, 80, 30, "Submit", color(88, 224, 104), myFont, SUBMIT_BUTTON);
  resetWidget = new Widget(1300, 45, 80, 30, "Reset", color(255, 0, 0), myFont, RESET_BUTTON);
  
  widgetList = new ArrayList<Widget>();
  widgetList.add(widget1);
  widgetList.add(widget2);
  widgetList.add(widget3);
  widgetList.add(widget4);
  widgetList.add(widget5);
  widgetList.add(widget6);
  widgetList.add(homeWidget);
  widgetList.add(submitWidget);
  widgetList.add(resetWidget);
  
  
  // screens - ELLA
  pieScreen  = new Screen(color(0), widgetList);
  homeScreen = new Screen(widgetList);
  
  // Extract dates and count flights for each date - AOIFE
  HashMap<String, Integer> flightsPerDate = parser.extractDateAndCountFlights(table);
  // Create a list of dates and flight counts for the bar graph - AOIFE 
  ArrayList<String> dates = new ArrayList<String>(flightsPerDate.keySet());
  ArrayList<Integer> flightCounts = new ArrayList<Integer>(flightsPerDate.values());
  barGraph = new BarGraph(dates, flightCounts, 200, 600, 20, 400);

  query = new Query(table);
  
  // NIAMH 27/03/24
  mouseImg = loadImage("plane.png");   // load image to replace mouse
  mouseImg.resize(40, 0);              // choose size of plane image
  noCursor();                          // remove default mouse
}

void draw(){
    homeScreen.draw();
    
    // ELLA and YUE
    switch(tempSwitch)
    {
      case 0:
        // Interactive buttons - SADHBH
        for (int i = 0; i<widgetList.size(); i++) {
        Widget aWidget = (Widget)widgetList.get(i);
        aWidget.draw();
        }
        myTextlabel.show();
        myTextarea.show();
        fill(0);
        rect(0, 100, 1407, 400);fill(0);
        break;
      
      case 4:
        background(bgImg);
        myTextlabel.hide();
        myTextarea.hide();
      
        // creates pie chart based on user query - SADHBH 28/3/24
        PieChart pieChart = new PieChart(query);
        pieChart.draw(width/2, height/2, 600);
      
        Widget aWidget = (Widget)widgetList.get(widgetList.size() - 3);
        aWidget.draw();
        break;
      
      case 5: //<>//
        background(bgImg); //<>//
        myTextlabel.hide();
        myTextarea.hide();
      
        // NIAMH 27/3/24  
        lineGraph = new LineGraph(query);
        lineGraph.draw(40, 100, 1200, 500);
      
        Widget bWidget = (Widget)widgetList.get(widgetList.size() - 3);
        bWidget.draw();
        break;      

      case 6:
        background(bgImg);
        myTextlabel.hide();
        myTextarea.hide();
     
        // AOIFE
        barGraph.draw();
      
        Widget cWidget = (Widget)widgetList.get(widgetList.size() - 3);
        cWidget.draw();
        break;

      case -1:
        break;
    }
    
    // NIAMH 27/3/24
    float imgX = mouseX - mouseImg.width / 2;      // image follows x-value of mouse
    float imgY = mouseY - mouseImg.height / 2;     // image follows y-value of mouse
    image(mouseImg, imgX, imgY);                   // draw plane image where mouseX and mouseY are
 }

//BUTTONS + TEXTBOX - ANNA 
void mousePressed() {        // determines which box has been pressed
  for (Widget widget : widgetList) {
    int submit =0;                                  
    int event = widget.getEvent(mouseX, mouseY);     // determines if mouse is pressed within the bounds o f the widget and returns an event type.
    switch (event) {               // handles different types of events. 
      case EVENT_BUTTON1:
        println("airline");
        if (isAirlineTextboxVisible) {    // checking isAirlineTextboxVisible 
          hideTextbox("search airlines");     // if textbox is visible calls hideTextbox function
        } else {
          showTextbox("search airlines", 40, 80);    // if false calls showTextbox function
        }

        isAirlineTextboxVisible = !isAirlineTextboxVisible; // Toggle the visibility status
        isAirlineTextboxVisible = !isAirlineTextboxVisible;         // Toggle the visibility status, negates current value.
        isAirlineTextboxVisible = !isAirlineTextboxVisible;         // Toggle the visibility status
        break;
        
      case EVENT_BUTTON2:
        println("airport");
        if (isDestinationTextboxVisible) {
          hideTextbox("search airport");
        } else {
          showTextbox("search airport", 260, 80);
        }
        isDestinationTextboxVisible = !isDestinationTextboxVisible;  // Toggle the visibility status
        break;
        
      case EVENT_BUTTON3:
        println("date");                                                            
        if (isDateTextboxVisible) {
          hideTextbox("search date");
        } else {
          showTextbox("search date", 480, 80);
        }
        isDateTextboxVisible = !isDateTextboxVisible;                // Toggle the visibility status
        break;
      
      case EVENT_BUTTON4:
        tempSwitch = 4;
        println("button 4!");
        hideAllTextBoxes();
        break;
      
      case EVENT_BUTTON5:
        tempSwitch = 5;
        println("button 5!");
        hideAllTextBoxes();
        break;
      
      case EVENT_BUTTON6:
        tempSwitch = 6;
        println("button 6!");
        hideAllTextBoxes();
        break;
        
      case HOME_BUTTON:
        tempSwitch = 0;
        break;

        //Ella
      case SUBMIT_BUTTON:
        if( isAirlineTextboxVisible ){
          String input = cp5.get(Textfield.class,"search airlines").getText();
          query.searchAirline(input);
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
        }
        if(isDestinationTextboxVisible){
          String input = cp5.get(Textfield.class,"search airport").getText();
          query.searchStates(input);
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
        }
        if(isDateTextboxVisible){
          String input = cp5.get(Textfield.class,"search date").getText();
          try{
            query.searchDates(input);
          }
          catch(Exception e){
          }
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
        }
        break;
      
      //ELLA
      case RESET_BUTTON:
        query.reset();
        hideAllTextBoxes();

        String output = parser.formatData(query.getTable());
        myTextarea.setText(output);
        break;
    }
  }
}

void mouseMoved() {
  for (Widget widget : widgetList) {
    int event = widget.getEvent(mouseX, mouseY);
    if (event != EVENT_NULL) {
      widget.mouseOver();
    } else {
      widget.mouseNotOver();
    }
  }
}

void showTextbox(String name, int x, int y) { 
  cp5.addTextfield(name)   //adding textfile using the ControlP5 library 
     .setPosition(x, y) 
     .setSize(200, 20)
     .setAutoClear(false) // Disables automatic clearing of the text field
     .setFocus(true);  // ready for input upon bein disaplayed
}

void hideTextbox(String name) {
  cp5.remove(name); // Remove the textfield by its name
}


void hideAllTextBoxes() {
    if(isAirlineTextboxVisible== true)
    {
       hideTextbox("search airlines");
       isAirlineTextboxVisible = !isAirlineTextboxVisible;
    }
    if(isDestinationTextboxVisible ==true)
    {
       hideTextbox("search airport");
       isDestinationTextboxVisible = !isDestinationTextboxVisible;
    }
    if( isDateTextboxVisible == true)
    {
        hideTextbox("search date");
        isDateTextboxVisible = !isDateTextboxVisible;
    }
}
