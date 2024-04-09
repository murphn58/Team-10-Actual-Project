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
PFont labelsFont; // Niamh for LineGraph 05/04/24 02:00
String titleText;
Boolean homeScr = true;

PImage bgImg;
// declaring image variables - NIAMH 30/3/24
PImage mouseImg;     // declares a variable for the mouse image
PImage houseImg;     // declares a variable for the house image
PImage submitImg;    // declares a variable for the submit image
PImage resetImg;     // declares a variable for the return image
PImage whiteBgImg;   // declares a variable for different baclground for graphs Niamh 04/04/24

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

//Textbox
ArrayList<Widget> textboxButtons;
final int FORWARD_BUTTON = 11;
final int BACKWARD_BUTTON = 12;

void setup() {
  cp5 = new ControlP5(this);      
  size(1407, 946);


  bgImg = loadImage("backgroundCroppedDarker.jpg");
  bgImg.resize(1407,946);
  whiteBgImg = loadImage("whiteBgImgWithHeading.png");   // loading different images for the different backgrounds, Niamh 04/04/24

  myFont = loadFont("Phosphate-Solid-28.vlw");
  textFont(myFont);
 
  
  // YUE PAN 
  parser = new Parse();

  table = parser.createTable("flights_full.csv"); // "flights_full.csv"

  maximumWidths = parser.getColumnWidths(table);
  gui = new Gui();                    
  maximumWidths = parser.getColumnWidths(table);
  myTextlabel = cp5.addTextlabel("columns");
  gui.textlabels("results", 100, 500, 1220, 430, table);
  gui.textBox("results", 100, 500, 1220, 430, table);

  // NIAMH AND SADHBH

 // gui.pie(590, 300, 200);
  
  // NIAMH AND SADHBH 13/3/24
  //lines = loadStrings("flights2k.csv");
  //StoreData storeData = new StoreData();
  //storeData.setup();
  
  // loading images - NIAMH 30/3/24
  houseImg = loadImage("house.png");    // loading in house png to replace home button
  houseImg.resize(55, 40);              // resizing house 
  submitImg = loadImage("submit.png");  // loading in submit png to replace submit button
  submitImg.resize(80, 80);             // resizing submit button
  resetImg = loadImage("reset.png");    // loading in reset png to replace reset button
  resetImg.resize(60, 60);              // resizing reset button
  
  // edited by Ella 9/4/24
  // Interactive buttons - ANNA
  Widget widget1, widget2, widget3, widget4, widget5, widget6, homeWidget, submitWidget, resetWidget;
  widget1 = new Widget(40, 60, 180, 40, "Airline", color(250, 148, 148), myFont, EVENT_BUTTON1);
  widget2 = new Widget(260, 60, 180, 40, "Airport", color(250, 88, 88), myFont, EVENT_BUTTON2);
  widget3 = new Widget(480, 60, 180, 40, "Date", color(250, 48, 48), myFont, EVENT_BUTTON3);
  widget4 = new Widget(1170, 200, 180, 50, "Pie Chart", color(160, 188, 244), myFont, EVENT_BUTTON4);
  widget5 = new Widget(1170, 300, 180, 50, "Line Graph", color(88, 138, 244), myFont, EVENT_BUTTON5);
  widget6 = new Widget(1170, 400, 180, 50, "Bar Graph", color(52, 114, 244), myFont, EVENT_BUTTON6);
  // home, submit, and reset buttons rewritten to work with images, Niamh 01/04/24 13:00
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
  
  //Text Box Buttons
  Widget forwardButton, backButton;
  textboxButtons = new ArrayList<Widget>();
  forwardButton = new Widget(1140, 410, 75, 20, ">>>", color(52, 114, 244), myFont, FORWARD_BUTTON);
  backButton = new Widget(1060, 410, 75, 20, "<<<", color(52, 114, 244), myFont, BACKWARD_BUTTON);
  textboxButtons.add(forwardButton);
  textboxButtons.add(backButton);
   //<>//
  // ELLA //<>//
  pieScreen  = new Screen(color(0), widgetList);
  homeScreen = new Screen(widgetList);
  query = new Query(table); //<>//
  //<>//
  // NIAMH 27/03/24
  mouseImg = loadImage("plane.png");   // load image to replace mouse
  mouseImg.resize(40, 0);              // resizing size of plane image
  noCursor();                          // removes default mouse
  cp5.setAutoDraw(false);
  
 // gui.pieAppendData(query.flightAttributes())
 // initialising Textbox data for large tables
 if(query.getCount() > 10000)
 {
         int totalPages = (int) Math.ceil((double)query.getCount()/ MAXIMUM_LINES);
          int startIndex = gui.returnIndex();
          int endIndex = startIndex + MAXIMUM_LINES; //<>//
          if( gui.returnCurrentPage() >= totalPages) //<>//
          {
            endIndex = query.getCount();
          }
          Table temp = table.copy(); //<>//
          temp.clearRows(); //<>//
          for(int i = startIndex; i < endIndex ; i++)
          {
            temp.addRow((query.getTable()).getRow(i)); //<>//
          } //<>//
          maximumWidths = parser.getColumnWidths(temp);
          gui.textlabels("results", 100, 500, 1220, 430, temp);
          //  gui.textBox("results", 100, 500, 1220, 430, table);

          myTextarea.setText(parser.formatData(temp));
 }
  ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
   
}

void draw(){    
    homeScreen.draw();

    textFont(myFont); //<>//
    // Ella 3/4/24     //<>// //<>// //<>//
    if(homeScr){ //<>// //<>// //<>// //<>//
      myTextlabel.hide(); //<>//
      myTextarea.hide();
     }
    
    else{
      // Ella 3/4/24 edited main to show table only when interacting with query buttons 
        textFont(myFont);     
 //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
    switch(tempSwitch)
    {
      case 0:
        // Interactive buttons - SADHBH
        for (int i = 0; i<widgetList.size(); i++) {
        Widget aWidget = (Widget)widgetList.get(i);
        aWidget.draw();
        }
          
          if(query.getCount() < 10000)
          {
          myTextlabel.show();
          myTextarea.show();
          noStroke();
          fill(0);
          rect(80, 500, 1220, 430,5);
          cp5.draw();
          //myChart.hide();
          }else
          {
            /*
            cp5.draw();
            myChart.show();
            fill(255);
            ellipse(690, 400, 75, 75);
            fill(0);
            String count = "" + query.getCount();
            text(count, 680, 400);
            textAlign(CENTER, CENTER);
            fill(25,75,79);
            rect(820, 340, 20, 20);
            fill(0);
            text("normal", 875, 350);
            fill(221,68,68);
            rect(820, 370, 20, 20);
            fill(0);
            text("cancelled", 885, 380);
            fill(255,220,220);
            rect(820, 400, 20, 20);
            fill(0);
            text("delayed", 877, 410);
            */
          for (int i = 0; i<textboxButtons.size(); i++) {
            Widget bWidget = (Widget)textboxButtons.get(i);
            bWidget.draw(); 
          }
          
          myTextlabel.show();
          myTextarea.show();
          
          noStroke();
          fill(0);
          rect(100, 500, 1200, 450,5);
          cp5.draw();
            
          }
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
        aWidget.draw(); //<>//
        break; //<>// //<>//
       //<>// //<>// //<>//
      case 5: //<>// //<>//
        background(whiteBgImg); //<>//
        myTextlabel.hide();
        myTextarea.hide();
      
        // Creates line graph based on user query NIAMH 27/03/24  
        lineGraph = new LineGraph(query);    // Creates new object of LineGraph class
        lineGraph.draw(100, 130, 1200, 500);  // Draws line graph in specified size at specified co-ordinates
      
        Widget bWidget = (Widget)widgetList.get(widgetList.size() - 3);
        bWidget.draw();
        break;      

      case 6:
        background(whiteBgImg);
        myTextlabel.hide();
        myTextarea.hide();
     
        // AOIFE
        barGraph = new BarGraph(query);
        barGraph.draw(400, 200, 1200, 500);
      
        Widget cWidget = (Widget)widgetList.get(widgetList.size() - 3);
        cWidget.draw();
        break;

      case -1:
        break;

     }
    }
    // NIAMH 27/03/24
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
          hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
        } else {
          showTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)", 480, 80);
        }
        isDateTextboxVisible = !isDateTextboxVisible;                // Toggle the visibility status
        
        homeScr = false;
        break;
      
      case EVENT_BUTTON4:
        tempSwitch = 4;
        println("button 4!");

        hideTextbox("Enter Airline Prefix");
        hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
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
        hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
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
        hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
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
          if(query.getCount() < 10000){
            String output = parser.formatData(query.getTable());
            myTextarea.setText(output);
          }
         
        }else
        {
          println("skipped airlines");
        }
        
        if(isDestinationTextboxVisible && (cp5.get(Textfield.class,"Enter Origin(O:) or Destination(D:), then Airport").getText()).equals("") == false ){
          String input = cp5.get(Textfield.class,"Enter Origin(O:) or Destination(D:), then Airport").getText();
          query.searchStates(input);
          if(query.getCount() < 10000)
          {
            String output = parser.formatData(query.getTable());
            myTextarea.setText(output);
          }
        }else{
           println("skipped destinations");
        }

        if(isDateTextboxVisible && (cp5.get(Textfield.class,"Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)").getText()).equals("") == false ){
          String input = cp5.get(Textfield.class,"Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)").getText();
          try{
            println("entering query with " + input);
            query.searchDates(input);
          }
          catch(Exception e){
          }
          if(query.getCount() < 10000)
          {
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
          }
        }else{
          println("skipped dates");
        }

          homeScr = false;       
        //  gui.pieAppendData(query.flightAttributes());
        if(query.getCount() < 10000)
        {
          gui.textlabels("results", 80, 500, 1220, 470, query.getTable());
        }
        if(query.getCount() > 10000)
 {
         int totalPages = (int) Math.ceil((double)query.getCount()/ MAXIMUM_LINES);
          int startIndex = gui.returnIndex();
          int endIndex = startIndex + MAXIMUM_LINES;
          if( gui.returnCurrentPage() >= totalPages)
          {
            endIndex = query.getCount();
          }
          Table temp = table.copy();
          temp.clearRows();
          for(int i = startIndex; i < endIndex ; i++)
          {
            temp.addRow((query.getTable()).getRow(i));
          }
          maximumWidths = parser.getColumnWidths(temp);
          gui.textlabels("results", 80, 500, 12207, 470, temp);
          myTextarea.setText(parser.formatData(temp));
 }
        break;
      
      //ELLA 18/3/24
      case RESET_BUTTON:
        tempSwitch = 0;                    // switch to homeScreen
        query.reset();
        hideTextbox("search airlines");
        hideTextbox("search date");
        hideTextbox("search airport");


        hideTextbox("Enter Airline Prefix");
        hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
        hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");

        isAirlineTextboxVisible = false;
        isDestinationTextboxVisible = false;
        isDateTextboxVisible = false;
        hideAllTextBoxes();
        
        if(query.getCount() < 10000)
        {
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
        }
        homeScr = true;

if(query.getCount() > 10000)
 {
         int totalPages = (int) Math.ceil((double)query.getCount()/ MAXIMUM_LINES);
          int startIndex = gui.returnIndex();
          int endIndex = startIndex + MAXIMUM_LINES;
          if( gui.returnCurrentPage() >= totalPages)
          {
            endIndex = query.getCount();
          }
          Table temp = table.copy();
          temp.clearRows();
          for(int i = startIndex; i < endIndex ; i++)
          {
            temp.addRow((query.getTable()).getRow(i));
          }
          maximumWidths = parser.getColumnWidths(temp);
          gui.textlabels("results", 100, 500, 1220, 470, temp);
          myTextarea.setText(parser.formatData(temp));
 }        break;
        
     
    }
  }
  for(Widget widget : textboxButtons)
  {
    int event = widget.getEvent(mouseX, mouseY);                     // determines if mouse is pressed within the bounds of the widget and returns an event type.
    switch (event){
       case FORWARD_BUTTON:
       gui.textboxForward();
       break;
       
       case BACKWARD_BUTTON:
       gui.textboxBackward();
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
        hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
        isDateTextboxVisible = !isDateTextboxVisible;
    }
}
