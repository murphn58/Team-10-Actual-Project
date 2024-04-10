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

//  background - ELLA
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
  bgImg = loadImage("backgroundCroppedDarker.jpg");
  bgImg.resize(1407,946);
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
  gui.textlabels("results",  50, 160, 1300, 450, table);
  gui.textBox("results",  50, 160, 1300, 450, table);
  
  // loading images - NIAMH 30/3/24
  houseImg = loadImage("house.png");    // loading in house png to replace home button
  houseImg.resize(55, 40);              // resizing house 
  submitImg = loadImage("submit.png");  // loading in submit png to replace submit button
  submitImg.resize(80, 80);             // resizing submit button
  resetImg = loadImage("reset.png");    // loading in reset png to replace reset button
  resetImg.resize(60, 60);              // resizing reset button
 
  // widgets edited - ELLA 9/4/24
  // Interactive buttons - ANNA
  // initialising the buttons
  // changing colors to cater for color bliindness - SADHBH 3/4/24
  // changing size/location of buttons - SADHBH 5/4/24
  // button colours changed to better suit new background image - NIAMH 09/04/24 23:50
  Widget widget1, widget2, widget3, widget4, widget5, widget6, homeWidget, submitWidget, resetWidget;
  widget1 = new Widget(40, 55, 180, 50, "Date", color(80, 130, 244), myFont, EVENT_BUTTON3);
  widget2 = new Widget(430, 55, 180, 50, "Airport", color(100, 170, 244), myFont, EVENT_BUTTON2);
  widget3 = new Widget(880, 55, 180, 50, "Airline", color(160, 200, 244), myFont, EVENT_BUTTON1);
  widget4 = new Widget(140, 640, 200, 55, "Pie Chart", color(230, 88, 88), myFont, EVENT_BUTTON4);
  widget5 = new Widget(590, 640, 200, 55, "Line Graph", color(250, 123, 123), myFont, EVENT_BUTTON5);
  widget6 = new Widget(1040, 640, 200, 55, "Bar Graph", color(250, 170, 170), myFont, EVENT_BUTTON6);
  
  // home, submit, and reset buttons rewritten to work with images - NIAMH 01/04/24 13:00
  homeWidget = new Widget(1250, 775,  houseImg, HOME_BUTTON);
  submitWidget = new Widget(1200, 45, submitImg, SUBMIT_BUTTON);
  resetWidget = new Widget(1300, 50, resetImg, RESET_BUTTON);
  
  //Interactive buttons - SADHBH 13/3/24
  widgetList = new ArrayList<Widget>();
  widgetList.add(widget1);
  widgetList.add(widget2);
  widgetList.add(widget3);
  widgetList.add(widget4);
  widgetList.add(widget5);
  widgetList.add(widget6);
  
  //Interactive buttons - NIAMH 13/3/24
  widgetList.add(homeWidget); //<>//
  widgetList.add(submitWidget); //<>//
  widgetList.add(resetWidget);
  
  //Text Box Buttons - YUE //<>//
  Widget forwardButton, backButton, sortButton; //<>//
  textboxButtons = new ArrayList<Widget>();
  // button locations, sizes, and colours changed - NIAMH 09/04/24 23:45
  forwardButton = new Widget(1350, 500, 35, 75, ">>", color(150), myFont, FORWARD_BUTTON);
  backButton = new Widget(10, 500, 35, 75, "<<", color(150), myFont, BACKWARD_BUTTON); 
  sortButton = new Widget(1255, 120, 60, 30, "SORT", color(150), myFont, SORT_BUTTON); 
  textboxButtons.add(forwardButton);
  textboxButtons.add(backButton);
  textboxButtons.add(sortButton); 
 
  // ELLA
  pieScreen  = new Screen(color(0), widgetList);
  homeScreen = new Screen(widgetList);
   //<>//
  query = new Query(table, sortedTable); //<>//
 
  // NIAMH 27/03/24
  mouseImg = loadImage("plane.png");   // load image to replace mouse
  mouseImg.resize(40, 0);              // resizing size of plane image //<>//
  noCursor();                          // removes default mouse //<>//
  
  // YUE
  cp5.setAutoDraw(false); //<>//
    //<>//
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
            temp.addRow((query.getTable()).getRow(i)); //<>//
          } //<>//
          maximumWidths = parser.getColumnWidths(temp);
          gui.textlabels("results", 50, 160, 1300, 450, temp);
          myTextarea.setText(parser.formatData(temp));
  }
  ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
   
}


void draw(){     
    homeScreen.draw();
    // font - SADHBH 
    textFont(myFont);
     //<>//
    // ELLA 3/4/24     
    if(homeScr){ 
      myTextlabel.hide(); 
      myTextarea.hide();
     }
    
    else{
        // edited main to show table only when interacting with query buttons - ELLA 3/4/24 
        textFont(myFont);   //<>//
    
    // ELLA and YUE 20/3/24
    // displays widgets and table on home screen but graphs when graphs buttons pressed
    switch(tempSwitch)
    {
      case 0:
        //Interactive buttons - SADHBH 13/3/24
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
          rect(50, 160, 1300, 450);
          cp5.draw();
        }
        else {
          for (int i = 0; i<textboxButtons.size(); i++) {
            Widget bWidget = (Widget)textboxButtons.get(i);
            bWidget.draw(); 
          }
          
          myTextlabel.show();
          myTextarea.show();
          
          noStroke();
          fill(0);
          rect(50, 160, 1300, 450);
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
        aWidget.draw();        //<>//
        break;  //<>//
    
      case 5: 
        background(whiteBgImg); 
        myTextlabel.hide();
        myTextarea.hide();
      
        // Creates line graph based on user query - NIAMH 27/03/24  
        lineGraph = new LineGraph(query);    // Creates new object of LineGraph class
        lineGraph.draw(100, 130, 1200, 500);  // Draws line graph in specified size at specified co-ordinates
      
        Widget bWidget = (Widget)widgetList.get(widgetList.size() - 3);
        bWidget.draw();      //<>//
        break;      
 //<>//
      case 6: //<>//
        background(whiteBgImg); //<>//
        myTextlabel.hide(); //<>//
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


    // button graphics - AOIFE 3/4/24
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

    // button graphics - AOIFE 3/4/24
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

    // button graphics - AOIFE 3/4/24
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


// buttons and textbox - ANNA 18/3/24
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
          showTextbox("Enter Airline Prefix", 880, 80);               // if false calls showTextbox function
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
          showTextbox("Enter Origin(O:) or Destination(D:), then Airport", 430, 80);
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
          showTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)", 40, 80);
        }
        isDateTextboxVisible = !isDateTextboxVisible;                // Toggle the visibility status
        
        homeScr = false;
        
        break;
        
     // if pie chart button is pressed 
      case EVENT_BUTTON4:
        tempSwitch = 4;
        println("button 4!");

        hideAllTextBoxes();
        
        homeScr = false;
        
        break;
      
     // if line graph button is pressed  
      case EVENT_BUTTON5:
        tempSwitch = 5;
        println("button 5!");
        
        hideAllTextBoxes();

        homeScr = false;
        
        break;
      
      // if bar graph button is pressed 
      case EVENT_BUTTON6:
        tempSwitch = 6;
        println("button 6!");

        hideAllTextBoxes();
        
        homeScr = false;
        
        break;
       // if home button is pressed 
      case HOME_BUTTON:
        tempSwitch = 0;  // Switch to the home screen
        println("home pressed");        
        homeScr = true;        
        break;

      //ELLA 18/3/24
      // if submit button is pressed
      case SUBMIT_BUTTON:
      gui.resetIndices();
      // determines what textbox has been used
      
        if( isAirlineTextboxVisible && (cp5.get(Textfield.class,"Enter Airline Prefix").getText()).equals("") == false ){
          String input = cp5.get(Textfield.class,"Enter Airline Prefix").getText();
          query.searchAirline(input);
          if(query.getCount() < 10000){
            String output = parser.formatData(query.getTable());
            myTextarea.setText(output);
          }
        }
        else {
          println("skipped airlines");
        }
        
        if(isDestinationTextboxVisible && (cp5.get(Textfield.class,"Enter Origin(O:) or Destination(D:), then Airport").getText()).equals("") == false ){
          String input = cp5.get(Textfield.class,"Enter Origin(O:) or Destination(D:), then Airport").getText();
          query.searchStates(input);
          if(query.getCount() < 10000) {
            String output = parser.formatData(query.getTable());
            myTextarea.setText(output);
          }
        }
        else {
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
          if(query.getCount() < 10000) {
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
          }
        }
        else {
          println("skipped dates");
        }

        homeScr = false;       
        
        // YUE
        // formats table depending on size of result
        if(query.getCount() < 10000) {
          gui.textlabels("results",  50, 160, 1300, 450, query.getTable());
        }
        if(query.getCount() > 10000) {
          int totalPages = (int) Math.ceil((double)query.getCount()/ MAXIMUM_LINES);
          int startIndex = gui.returnIndex();
          int endIndex = startIndex + MAXIMUM_LINES;
          if( gui.returnCurrentPage() >= totalPages) {
            endIndex = query.getCount();
          }
          Table temp = table.copy();
          temp.clearRows();
          for(int i = startIndex; i < endIndex ; i++) {
            temp.addRow((query.getTable()).getRow(i));
          }
          maximumWidths = parser.getColumnWidths(temp);
          gui.textlabels("results", 50, 160, 1300, 450, temp);
          myTextarea.setText(parser.formatData(temp));
        }
        
        break;
      
      //ELLA 18/3/24
      case RESET_BUTTON:
        tempSwitch = 0;                    // switch to homeScreen
        query.reset();                     // reset table back to original data table
        
        hideAllTextBoxes();
        
        // YUE
        // formats table depending on size of result
        if(query.getCount() < 10000) {
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
        }
        if(query.getCount() > 10000) {
          gui.resetIndices();
          int totalPages = (int) Math.ceil((double)query.getCount()/ MAXIMUM_LINES);
          int startIndex = gui.returnIndex();
          int endIndex = startIndex + MAXIMUM_LINES;
          if( gui.returnCurrentPage() >= totalPages) {
            endIndex = query.getCount();
          }
          Table temp = table.copy();
          temp.clearRows();
          for(int i = startIndex; i < endIndex ; i++) {
            temp.addRow((query.getTable()).getRow(i));
          }
          maximumWidths = parser.getColumnWidths(temp);
          gui.textlabels("results", 50, 160, 1300, 450, temp);
          myTextarea.setText(parser.formatData(temp));
        }
        
        homeScr = true;

        break;
    }
  }
  
  // YUE
  for(Widget widget : textboxButtons) {
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
       
       // if airline prefix is entered return table with that prefix
       if( isAirlineTextboxVisible && (cp5.get(Textfield.class,"Enter Airline Prefix").getText()).equals("") == false ){
          String input = cp5.get(Textfield.class,"Enter Airline Prefix").getText();
          query.searchAirline(input);
          if(query.getCount() < 10000){
            String output = parser.formatData(query.getTable());
            myTextarea.setText(output);
          }
       }
       else {
          println("skipped airlines");
        }
       
       // if airport is entered return table with that airport
       if(isDestinationTextboxVisible && (cp5.get(Textfield.class,"Enter Origin(O:) or Destination(D:), then Airport").getText()).equals("") == false ){
         String input = cp5.get(Textfield.class,"Enter Origin(O:) or Destination(D:), then Airport").getText();
         query.searchStates(input);
         if(query.getCount() < 10000) {
            String output = parser.formatData(query.getTable());
            myTextarea.setText(output);
          }
       }
       else{
           println("skipped destinations");
       }
        
       // if date range is entered return table with that date range
       if(isDateTextboxVisible && (cp5.get(Textfield.class,"Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)").getText()).equals("") == false ){
          String input = cp5.get(Textfield.class,"Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)").getText();
          try{
            println("entering query with " + input);
            query.searchDates(input);
          }
          catch(Exception e){
          }
          if(query.getCount() < 10000) {
          String output = parser.formatData(query.getTable());
          myTextarea.setText(output);
          }
       }
       else{
          println("skipped dates");
       }

       homeScr = false;       
        
        // YUE
        // formats return table depending on size of results
       if(query.getCount() < 10000) {
          gui.textlabels("results", 50, 160, 1300, 450, query.getTable());
       }
       if(query.getCount() > 10000) {  
          gui.resetIndices();
          int totalPages = (int) Math.ceil((double)query.getCount()/ MAXIMUM_LINES);
          int startIndex = gui.returnIndex();
          int endIndex = startIndex + MAXIMUM_LINES;
          if( gui.returnCurrentPage() >= totalPages) {
            endIndex = query.getCount();
          }
          Table temp = table.copy();
          temp.clearRows();
          for(int i = startIndex; i < endIndex ; i++) {
            temp.addRow((query.getTable()).getRow(i));
          }
          maximumWidths = parser.getColumnWidths(temp);
          gui.textlabels("results",50, 160, 1300, 450, temp);
          myTextarea.setText(parser.formatData(temp));
       }       
       break;
    }
  }
}


// if mouse is hovering over widgets highlight them
void mouseMoved() {
  for (Widget widget : widgetList) {
    int event = widget.getEvent(mouseX, mouseY);
    if (event != EVENT_NULL) {
      widget.mouseOver();
    } 
    else {
      widget.mouseNotOver();
    }
  }
  for(Widget widget: textboxButtons){
     int event = widget.getEvent(mouseX, mouseY);
    if (event != EVENT_NULL) {
      widget.mouseOver();
    } 
    else {
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
    if(isAirlineTextboxVisible== true) {
       hideTextbox("Enter Airline Prefix");
       isAirlineTextboxVisible = !isAirlineTextboxVisible;
    }
    if(isDestinationTextboxVisible ==true) {
       hideTextbox("Enter Origin(O:) or Destination(D:), then Airport");
       isDestinationTextboxVisible = !isDestinationTextboxVisible;
    }
    if( isDateTextboxVisible == true) {
        hideTextbox("Enter Date Range (MM/DD/YYYY-MM/DD/YYYY)");
        isDateTextboxVisible = !isDateTextboxVisible;
    }
}
