// Pie Chart for Airlines - SADHBH

import java.util.HashMap;

class PieChart {
  HashMap<String, Integer> airlineCounts;                                                      // declares HashMap to store airline names (keys), and corresponding counts (values) as integers. 
  HashMap<String, Integer> airlineColors;                                                      // declares HashMap to store airline names (keys), and corresponding colors as integers. 
  
  PieChart(Table mKTCarrierTable) {                                                           
    airlineCounts = new HashMap<>();                                                           // initializes 'airlineCounts' HashMap. 
    airlineColors = new HashMap<>();                                                           // initializes 'airlineColors' HashMap.
    countAirlines(mKTCarrierTable);                                                            
    assignColors();                                                                            
  }
  
  // Method to count occurrences of each airline in table provided
  void countAirlines(Table mKTCarrierTable){
    for(TableRow row : mKTCarrierTable.rows()) {                                               // iterates through each row of table
      String airline = row.getString("MKT Carrier");
      airlineCounts.put(airline, airlineCounts.getOrDefault(airline, 0) + 1);
    }
  }
  
  // Method assigns color to each airline
  void assignColors(){
    int[] colors = {color(120, 82, 248), color(56, 2, 240), color(40, 2, 176)}; 
    int index =  0;
    for (String airline : airlineCounts.keySet()) {
      airlineColors.put(airline, colors[index % colors.length]);
      index++;
    }
  }
  
  void draw(float xpos, float ypos, float diameter){
    float lastAngle = 0;
    int totalFlights = mKTCarrierTable.getRowCount();
    
    for (String airline : airlineCounts.keySet()) {
      float angle = radians(map(airlineCounts.get(airline), 0, totalFlights, 0, 360));
      fill(airlineColors.get(airline));
      arc(xpos, ypos, diameter, diameter, lastAngle, lastAngle + angle);
      lastAngle += angle;
      
      // Calculate position for the label
      float labelAngle = lastAngle - angle / 2;
      float labelX = xpos + (diameter/2 + 20) * cos(labelAngle);
      float labelY = ypos + (diameter/2 + 20) * sin(labelAngle);
        
      // Draw labels
      fill(0);                                                                                 // Set label color to black
      text(airline, labelX, labelY);
    }
    
    PFont pieChartLabel = loadFont("Phosphate-Solid-28.vlw");
    textFont(pieChartLabel, 40);
    fill(0);
    text("No. of Flights from Each Airline", 380, 880);
    
    PFont pieChartKey = loadFont("Phosphate-Solid-28.vlw");
    textFont(pieChartKey, 28);
    fill(0);
    text("AA = American  \nAS = Alaska  \nB6 = JetBlue \nDL = Delta \nF9 = Frontier \nG4 = Allegiant \nHA = Hawaiian \nNK = Spirit \nUA = United \nWN = Southwest", 120, 400);
  } 
}
