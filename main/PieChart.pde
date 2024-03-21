// Pie Chart for Airlines - SADHBH 18/3/24

import java.util.HashMap;                                                                      // a collection class in Java that stores items in key/value pairs.

// made global so can be used for line graph.
HashMap<String, Integer> airlineCounts;                                                        // declares HashMap to store airline names (keys), and corresponding counts (values) as integers.

class PieChart { 
  HashMap<String, Integer> airlineColors;                                                      // declares HashMap to store airline names (keys), and corresponding colors as integers. 
  
  PieChart(Table mKTCarrierTable) {                                                           
    airlineCounts = new HashMap<>();                                                           // initializes 'airlineCounts' HashMap. 
    airlineColors = new HashMap<>();                                                           // initializes 'airlineColors' HashMap.
    countAirlines(mKTCarrierTable);                                                            // calls countAirlines() method.
    assignColors();                                                                            // calls assignColors() method.
  }
  
  // Method to count occurrences of each airline in table provided
  void countAirlines(Table mKTCarrierTable){
    for(TableRow row : mKTCarrierTable.rows()) {                                               // iterates through each row of table.
      String airline = row.getString("MKT Carrier");                                           // retrieves String of current row, representing airline name.
      airlineCounts.put(airline, airlineCounts.getOrDefault(airline, 0) + 1);                  // increments count of airline in airlineCounts HashMap, if airline not present, it initializes count to 1. 
    }
  }
  
  // Method assigns color to each airline
  void assignColors(){
    int[] colors = {color(120, 82, 248), color(56, 2, 240), color(40, 2, 176)};                // initializes an array colors.
    int index =  0;
    for (String airline : airlineCounts.keySet()) {                                            // starts a for loop iterating over each airline name in airlineCounts HashMap.
      airlineColors.put(airline, colors[index % colors.length]);                               // assigns a color from colors array to each airline in the airlineColors HashMap.
      index++;
    }
  }
  
  // method to draw pie chart
  void draw(float xpos, float ypos, float diameter){
    float lastAngle = 0;                                                                       // intializes variable to keep track of starting angle for each slice of pie chart.
    int totalFlights = mKTCarrierTable.getRowCount();                                          // calculates total no. of flights by getting no. of rows in table.
    
    for (String airline : airlineCounts.keySet()) {                                            // iterates through each airline in the airlineCounts HashMap.
      float angle = radians(map(airlineCounts.get(airline), 0, totalFlights, 0, 360));         // calculates angle for current airline slice based on count of flights for that airline, it maps count to an angle between 0 and 360 degrees.
      fill(airlineColors.get(airline));                                                        // fill color for current airline slice using color assigned to that airline in airlineColors HashMap.
      arc(xpos, ypos, diameter, diameter, lastAngle, lastAngle + angle);                       // draws arc representing current airline slice starting from lastAngle and extending to lastAngle + angle, arc is drawn at position (xpos, ypos) with width and height of diameter.
      lastAngle += angle;                                                                      // updates lastAngle to prepare for the next airline slice, it adds current angle to lastAngle.
      
      // Calculate position for the label
      float labelAngle = lastAngle - angle / 2;
      float labelX = xpos + (diameter/2 + 20) * cos(labelAngle);
      float labelY = ypos + (diameter/2 + 20) * sin(labelAngle);
        
      // Draw labels
      fill(0);                                                                                 // Set label color to black
      text(airline, labelX, labelY);
    }
    
    // prints title of pie chart on screen
    PFont pieChartLabel = loadFont("Phosphate-Solid-28.vlw");
    textFont(pieChartLabel, 40);
    fill(0);
    text("No. of Flights from Each Airline", 380, 880);
    
    // prints key for pie chart on screen.
    PFont pieChartKey = loadFont("Phosphate-Solid-28.vlw");
    textFont(pieChartKey, 28);
    fill(0);
    text("AA = American  \nAS = Alaska  \nB6 = JetBlue \nDL = Delta \nF9 = Frontier \nG4 = Allegiant \nHA = Hawaiian \nNK = Spirit \nUA = United \nWN = Southwest", 120, 400);
  } 
}
