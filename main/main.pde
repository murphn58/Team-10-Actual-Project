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
ControlP5 cp5;
Textlabel myTextlabel;
Textarea myTextarea;
Gui gui;
Screen currentScreen, homeScreen, pieScreen;
LineGraph lineGraph;
Query query;
String userInput;
 // TEXTBOX - ANNA 
boolean isAirlineTextboxVisible = false;
boolean isDestinationTextboxVisible = false;
boolean isDateTextboxVisible = false;

// AOIFE 20/3/24
BarGraph barGraph;

int tempSwitch = 0;
//Interactive buttons - SADHBH
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_BUTTON4 = 4;      //pie screen
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
  widget1 = new Widget(40, 40, 180, 40, "Airline", color(80, 142, 228), myFont, EVENT_BUTTON1);
  widget2 = new Widget(260, 40, 180, 40, "Destination", color(88, 224, 104), myFont, EVENT_BUTTON2);
  widget3 = new Widget(480, 40, 180, 40, "Date", color(240, 188, 82), myFont, EVENT_BUTTON3);
  widget4 = new Widget(140, 600, 200, 55, "Pie Chart", color(143,194,211), myFont, EVENT_BUTTON4);
  widget5 = new Widget(590, 600, 200, 55, "Line Graph", color(143,194,211), myFont, EVENT_BUTTON5);
  widget6 = new Widget(1040, 600, 200, 55, "Bar Graph", color(143,194,211), myFont, EVENT_BUTTON6);
  homeWidget = new Widget(1200, 800, 100, 55, "Home", color(200, 50, 100), myFont, HOME_BUTTON);
  submitWidget = new Widget(700, 40, 180, 40, "Submit", color( 100,0,200), myFont, SUBMIT_BUTTON);
  resetWidget = new Widget(940, 40, 180,40, "Reset", color(255), myFont, RESET_BUTTON);
  
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
  
  
  // screens ELLA
  pieScreen  = new Screen(color(0), widgetList);
  homeScreen = new Screen(widgetList);
  
   // Extract dates and count flights for each date
  HashMap<String, Integer> flightsPerDate = parser.extractDateAndCountFlights(table);
  
    // Create a list of dates and flight counts for the bar graph - AOIFE 
  ArrayList<String> dates = new ArrayList<String>(flightsPerDate.keySet());
  ArrayList<Integer> flightCounts = new ArrayList<Integer>(flightsPerDate.values());
  barGraph = new BarGraph(dates, flightCounts, 200, 600, 20, 400);

  query = new Query(table);
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
      background(255);
      myTextlabel.hide();
      myTextarea.hide();
      PieChart airlinePieChart = new PieChart(mKTCarrierTable);
      airlinePieChart.draw(width/2, height/2, 400);
      Widget aWidget = (Widget)widgetList.get(widgetList.size() - 3);
      aWidget.draw();
      break;
      
      case 5:
      background(255);
      myTextlabel.hide();
      myTextarea.hide();
      // NIAMH  
      lineGraph = new LineGraph( mKTCarrierTable);
      lineGraph.draw(40, 100, 1200, 500);
      Widget bWidget = (Widget)widgetList.get(widgetList.size() - 3);
      bWidget.draw();
      break;
      
      case 6:
      background(255);
        // AOIFE
      myTextlabel.hide();
      myTextarea.hide();
      Widget cWidget = (Widget)widgetList.get(widgetList.size() - 3);
      cWidget.draw();
      barGraph.draw();
      break;
      
      case -1:
      break;
      
    }
 }

//BUTTONS + TEXTBOX - ANNA 
void mousePressed() {
  for (Widget widget : widgetList) {
    int submit =0;                                                              // determines which box has been pressed
    int event = widget.getEvent(mouseX, mouseY); 
    switch (event) {
      case EVENT_BUTTON1:
        println("airline");
        submit = 1;
        if (isAirlineTextboxVisible) {
          hideTextbox("search airlines");
        } else {
          showTextbox("search airlines", 40, 80);
        }
        isAirlineTextboxVisible = !isAirlineTextboxVisible; // Toggle the visibility status
        break;
      case EVENT_BUTTON2:
        println("airport");
        submit = 2;
        if (isDestinationTextboxVisible) {
          hideTextbox("search airport");
        } else {
          showTextbox("search airport", 260, 80);
        }
        isDestinationTextboxVisible = !isDestinationTextboxVisible; // Toggle the visibility status
        break;
      case EVENT_BUTTON3:
        println("date");
        submit = 3;                                                            
        if (isDateTextboxVisible) {
          hideTextbox("search date");
        } else {
          showTextbox("search date", 480, 80);
        }
        isDateTextboxVisible = !isDateTextboxVisible; // Toggle the visibility status
        break;
      case EVENT_BUTTON4:
        tempSwitch = 4;
        println("button 4!");
        break;
      case EVENT_BUTTON5:
        tempSwitch = 5;
        println("button 5!");
        break;
      case EVENT_BUTTON6:
        tempSwitch = 6;
        println("button 6!");
        break;
      case HOME_BUTTON:
        tempSwitch = 0;
        break;
      case SUBMIT_BUTTON:
      if( isAirlineTextboxVisible ){
        String input = cp5.get(Textfield.class,"search airlines").getText();
        query.sortByAirline(input);
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
        case RESET_BUTTON:
          query.reset();
          hideTextbox("search airlines");
          hideTextbox("search date");
          hideTextbox("search airport");
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
  cp5.addTextfield(name)
     .setPosition(x, y) 
     .setSize(200, 20)
     .setAutoClear(false) // Disables automatic clearing of the text field
     .setFocus(true);  // ready for input upon bein disaplayed
}
void hideTextbox(String name) {
  cp5.remove(name); // Remove the textfield by its name
}
