// YUE PAN
Parse parser;
Table table;
Table dateTable;
Table mKTCarrierTable;
String[] lines;
int currentLineIndex = 0;
PImage bgImg;
<<<<<<< Updated upstream
=======
PImage mouseImg; // declare a variable for the mouse image
ControlP5 cp5;
Textlabel myTextlabel;
Textarea myTextarea;
Gui gui;
>>>>>>> Stashed changes
Screen currentScreen, homeScreen, pieScreen;
LineGraph lineGraph;

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
ArrayList<Widget> widgetList;

void setup() {
  size(1407, 946);
  bgImg = loadImage("bgImg.png");
  PFont myFont = loadFont("Phosphate-Solid-28.vlw");
  textFont(myFont);
  
  // YUE PAN
  parser = new Parse();
  table = parser.createTable("flights2k.csv");
  table.print();
  
  // NIAMH AND SADHBH
  lines = loadStrings("flights2k.csv");
  StoreData storeData = new StoreData();
  storeData.setup();
  
  // Interactive buttons - ANNA
  Widget widget1, widget2, widget3, widget4, widget5, widget6, homeWidget;
  widget1 = new Widget(40, 40, 180, 40, "Airline", color(80, 142, 228), myFont, EVENT_BUTTON1);
  widget2 = new Widget(260, 40, 180, 40, "Destination", color(88, 224, 104), myFont, EVENT_BUTTON2);
  widget3 = new Widget(480, 40, 180, 40, "Date", color(240, 188, 82), myFont, EVENT_BUTTON3);
  widget4 = new Widget(140, 600, 200, 55, "Pie Chart", color(143,194,211), myFont, EVENT_BUTTON4);
  widget5 = new Widget(590, 600, 200, 55, "Line Graph", color(143,194,211), myFont, EVENT_BUTTON5);
  widget6 = new Widget(1040, 600, 200, 55, "Bar Graph", color(143,194,211), myFont, EVENT_BUTTON6);
  homeWidget = new Widget(1200, 800, 100, 55, "Home", color(200, 50, 100), myFont, HOME_BUTTON);
  
  widgetList = new ArrayList<Widget>();
  widgetList.add(widget1);
  widgetList.add(widget2);
  widgetList.add(widget3);
  widgetList.add(widget4);
  widgetList.add(widget5);
  widgetList.add(widget6);
  widgetList.add(homeWidget);
  
  
  // screens ELLA
  pieScreen  = new Screen(color(0), widgetList);
  homeScreen = new Screen(widgetList);
  
   // Extract dates and count flights for each date
  HashMap<String, Integer> flightsPerDate = parser.extractDateAndCountFlights(table);
  
    // Create a list of dates and flight counts for the bar graph - AOIFE 
  ArrayList<String> dates = new ArrayList<String>(flightsPerDate.keySet());
  ArrayList<Integer> flightCounts = new ArrayList<Integer>(flightsPerDate.values());
  barGraph = new BarGraph(dates, flightCounts, 200, 600, 20, 400);
  
  mouseImg = loadImage("plane.png"); 
  mouseImg.resize(80, 0);
  noCursor();
}

void draw(){
    homeScreen.draw();
    // ELLA and YUE
    switch(tempSwitch)
    {
    case 0:
    // SADHBH
    
    // NIAMH AND SADHBH
    if (currentLineIndex < lines.length) {
      if (currentLineIndex>0) {
        fill(0);
        text(lines[currentLineIndex], 40, 450);
        delay(400);
      }
      currentLineIndex++;
    }
    
    // Interactive buttons - SADHBH
    for (int i = 0; i<widgetList.size(); i++) {
      Widget aWidget = (Widget)widgetList.get(i);
      aWidget.draw();
    }
      break;
      
      case 4:
      background(255);
      PieChart airlinePieChart = new PieChart(mKTCarrierTable);
      airlinePieChart.draw(width/2, height/2, 400);
      Widget aWidget = (Widget)widgetList.get(widgetList.size() - 1);
      aWidget.draw();
      break;
      
      case 5:
      background(255);
      // NIAMH  
      lineGraph = new LineGraph( airlineCounts);
      lineGraph.draw(40, 100, 1200, 500);
      Widget bWidget = (Widget)widgetList.get(widgetList.size() - 1);
      bWidget.draw();
      break;
      
      case 6:
      background(255);
        // AOIFE
      Widget cWidget = (Widget)widgetList.get(widgetList.size() - 1);
      cWidget.draw();
      barGraph.draw();
      break;
      
    }
    //Niamh
    float imgX = mouseX - mouseImg.width / 2;
    float imgY = mouseY - mouseImg.height / 2;
    image(mouseImg, imgX, imgY);
 }

void mousePressed() {
  for (Widget widget : widgetList) {
    int event = widget.getEvent(mouseX, mouseY); 
    switch (event) {
      case EVENT_BUTTON1:
        println("button 1!");
        break;
      case EVENT_BUTTON2:
        println("button 2!");
        break;
      case EVENT_BUTTON3:
        println("button 3!");
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
