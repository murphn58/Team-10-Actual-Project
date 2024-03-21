import java.util.Scanner;

// YUE PAN
Parse parser;
Table table;

// NIAMH AND SADHBH
Table dateTable;
Table mKTCarrierTable;
String[] lines;
int currentLineIndex = 0;
PImage bgImg;
LineGraph lineGraph;

//Interactive buttons - SADHBH
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_BUTTON4 = 4;
final int EVENT_BUTTON5 = 5;
final int EVENT_BUTTON6 = 6;
final int EVENT_NULL = 0;
//ArrayList<Widget> widgetList;

void setup(){
  // NIAMH AND SADHBH
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
  
  Widget widget1, widget2, widget3, widget4, widget5, widget6 ;
  widget1 = new Widget(40, 40, 180, 40, "Airline", color(80, 142, 228), myFont, EVENT_BUTTON1);
  widget2 = new Widget(260, 40, 180, 40, "Destination", color(88, 224, 104), myFont, EVENT_BUTTON2);
  widget3 = new Widget(480, 40, 180, 40, "Date", color(240, 188, 82), myFont, EVENT_BUTTON3);
  widget4 = new Widget(700, 40, 180, 40, "PieChart", color(80, 142, 228), myFont, EVENT_BUTTON4);
  widget5 = new Widget(920, 40, 180, 40, "Line Graph", color(88, 224, 104), myFont, EVENT_BUTTON5);
  widget6 = new Widget(1140, 40, 180, 40, "Bar Graph", color(240, 188, 82), myFont, EVENT_BUTTON6);
  
  widgetList = new ArrayList();
  widgetList.add(widget1);
  widgetList.add(widget2);
  widgetList.add(widget3);
  widgetList.add(widget4);
  widgetList.add(widget5);
  widgetList.add(widget6);
}


void draw(){
  background(bgImg);
  
  // SADHBH
  PieChart airlinePieChart = new PieChart(mKTCarrierTable);
  airlinePieChart.draw(width/2, height/2, 600);
  
  // NIAMH  
  lineGraph = new LineGraph( airlineCounts);
  lineGraph.draw(40, 100, 1200, 500);
  
  //// NIAMH AND SADHBH
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
        println("button 4!");
        break;
      case EVENT_BUTTON5:
        println("button 5!");
        break;
      case EVENT_BUTTON6:
        println("button 6!");
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
