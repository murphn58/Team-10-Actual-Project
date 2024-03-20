import java.util.Scanner;

Parse parser;
Table table;
Table dateTable;
Table mKTCarrierTable;

String[] lines;
int currentLineIndex = 0;

PImage bgImg;


void setup(){
  size(1407, 946);
  bgImg = loadImage("bgImg.png");
  PFont myFont = loadFont("Phosphate-Solid-28.vlw");
  textFont(myFont);
    
  parser = new Parse();
  table = parser.createTable("flights2k.csv");
  table.print();
  
  lines = loadStrings("flights2k.csv");
  StoreData storeData = new StoreData();
  storeData.setup();
}

void draw(){
  background(bgImg);
  
  PieChart airlinePieChart = new PieChart(mKTCarrierTable);
  airlinePieChart.draw(width/2, height/2, 800);
  
  if (currentLineIndex < lines.length) {
    if (currentLineIndex>0) {
      fill(0);
      text(lines[currentLineIndex], 40, 450);
      delay(400);
    }
    currentLineIndex++;
  }
}
