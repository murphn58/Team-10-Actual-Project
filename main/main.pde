// aka testParse
import java.util.Scanner;

Table table;
Parse parser;
String[] lines;
int currentLineIndex = 0;
Table dateTable;
Table mKTCarrierTable;
PImage bgImg;
//PImage mouseImg;

//Interactive buttons//
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_NULL = 0;
ArrayList widgetList;

void setup() {
  parser = new Parse();
  table = parser.createTable("flights2k.csv");

  table.print();
  size(1407, 946);
  bgImg = loadImage("bgImg.png");
  PFont myFont = loadFont("Phosphate-Solid-28.vlw");
  textFont(myFont);
  lines = loadStrings("flights2k.csv");
  StoreData storeData = new StoreData();
  storeData.setup();
  Widget widget1, widget2, widget3;
  widget1 = new Widget(40, 40, 180, 40, "Airline", color(80, 142, 228), myFont, EVENT_BUTTON1);
  widget2 = new Widget(260, 40, 180, 40, "Destination", color(88, 224, 104), myFont, EVENT_BUTTON2);
  widget3 = new Widget(480, 40, 180, 40, "Date", color(240, 188, 82), myFont, EVENT_BUTTON3);

  widgetList = new ArrayList();
  widgetList.add(widget1);
  widgetList.add(widget2);
  widgetList.add(widget3);
}

//Example usage of Parse
void draw() {
  background(bgImg);
  if (currentLineIndex < lines.length) {
    if (currentLineIndex>0) {
      fill(0);
      text(lines[currentLineIndex], 20, 450);
      delay(500);
    }
    currentLineIndex++;
  }
  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = (Widget)widgetList.get(i);
    aWidget.draw();
  }
}
