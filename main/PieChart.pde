// Pie Chart for Airlines - SADHBH 18/3/24
// Pie Chart for chose user inputs - SADHBH 28/3/24

import java.util.HashMap;                                                                   // a collection class in Java that stores items in key/value pairs.

class PieChart { 
  Query query;
  HashMap<String, Integer> dataCounts;                                                      // declares HashMap to store names (keys), and corresponding counts (values) as integers.
  HashMap<String, Integer> pieChartColors;                                                  // declares HashMap to store names (keys), and corresponding colors as integers. 
  
  PieChart(Query query) {   
    this.query = query;
    dataCounts = new HashMap<>();                                                           // initializes 'dataCounts' HashMap. 
    pieChartColors = new HashMap<>();                                                       // initializes 'pieChartColors' HashMap.
    countData();                                                                            // calls countData() method.
    assignColors();                                                                         // calls assignColors() method.
  }
  
  // Method to count occurrences of each data type in table provided
  void countData(){
    Table table = query.getTable();
    for(TableRow row : table.rows()) {                                                       // iterates through each row of table.
      String rowData = row.getString(1);                                                     // retrieves String of current row, representing data.
      dataCounts.put(rowData, dataCounts.getOrDefault(rowData, 0) + 1);                      // increments count of data in dataCounts HashMap, if data not present, it initializes count to 1. 
    }
  }
  
  // Method assigns color to each airline
  void assignColors(){
    int[] colors = {color(120, 82, 248), color(56, 2, 240), color(40, 2, 176)};               // initializes an array colors.
    int index =  0;
    for (String rowData : dataCounts.keySet()) {                                              // starts a for loop iterating over each data type in dataCounts HashMap.
      pieChartColors.put(rowData, colors[index % colors.length]);                             // assigns a color from colors array to each data segement in the pieChartColors HashMap.
      index++;
    }
  }
  
  // method to draw pie chart
  void draw(float xpos, float ypos, float diameter){
    float lastAngle = 0;                                                                      // intializes variable to keep track of starting angle for each slice of pie chart.
    int totalRows = table.getRowCount();                                                      // calculates total no. of rows in table.
    
    for (String rowData : dataCounts.keySet()) {                                              // iterates through each data type in the dataCounts HashMap.
      float angle = radians(map(dataCounts.get(rowData), 0, totalRows, 0, 360));              // calculates angle for current slice based on count of data for that data type, maps count to an angle between 0 and 360 degrees.
      fill(pieChartColors.get(rowData));                                                      // fill color for current data slice using color assigned to that data type in pieChartColors HashMap.
      arc(xpos, ypos, diameter, diameter, lastAngle, lastAngle + angle);                      // draws arc representing current data slice starting from lastAngle and extending to lastAngle + angle, arc is drawn at position (xpos, ypos) with width and height of diameter.
      lastAngle += angle;                                                                     // updates lastAngle to prepare for the next data slice, it adds current angle to lastAngle.
      
      // Calculate position for the label
      float labelAngle = lastAngle - angle / 2;
      float labelX = xpos + (diameter/2 + 20) * cos(labelAngle);
      float labelY = ypos + (diameter/2 + 20) * sin(labelAngle);
        
      // Draw labels
      fill(0);                                                                                // Set label color to black
      text(rowData, labelX, labelY);
    }
    
    // prints title of pie chart on screen
    PFont pieChartLabel = loadFont("Phosphate-Solid-28.vlw");
    textFont(pieChartLabel, 40);
    fill(0);
    text("Amount of Flights per Airline fulfilling chosen parameters", 140, 40);
  } 
}
