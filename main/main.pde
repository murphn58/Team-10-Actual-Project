import controlP5.*;
import java.util.Scanner;
import java.util.Date;
import java.text.SimpleDateFormat;

// YUE PAN
Chart myChart;
int[] maximumWidths;
Parse parser;
Table table;

Table dateTable;
Table mKTCarrierTable;
String[] lines;
int currentLineIndex = 0;

PFont title;      //ella   3/4/24
PFont myFont;
String titleText;
Boolean homeScr = true;

PImage bgImg;
// declaring image variables - NIAMH 30/3/24
PImage mouseImg;     // declare a variable for the mouse image
PImage houseImg;     // declare a variable for the house image
PImage submitImg;    // declare a variable for the submit image
PImage resetImg;     // declare a variable for the return image
PImage whiteBgImg;

ControlP5 cp5;
Textlabel myTextlabel;
Textarea myTextarea;
Gui gui;
Screen currentScreen, homeScreen, pieScreen;
LineGraph lineGraph;
Query query;    // ella

 // Textbox - ANNA 
String userInput;

// search bar - ANNA 27/3/24
boolean isAirlineTextboxVisible = false;      // to track whether the textboxes are currently visible or not. 
boolean isDestinationTextboxVisible = false;
boolean isDateTextboxVisible = false;


// AOIFE 20/3/24
BarGraph barGraph;

int tempSwitch = 0;

//Interactive buttons - SADHBH 13/3/24
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_BUTTON4 = 4;      
final int EVENT_BUTTON5 = 5;
final int EVENT_BUTTON6 = 6;
final int HOME_BUTTON   = 7;
final int EVENT_NULL = 0;
// Ella
final int SUBMIT_BUTTON = 8;
final int RESET_BUTTON = 9;
ArrayList<Widget> widgetList;

void setup() {
  cp5 = new ControlP5(this);      
  size(1407, 946);

  bgImg = loadImage("bgImgWithHeading.png");
  whiteBgImg = loadImage("whiteBgImgWithHeading.png");

  myFont = loadFont("Phosphate-Solid-28.vlw");
  textFont(myFont);
 
  
  // YUE PAN 
  parser = new Parse();
  table = parser.createTable("flights2k.csv");
  maximumWidths = parser.getColumnWidths(table);
  gui = new Gui();                    
  gui.textBox("results", 0, 120, 1407, 470, table);

  // NIAMH AND SADHBH

  gui.pie(590, 700, 200);
  
  // NIAMH AND SADHBH 13/3/24

//  lines = loadStrings("flights_full.csv");
 // StoreData storeData = new StoreData();
 // storeData.setup();
  
  // loading images - NIAMH 30/3/24
  houseImg = loadImage("house.png");
  houseImg.resize(55, 40);
  submitImg = loadImage("submit.png");
  submitImg.resize(70, 70);
  resetImg = loadImage("reset.png");
  resetImg.resize(50, 50);
  
  // Interactive buttons - ANNA
  Widget widget1, widget2, widget3, widget4, widget5, widget6, homeWidget, submitWidget, resetWidget;
  widget1 = new Widget(40, 60, 180, 40, "Airline", color(250, 148, 148), myFont, EVENT_BUTTON1);
  widget2 = new Widget(260, 60, 180, 40, "Airport", color(250, 88, 88), myFont, EVENT_BUTTON2);
  widget3 = new Widget(480, 60, 180, 40, "Date", color(250, 48, 48), myFont, EVENT_BUTTON3);
  widget4 = new Widget(140, 640, 200, 55, "Pie Chart", color(160, 188, 244), myFont, EVENT_BUTTON4);
  widget5 = new Widget(590, 640, 200, 55, "Line Graph", color(88, 138, 244), myFont, EVENT_BUTTON5);
  widget6 = new Widget(1040, 640, 200, 55, "Bar Graph", color(52, 114, 244), myFont, EVENT_BUTTON6);

  homeWidget = new Widget(1250, 775,  houseImg, HOME_BUTTON);
  submitWidget = new Widget(1200, 55, submitImg, SUBMIT_BUTTON);
  resetWidget = new Widget(1300, 60, resetImg, RESET_BUTTON);
  
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
  
  // ELLA
  pieScreen  = new Screen(color(0), widgetList);
  homeScreen = new Screen(widgetList);
  query = new Query(table);
  barGraph = new BarGraph(query);
  
  // NIAMH 27/03/24
  mouseImg = loadImage("plane.png");   // load image to replace mouse
  mouseImg.resize(40, 0);              // choose size of plane image
  noCursor();                          // remove default mouse
  cp5.setAutoDraw(false);
  
  gui.pieAppendData(query.flightAttributes());
  ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
   
}

void draw(){    
    homeScreen.draw();

    textFont(myFont);
    // Ella 3/4/24    
    if(homeScr){ //<>// //<>//
      myTextlabel.hide(); //<>// //<>//
      myTextarea.hide();
     }
    
    else{
      // Ella 3/4/ edited main to show table only when interacting with query buttons 
        textFont(myFont);     
        
      // ELLA and YUE          20/3/24
      switch(tempSwitch)
      {
        case 0:
          // Interactive buttons - SADHBH
          for (int i = 0; i<widgetList.size(); i++) { //<>// //<>//
          Widget aWidget = (Widget)widgetList.get(i); //<>// //<>//
          aWidget.draw();
          }
          myTextlabel.show();
          myTextarea.show();
          fill(0);
          rect(0, 120, 1407, 470);fill(0);
          break;
         //<>// //<>//
        case 4: //<>// //<>//
          background(bgImg);
          myTextlabel.hide();
          myTextarea.hide();
        
          // creates pie chart based on user query - SADHBH 28/3/24
          PieChart pieChart = new PieChart(query);
          pieChart.draw(width/2, height/2, 600);
        
          Widget aWidget = (Widget)widgetList.get(widgetList.size() - 3);
          aWidget.draw();
          break;
        
        case 5: //<>// //<>//
          background(bgImg); //<>// //<>//
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
          barGraph.draw(40, 150, 1200, 500);
        
          Widget cWidget = (Widget)widgetList.get(widgetList.size() - 3);
          cWidget.draw();
          break;
          
        case -1:
          break;
      }

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
        noStroke();
        fill(0);
        rect(0, 120, 1407, 470);
        //590, 700, 200
        cp5.draw();
        fill(255);
        ellipse(690, 800, 75, 75);fill(255);
        fill(0);
        String count = "" + query.getCount();
        text(count, 680, 800);
        textAlign(CENTER, CENTER);
        fill(25,75,79);
        rect(820, 740, 20, 20);
        fill(0);
        text("normal", 875, 750);
        fill(221,68,68);
        rect(820, 770, 20, 20);
        fill(0);
        text("cancelled", 885, 780);
        fill(255,220,220);
        rect(820, 800, 20, 20);
        fill(0);
        text("delayed", 877, 810);
        break;
      
      case 4:
        background(whiteBgImg);
        myTextlabel.hide();
        myTextarea.hide();
      
        // Creates pie chart based on user query - SADHBH 28/3/24
        PieChart pieChart = new PieChart(query);
        ellipseMode(CENTER);
        pieChart.draw(width/2, height/2, 620);
        ellipseMode(RADIUS);
        Widget aWidget = (Widget)widgetList.get(widgetList.size() - 3);
        aWidget.draw();
        break;
      
      case 5: //<>// //<>//
        background(whiteBgImg); //<>// //<>//
        myTextlabel.hide();
        myTextarea.hide();
      
        // NIAMH 27/3/24  
        lineGraph = new LineGraph(query);
        lineGraph.draw(40, 100, 1200, 500);
      
        Widget bWidget = (Widget)widgetList.get(widgetList.size() - 3);
        bWidget.draw();
        break;      

      case 6:
        background(whiteBgImg);
        myTextlabel.hide();
        myTextarea.hide();
     
        // AOIFE
        barGraph.draw(40, 100, 1200, 500);
      
        Widget cWidget = (Widget)widgetList.get(widgetList.size() - 3);
        cWidget.draw();
        break;

      case -1:
        break;

     }
    }
    // NIAMH 27/3/24
    float imgX = mouseX - mouseImg.width / 2;      // image follows x-value of mouse
    float imgY = mouseY - mouseImg.height / 2;     // image follows y-value of mouse
    image(mouseImg, imgX, imgY);                   // draw plane image where mouseX and mouseY are
  
}

//BUTTONS + TEXTBOX - ANNA 18/3/24
void mousePressed() {                                                // determines which box has been pressed
  for (Widget widget : widgetList) {
    int event = widget.getEvent(mouseX, mouseY);                     // determines if mouse is pressed within the bounds of the widget and returns an event type.
    switch (event) {                                                 // handles different types of events. 
      case EVENT_BUTTON1:
        println("airline");
        if (isAirlineTextboxVisible) {                               // checking isAirlineTextboxVisible 
          hideTextbox("Enter Airline Prefix");                       // if textbox is visible calls hideTextbox function
        } else {
          showTextbox("Enter Airline Prefix", 40, 80);               // if false calls showTextbox function
        }
        
        // ella
        homeScr = false;

        isAirlineTextboxVisible = !isAirlineTextboxVisible;          // Toggle the visibility status
        isAirlineTextboxVisible = !isAirlineTextboxVisible;          // Toggle the visibility status, negates current value.
        isAirlineTextboxVisible = !isAirlineTextboxVisible;          // Toggle the visibility status

        break;
        
      case EVENT_BUTTON2:
        println("airport");
        if (isDestinationTextboxVisible) {
          hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");
        } else {
          showTextbox("Enter Origin(O:) or Destination(D:), then Airport", 260, 80);
        }
        isDestinationTextboxVisible = !isDestinationTextboxVisible;  // Toggle the visibility status
        homeScr = false;
        break;
        
      case EVENT_BUTTON3:
        println("date");                                                            
        if (isDateTextboxVisible) {
          hideTextbox("Enter Date Range (XX/XX/XXXX-YY/YY/YYYY)");
        } else {
          showTextbox("Enter Date Range (XX/XX/XXXX-YY/YY/YYYY)", 480, 80);
        }
        isDateTextboxVisible = !isDateTextboxVisible;                // Toggle the visibility status
        
        homeScr = false;
        break;
      
      case EVENT_BUTTON4:
        tempSwitch = 4;
        println("button 4!");

        hideTextbox("Enter Airline Prefix");
        hideTextbox("Enter Date Range (XX/XX/XXXX-YY/YY/YYYY)");
        hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");
        isAirlineTextboxVisible = false;
        isDestinationTextboxVisible = false;
        isDateTextboxVisible = false;

        hideAllTextBoxes();
        homeScr = false;
        break;
      
      case EVENT_BUTTON5:
        tempSwitch = 5;
        println("button 5!");

        hideTextbox("Enter Airline Prefix");
        hideTextbox("Enter Date Range (XX/XX/XXXX-YY/YY/YYYY)");
        hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");
        isAirlineTextboxVisible = false;
        isDestinationTextboxVisible = false;
        isDateTextboxVisible = false;        

        hideAllTextBoxes();
        homeScr = false;
        break;
      
      case EVENT_BUTTON6:
        tempSwitch = 6;
        println("button 6!");

        hideTextbox("Enter Airline Prefix");
        hideTextbox("Enter Date Range (XX/XX/XXXX-YY/YY/YYYY)");
        hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");
        isAirlineTextboxVisible = false;
        isDestinationTextboxVisible = false;
        isDateTextboxVisible = false;        

        hideAllTextBoxes();
        homeScr = false;
        break;
        
      case HOME_BUTTON:
        tempSwitch = 0; // Switch to the home screen
        println("home pressed");
        homeScr = true;
        break;

      //ELLA 18/3/24
      case SUBMIT_BUTTON:

        if( isAirlineTextboxVisible && (cp5.get(Textfield.class,"Enter Airline Prefix").getText()).equals("") == false ){
          String input = cp5.get(Textfield.class,"Enter Airline Prefix").getText();

          query.searchAirline(input);
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
       
        }
        if(isDestinationTextboxVisible && (cp5.get(Textfield.class,"Enter Origin(O:) or Destination(D:), then Airport").getText()).equals("") == false ){
          String input = cp5.get(Textfield.class,"Enter Origin(O:) or Destination(D:), then Airport").getText();
          query.searchStates(input);
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);

        }
        if(isDateTextboxVisible && (cp5.get(Textfield.class,"Enter Date Range (XX/XX/XXXX-YY/YY/YYYY)").getText()).equals("") == false ){
          String input = cp5.get(Textfield.class,"Enter Date Range (XX/XX/XXXX-YY/YY/YYYY)").getText();
          try{
            query.searchDates(input);
          }
          catch(Exception e){
          }
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
        }

          homeScr = false;
        
          gui.pieAppendData(query.flightAttributes());

        break;
      
      //ELLA 18/3/24
      case RESET_BUTTON:
        tempSwitch = 0;                    // switch to homeScreen
        query.reset();
        hideTextbox("search airlines");
        hideTextbox("search date");
        hideTextbox("search airport");


        hideTextbox("Enter Airline Prefix");
        hideTextbox("Enter Date Range (XX/XX/XXXX-YY/YY/YYYY)");
        hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");

        isAirlineTextboxVisible = false;
        isDestinationTextboxVisible = false;
        isDateTextboxVisible = false;
        hideAllTextBoxes();
        
        String output = parser.formatData(query.getTable());
        myTextarea.setText(output);
        homeScr = true;

        gui.pieAppendData(query.flightAttributes());
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

// Ana
void showTextbox(String name, int x, int y) { 
  cp5.addTextfield(name)              //adding textfile using the ControlP5 library 
     .setPosition(x, 100) 
     .setSize(200, 20)
     .setAutoClear(false)             // Disables automatic clearing of the text field
     .setFocus(true);                 // ready for input upon bein disaplayed
}

void hideTextbox(String name) {
  cp5.remove(name);                   // Remove the textfield by its name
}


void hideAllTextBoxes() {
    if(isAirlineTextboxVisible== true)
    {
       hideTextbox("Enter Airline Prefix");
       isAirlineTextboxVisible = !isAirlineTextboxVisible;
    }
    if(isDestinationTextboxVisible ==true)
    {
       hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");
       isDestinationTextboxVisible = !isDestinationTextboxVisible;
    }
    if( isDateTextboxVisible == true)
    {
        hideTextbox("sEnter Date Range (XX/XX/XXXX-YY/YY/YYYY)");
        isDateTextboxVisible = !isDateTextboxVisible;
    }
}
