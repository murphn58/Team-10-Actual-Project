// Pie Chart for Airlines - SADHBH 18/3/24
// Pie Chart for chosen user inputs - SADHBH 28/3/24
// Pie Chart that takes into accountmissing information - SADHBH 2/4/24
// Pie Chart that displays percentages and makes labels clearer. - SADHBH 3/4/24
 
import java.util.HashMap;                                                                    // a collection class in Java that stores items in key/value pairs.

class PieChart { 
  Query query;
  HashMap<String, Integer> dataCounts;                                                       // declares HashMap to store names (keys), and corresponding counts (values) as integers.
  HashMap<String, Integer> pieChartColors;                                                   // declares HashMap to store names (keys), and corresponding colors as integers. 
  
  PieChart(Query query) {   
    this.query = query;
    dataCounts = new HashMap<>();                                                            // initializes 'dataCounts' HashMap. 
    pieChartColors = new HashMap<>();                                                        // initializes 'pieChartColors' HashMap.
    countData();                                                                             // calls countData() method.
    assignColors();                                                                          // calls assignColors() method.
  }
  
  
  // Method to count occurrences of each data type in table provided. - SADHBH 18/3/24
  void countData(){
    Table table = query.getTable();
    for(TableRow row : table.rows()) {                                                       // iterates through each row of table.
      String rowData = row.getString(1);                                                     // retrieves String of current row, representing data.
      dataCounts.put(rowData, dataCounts.getOrDefault(rowData, 0) + 1);                      // increments count of data in dataCounts HashMap, if data not present, it initializes count to 1. 
    }
  }
  
  
  // Method assigns color to each airline. - SADHBH 18/3/24
  void assignColors(){
    int[] colors = {color(88, 138, 244), color(250, 148, 148), color(250, 48, 48)};           // initializes an array colors.
    int index =  0;
    for (String rowData : dataCounts.keySet()) {                                              // starts a for loop iterating over each data type in dataCounts HashMap.
      pieChartColors.put(rowData, colors[index % colors.length]);                             // assigns a color from colors array to each data segement in the pieChartColors HashMap.
      index++;
    }
  }
  
  
  // Method to draw pie chart. - SADHBH 18/3/24
  void draw(float xpos, float ypos, float diameter){
    float lastAngle = 0;                                                                      // intializes variable to keep track of starting angle for each slice of pie chart.
    int totalRows = table.getRowCount();                                                      // calculates total no. of rows in table.
    
    // Calculate number of possible segments. - SADHBH 2/4/24
    int sumCounts = 0;                                                                        // variable to store the sum of all data counts.
    for (int count : dataCounts.values()) {
      sumCounts += count;                                                                     // calculate the sum of all data counts.
    }
    
    for (String rowData : dataCounts.keySet()) {                                              // iterates through each data type in the dataCounts HashMap.
      float angle = radians(map(dataCounts.get(rowData), 0, totalRows, 0, 360));              // calculates angle for current slice based on count of data for that data type, maps count to an angle between 0 and 360 degrees.
      fill(pieChartColors.get(rowData));                                                      // fill color for current data slice using color assigned to that data type in pieChartColors HashMap.
      arc(xpos, ypos, diameter, diameter, lastAngle, lastAngle + angle);                      // draws arc representing current data slice starting from lastAngle and extending to lastAngle + angle, arc is drawn at position (xpos, ypos) with width and height of diameter.
      lastAngle += angle;                                                                     // updates lastAngle to prepare for the next data slice, it adds current angle to lastAngle.
      
      // Calculate position for the label. - SADHBH 18/3/24
      float labelAngle = lastAngle - angle / 2;
      float labelX = xpos-10 + (diameter/2 + 20) * cos(labelAngle);
      float labelY = ypos-10 + (diameter/2 + 20) * sin(labelAngle);
        
      // Draw white box background for the label. - SADHBH 3/4/24
      fill(255);  
      float labelWidth = textWidth(rowData) + 40;                                             // width of the label text plus padding.
      float labelHeight = 38;                                                                 // height of the label box.
      rect(labelX-10, labelY-20, labelWidth, labelHeight);
        
      // Draw labels of segments. - SADHBH 18/3/24
      fill(0);                                                                                // set label color to black.
      textSize(18);    
      text(rowData, labelX, labelY);
      
      // Calculate percentage. - SADHBH 3/4/24
      float segmentPercentage = (float)dataCounts.get(rowData) / totalRows * 100;
      String percentageLabel = nf(segmentPercentage, 0, 1) + "%";                             // format percentage text.
      
      // Calculate position for the percentage text (underneath labels). - SADHBH 3/4/24
      float percentageX = labelX;                                                             // same X position as the label.
      float percentageY = labelY + 15;                                                        // move the percentage text below the label.
      
      // Draw percentage text underneath the label. - SADHBH 3/4/24
      textSize(18);
      text(percentageLabel, percentageX, percentageY);
    }
    
    // Shade the remaining portion with grey when not all segments in user query. - SADHBH 2/4/24
    if (sumCounts < totalRows) {
      fill(200);  
      float remainingAngle = radians(map(totalRows - sumCounts, 0, totalRows, 0, 360));
      arc(xpos, ypos, diameter, diameter, lastAngle, lastAngle + remainingAngle);
    }
    
    // Prints title of pie chart on screen. - SADHBH 18/3/24
    PFont pieChartLabel = loadFont("Phosphate-Solid-28.vlw");
    textFont(pieChartLabel, 28);
    fill(0);
    text("Amount of Flights per Airline fulfilling chosen parameters", 320, 90);
  } 
} 
