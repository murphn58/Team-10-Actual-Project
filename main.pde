import controlP5.*;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.HashMap; 
import processing.core.PApplet;

Table table;
Parse parser;
ControlP5 cp5;
Textlabel myTextlabel;
Textarea myTextarea;
Gui gui;
BarGraph barGraph; 

String[] lines;
int currentLineIndex = 0;
Table dateTable;
Table mKTCarrierTable;
PImage bgImg;
int tempSwitch = 1;
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_NULL = 0;
ArrayList widgetList;

void setup() {
    size(1407, 946);
    parser = new Parse();
    gui = new Gui();
    table = parser.createTable("flights2k.csv");
    cp5 = new ControlP5(this);                        
    gui.textBox("results", 0, 0, 1407, 946, table);
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

    // Extract dates and count flights for each date
    HashMap<String, Integer> flightsPerDate = parser.extractDateAndCountFlights(table);

    // Create a list of dates and flight counts for the bar graph
    ArrayList<String> dates = new ArrayList<String>(flightsPerDate.keySet());
    ArrayList<Integer> flightCounts = new ArrayList<Integer>(flightsPerDate.values());

    // Create a BarGraph object with dates and flight counts
    barGraph = new BarGraph(dates, flightCounts, 200, 600, 20, 400); // Adjust position and size as needed
}

void draw() {
    background(255); // Set background color to white
    barGraph.draw(); // Draw the bar graph
}
