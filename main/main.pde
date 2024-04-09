import controlP5.*;
import java.util.Scanner;
import java.util.Date;
import java.text.SimpleDateFormat;

// YUE PAN
Chart myChart;
int[] maximumWidths;
Parse parser;
Table table, sortedTable;

//ELLA 3/4/24
PFont title; 

// default font for buttons - SADHBH 5/4/24
PFont myFont;

// For LineGraph and Bar Graph - NIAMH and SADHBH 5/4/24
PFont labelsFont;
PFont axesFont;
PFont lineGraphKey;

String titleText;
Boolean homeScr = true;

// cloud background - SADHBH
PImage bgImg;

// declaring image variables - NIAMH 30/3/24
PImage mouseImg;     // declares a variable for the mouse image
PImage houseImg;     // declares a variable for the house image
PImage submitImg;    // declares a variable for the submit image
PImage resetImg;     // declares a variable for the return image
PImage whiteBgImg;   // declares a variable for different baclground for graphs Niamh 04/04/24

// YUE
ControlP5 cp5;
Textlabel myTextlabel;
Textarea myTextarea;
Gui gui;

// ELLA
Query query; 
Screen currentScreen, homeScreen, pieScreen;

// NIAMH
LineGraph lineGraph;

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
// ELLA
final int SUBMIT_BUTTON = 8;
final int RESET_BUTTON = 9;
ArrayList<Widget> widgetList;

//Textbox buttons - YUE
ArrayList<Widget> textboxButtons;
final int FORWARD_BUTTON = 11;
final int BACKWARD_BUTTON = 12;
final int SORT_BUTTON = 13;

void setup() {
  cp5 = new ControlP5(this);      
  size(1407, 946);

  // loading different images for the different backgrounds - NIAMH 4/4/24
  bgImg = loadImage("bgImgWithHeading.png");
  whiteBgImg = loadImage("whiteBgImgWithHeading.png");   

  // Fixing fonts - SADHBH 5/4/24
  myFont = loadFont("VerdanaPro-CondBoldItalic-48.vlw");
 
  // YUE PAN 
  parser = new Parse();
  table = parser.createTable("flights_full.csv"); // "flights_full.csv"
  sortedTable = parser.createTable("flights_full_sorted.csv");

  maximumWidths = parser.getColumnWidths(table);
  gui = new Gui();                    
  maximumWidths = parser.getColumnWidths(table);
  myTextlabel = cp5.addTextlabel("columns");
  gui.textlabels("results", 0, 120, 1407, 470, table);
  gui.textBox("results", 0, 120, 1407, 470, table);
  
  // loading images - NIAMH 30/3/24
  houseImg = loadImage("house.png");    // loading in house png to replace home button
  houseImg.resize(55, 40);              // resizing house 
  submitImg = loadImage("submit.png");  // loading in submit png to replace submit button
  submitImg.resize(70, 70);             // resizing submit button
  resetImg = loadImage("reset.png");    // loading in reset png to replace reset button
  resetImg.resize(50, 50);              // resizing reset button
  
  // Interactive buttons - ANNA
  // initialising the buttons
  // changing colors to cater for color bliindness - SADHBH 3/4/24
  // changing size/location of buttons - SADHBH 5/4/24
  Widget widget1, widget2, widget3, widget4, widget5, widget6, homeWidget, submitWidget, resetWidget;
  widget1 = new Widget(20, 60, 180, 40, "Airline", color(250, 148, 148), myFont, EVENT_BUTTON1);
  widget2 = new Widget(450, 60, 180, 40, "Airport", color(250, 88, 88), myFont, EVENT_BUTTON2);
  widget3 = new Widget(920, 60, 180, 40, "Date", color(250, 48, 48), myFont, EVENT_BUTTON3);
  widget4 = new Widget(140, 640, 200, 55, "Pie Chart", color(160, 188, 244), myFont, EVENT_BUTTON4);
  widget5 = new Widget(590, 640, 200, 55, "Line Graph", color(88, 138, 244), myFont, EVENT_BUTTON5);
  widget6 = new Widget(1040, 640, 200, 55, "Bar Graph", color(52, 114, 244), myFont, EVENT_BUTTON6);
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
  
  //Text Box Buttons - YUE
  Widget forwardButton, backButton, sortButton;
  textboxButtons = new ArrayList<Widget>();
  forwardButton = new Widget(1140, 600, 75, 25, ">>>", color(52, 114, 244), myFont, FORWARD_BUTTON);
  backButton = new Widget(1060, 600, 75, 25, "<<<", color(52, 114, 244), myFont, BACKWARD_BUTTON);
  sortButton = new Widget(1120, 65, 75, 40, "Sort", color(52, 114, 244), myFont, SORT_BUTTON);
  textboxButtons.add(forwardButton);
  textboxButtons.add(backButton);
  textboxButtons.add(sortButton);
  
  // ELLA
  pieScreen  = new Screen(color(0), widgetList);
  homeScreen = new Screen(widgetList);
  query = new Query(table, sortedTable);
 
  // NIAMH 27/03/24
  mouseImg = loadImage("plane.png");   // load image to replace mouse
  mouseImg.resize(40, 0);              // resizing size of plane image
  noCursor();                          // removes default mouse
  
  // YUE
  cp5.setAutoDraw(false);
  
  // initialising Textbox data for large tables
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
          gui.textlabels("results", 0, 120, 1407, 470, temp);
          myTextarea.setText(parser.formatData(temp));
  }
  ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
   
}


void draw(){    
    homeScreen.draw();

    // font - SADHBH 
    textFont(myFont);
    
    // ELLA 3/4/24     
    if(homeScr){ 
      myTextlabel.hide(); 
      myTextarea.hide();
     }
    
    else{
        // edited main to show table only when interacting with query buttons - ELLA 3/4/24 
        textFont(myFont);  //<>// //<>// //<>// //<>// //<>// //<>// //<>//
    
    // ELLA and YUE 20/3/24
    switch(tempSwitch)
    {
      case 0:
        // Interactive buttons - SADHBH
        for (int i = 0; i<widgetList.size(); i++) {
        Widget aWidget = (Widget)widgetList.get(i);
        aWidget.draw();
        }
        
           Widget sortWidget = (Widget)textboxButtons.get(2);
           sortWidget.draw(); 
          
          if(query.getCount() < 10000)
          {
          myTextlabel.show();
          myTextarea.show();
          noStroke();
          fill(0);
          rect(0, 120, 1407, 470);
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
          rect(0, 120, 1407, 470);
          cp5.draw();
            
          }
        
        break;
      
      case 4:
        background(whiteBgImg);
        myTextlabel.hide();
        myTextarea.hide();
      
        // Creates pie chart based on user query - SADHBH 28/3/24
        // Fixing pie chart display - SADHBH 3/4/24
        PieChart pieChart = new PieChart(query);
        ellipseMode(CENTER);
        pieChart.draw(width/2, height/2, 620, 96);
        ellipseMode(RADIUS);
        
        Widget aWidget = (Widget)widgetList.get(widgetList.size() - 3);
        aWidget.draw(); //<>// //<>// //<>//
        
        break; //<>// //<>// //<>//
        //<>// //<>// //<>//
      case 5: //<>// //<>// //<>//
        background(whiteBgImg); //<>// //<>// //<>//
        myTextlabel.hide();
        myTextarea.hide();
      
        // Creates line graph based on user query - NIAMH 27/03/24  
        lineGraph = new LineGraph(query);    // Creates new object of LineGraph class
        lineGraph.draw(100, 130, 1200, 500);  // Draws line graph in specified size at specified co-ordinates
      
        Widget bWidget = (Widget)widgetList.get(widgetList.size() - 3);
        bWidget.draw();
        
        break;      

      case 6:
        background(whiteBgImg);
        myTextlabel.hide();
        myTextarea.hide();
     
        // Creates bar graph based on user query - AOIFE 28/03/24 
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

    // Aoife Mahon 3/3/24
  if (tempSwitch == 0 && mouseX > 140 && mouseX < 340 && mouseY > 640 && mouseY < 695) // Check if the mouse is over the pie chart button, If so, draw pie chart on button
  {
    noStroke(); // No outline
    fill(255); // White fill color
    ellipse(280, 667.5, 20, 20); // Draw a circle at the specified position (assuming the pie chart button's position)

    fill(100); // Dark grey fill color
    // Draw the first segment of the pie chart
    arc(280, 667.5, 20, 20, 20, PI / 2);

    fill(150); // Light grey fill color
    // Draw the second segment of the pie chart
    arc(280, 667.5, 20, 20, PI / 2, TWO_PI / 3);

    // Draw the third segment of the pie chart
    fill(200); // Another shade of grey
    arc(280, 667.5, 20, 20, TWO_PI / 3, PI);
  }

  // Aoife Mahon 3/3/24
  if (tempSwitch == 0 && mouseX > 590 && mouseX < 790 && mouseY > 640 && mouseY < 695) //Check if the mouse is over the linegraph button, If so, draw linegraph on button
  {
    // LINE 1
    // Define the angle of the line in radians (45 degrees)
    float angle1 = PI / 4;
    // Define the length of the line
    float lineLength1 = 30; // Change this value as needed
    // Calculate the end point of the line using trigonometry
    float endX1 = 700 + cos(angle1) * lineLength1;
    float endY1 = 665 + sin(angle1) * lineLength1;

    // Draw the line
    stroke(255); // White outline color
    line(700, 665, endX1, endY1);

    // LINE 2
    float angle2 = 295; // Angle in degrees
    angle2 = radians(angle2);   // Convert degrees to radians
    float lineLength2 = 40;
    float endX2 = endX1 + cos(angle2) * lineLength2;
    float endY2 = endY1 + sin(angle2) * lineLength2;

    // Draw the line
    stroke(255); // White outline color
    line(endX1, endY1, endX2, endY2);

    // LINE 3
    float angle3 = 60; // Angle in degrees
    angle3 = radians(angle3);   // Convert degrees to radians
    float lineLength3 = 35;
    float endX3 = endX2 + cos(angle3) * lineLength3;
    float endY3 = endY2 + sin(angle3) * lineLength3;

    // Draw the line
    stroke(255); // White outline color
    line(endX2, endY2, endX3, endY3);

    // LINE 4
    float angle4 = 300; // Angle in degrees
    angle4 = radians(angle4);   // Convert degrees to radians
    float lineLength4 = 25;
    float endX4 = endX3 + cos(angle4) * lineLength4;
    float endY4 = endY3 + sin(angle4) * lineLength4;

    // Draw the line
    stroke(255); // White outline color
    line(endX3, endY3, endX4, endY4);

    // LINE 5
    float angle5 = 359; // Angle in degrees
    angle5 = radians(angle5);   // Convert degrees to radians
    float lineLength5 = 10;
    float endX5 = endX4 + cos(angle5) * lineLength5;
    float endY5 = endY4 + sin(angle5) * lineLength5;

    // Draw the line
    stroke(255); // White outline color
    line(endX4, endY4, endX5, endY5);
  }

  // Aoife Mahon 3/3/24
  if (tempSwitch == 0 && mouseX > 1040 && mouseX < 1240 && mouseY > 640 && mouseY < 695)   //Check if the mouse is over the bargraph button, If so, draw bargraph on button
  {
    stroke(255);
    fill(255);
    rect(1150, 651, 10, 34);
    rect(1170, 668, 10, 17);
    rect(1190, 660, 10, 25);
    rect(1210, 670, 10, 15);
  }
}


//buttons and textbox - ANNA 18/3/24
// handles actions triggered when the user clicks on any of the buttons represented
void mousePressed() {                                                // determines which box has been pressed
  for (Widget widget : widgetList) {                                 // iterates over each widget
    int event = widget.getEvent(mouseX, mouseY);                     // determines if mouse is pressed within the bounds of the widget and returns an event type.
    switch (event) {                                                 // handles different types of events. 
    
    //if airline button is pressed
      case EVENT_BUTTON1:
        println("airline");
        if (isAirlineTextboxVisible) {                               // checking isAirlineTextboxVisible 
          hideTextbox("Enter Airline Prefix");                       // if textbox is visible calls hideTextbox function
        } else {
          showTextbox("Enter Airline Prefix", 20, 80);               // if false calls showTextbox function
        }
        
        // ELLA
        homeScr = false;

        isAirlineTextboxVisible = !isAirlineTextboxVisible;          // Toggle the visibility status
        isAirlineTextboxVisible = !isAirlineTextboxVisible;          // Toggle the visibility status, negates current value.
        isAirlineTextboxVisible = !isAirlineTextboxVisible;          // Toggle the visibility status

        break;
        
     // if airport button is pressed 
      case EVENT_BUTTON2:
        println("airport");
        if (isDestinationTextboxVisible) {
          hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");
        } else {
          showTextbox("Enter Origin(O:) or Destination(D:), then Airport", 450, 80);
        }
        isDestinationTextboxVisible = !isDestinationTextboxVisible;  // Toggle the visibility status
        homeScr = false;
        break;
     // if date button is pressed 
      case EVENT_BUTTON3:
        println("date");                                                            
        
        if (isDateTextboxVisible) {
          hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
        } else {
          showTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)", 920, 80);
        }
        isDateTextboxVisible = !isDateTextboxVisible;                // Toggle the visibility status
        
        homeScr = false;
        
        break;
        
     // if pie chart button is pressed 
      case EVENT_BUTTON4:
        tempSwitch = 4;
        println("button 4!");

       /* hideTextbox("Enter Airline Prefix");
        hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
        hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");
        isAirlineTextboxVisible = false;
        isDestinationTextboxVisible = false;
        isDateTextboxVisible = false;
        */
        hideAllTextBoxes();
        
        homeScr = false;
        
        break;
      
     // if line graph button is pressed  
      case EVENT_BUTTON5:
        tempSwitch = 5;
        println("button 5!");

       /* hideTextbox("Enter Airline Prefix");
        hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
        hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");
        isAirlineTextboxVisible = false;
        isDestinationTextboxVisible = false;
        isDateTextboxVisible = false;   
        */
        hideAllTextBoxes();

        homeScr = false;
        
        break;
      
      // if bar graph button is pressed 
      case EVENT_BUTTON6:
        tempSwitch = 6;
        println("button 6!");
        
        /*hideTextbox("Enter Airline Prefix");
        hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
        hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");
        isAirlineTextboxVisible = false;
        isDestinationTextboxVisible = false;
        isDateTextboxVisible = false;      
        */
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
      gui.resetIndices();
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
        
        // YUE
        if(query.getCount() < 10000)
        {
          gui.textlabels("results", 0, 120, 1407, 470, query.getTable());
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
          gui.textlabels("results", 0, 120, 1407, 470, temp);
          myTextarea.setText(parser.formatData(temp));
  }
        
        break;
      
      //ELLA 18/3/24
      case RESET_BUTTON:
        tempSwitch = 0;                    // switch to homeScreen
        query.reset();
        
        /*hideTextbox("search airlines");
        hideTextbox("search date");
        hideTextbox("search airport");
        hideTextbox("Enter Airline Prefix");
        hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
        hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");

        isAirlineTextboxVisible = false;
        isDestinationTextboxVisible = false;
        isDateTextboxVisible = false;
        */
        hideAllTextBoxes();
        
        // YUE
        if(query.getCount() < 10000)
        {
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
        }
        if(query.getCount() > 10000)
        {
          gui.resetIndices();
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
          gui.textlabels("results", 0, 120, 1407, 470, temp);
          myTextarea.setText(parser.formatData(temp));
  }
        homeScr = true;

        break;
    }
  }
  
  // YUE
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
       
       case SORT_BUTTON:
       query.sortByLateness();

       println("sort pressed");
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
        
        // YUE
        if(query.getCount() < 10000)
        {
          gui.textlabels("results", 0, 120, 1407, 470, query.getTable());
        }
        if(query.getCount() > 10000)
        {  
          gui.resetIndices();
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
          gui.textlabels("results", 0, 120, 1407, 470, temp);
          myTextarea.setText(parser.formatData(temp));
        }
        
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
  for(Widget widget: textboxButtons){
     int event = widget.getEvent(mouseX, mouseY);
    if (event != EVENT_NULL) {
      widget.mouseOver();
    } else {
      widget.mouseNotOver();
    }
  }
}


// ANNA - textbox 
// displaying a new textbox on the screen using the ControlP5 library
void showTextbox(String name, int x, int y) { 
  cp5.addTextfield(name)              //adding textfile using the ControlP5 library 
     .setPosition(x, 100) 
     .setSize(180, 35)
     .setAutoClear(false)             // Disables automatic clearing of the text field
     .setFont(createFont("Courier New",15))
     .setFocus(true);                 // ready for input upon bein disaplayed
}

// removes the textboxes 
void hideTextbox(String name) {
  cp5.remove(name);                   // Remove the textfield by its name
}

// removes all the tetxboxes 
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
