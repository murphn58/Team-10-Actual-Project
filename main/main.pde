// need controlP5 Library to run, tools => manage tools => libraries => controlP5 - YUE PAN
import controlP5.*;

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

//Interactive buttons - SADHBH
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_NULL = 0;
ArrayList widgetList;

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
  
  // Interactive buttons - SADHBH
  Widget widget1, widget2, widget3;
  widget1 = new Widget(40, 40, 180, 40, "Airline", color(80, 142, 228), myFont, EVENT_BUTTON1);
  widget2 = new Widget(260, 40, 180, 40, "Destination", color(88, 224, 104), myFont, EVENT_BUTTON2);
  widget3 = new Widget(480, 40, 180, 40, "Date", color(240, 188, 82), myFont, EVENT_BUTTON3);
  widgetList = new ArrayList();
  widgetList.add(widget1);
  widgetList.add(widget2);
  widgetList.add(widget3);
}


void draw(){
  background(bgImg);
  
  // SADHBH
  PieChart airlinePieChart = new PieChart(mKTCarrierTable);
  airlinePieChart.draw(width/2, height/2, 800);
  
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
}
