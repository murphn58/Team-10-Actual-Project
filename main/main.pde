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

String userInput;

// search bar - ANNA 
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
  
  query = new Query(table);
  //barGraph = new BarGraph(query);
  
  // NIAMH 27/03/24
  mouseImg = loadImage("plane.png");   // load image to replace mouse
  mouseImg.resize(80, 0);              // choose size of plane image
  noCursor();                          // remove default mouse
}

void draw(){
    homeScreen.draw();
<<<<<<< Updated upstream
    
=======

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
          barGraph = new BarGraph(query);
          barGraph.draw(40, 150, 1200, 500);
        
          Widget cWidget = (Widget)widgetList.get(widgetList.size() - 3);
          cWidget.draw();
          break;
          
        case -1:
          break;
      }

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        break;
      
      case 5:
        background(bgImg); //<>//
=======
        break; //<>//
       //<>//
      case 5: //<>//
        background(whiteBgImg); //<>//
>>>>>>> Stashed changes
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
        barGraph.draw(40, 100, 1200, 500);
      
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
<<<<<<< Updated upstream
 }
=======
    
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
>>>>>>> Stashed changes

//BUTTONS + TEXTBOX - ANNA 
void mousePressed() {
  for (Widget widget : widgetList) {
    int submit =0;                                                  // determines which box has been pressed
    int event = widget.getEvent(mouseX, mouseY); 
    switch (event) {
      case EVENT_BUTTON1:
        println("airline");
        if (isAirlineTextboxVisible) {
          hideTextbox("search airlines");
        } else {
          showTextbox("search airlines", 40, 80);
        }
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
