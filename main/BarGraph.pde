
//  Aoife
// Bar Chart Class - AOIFE 18/3/24


class BarGraph {
  
  HashMap<String, Integer> airlineCounts; // HashMap to store the count of occurrences of each airline
  Query query; // The Query object used to retrieve data


  // Constructs a BarGraph object
  BarGraph(Query query) {
    this.query = query;
    airlineCounts = new HashMap<>(); // Initializes 'airlineCounts' HashMap.
    countAirlines(); // Calls countAirlines() method which counts occurrences of each airline
  }


  // Method to count occurrences of each airline in data provided
  void countAirlines() {
    
  void countAirlines() {    
    Table table = query.getTable(); // Get the table from the Query object
    
    for (TableRow row : table.rows()) 
    { // Iterates through each row of table.
      String airline = row.getString(1); // Retrieves String of current row, representing airline name
      airlineCounts.put(airline, airlineCounts.getOrDefault(airline, 0) + 1); // Increments count of airline in airlineCounts HashMap
    }
  }


  // Draws the bar graph
  void draw(float x, float y, float w, float h) {
    
    drawBars(x, y, w, h); // Draw bars representing data points
    drawAxes(x, y, w, h); // Draw axes
    drawLabels(x, y, w, h); // Draw labels and ticks
    
    textSize(28);
    text("Amount of Flights per Airline fulfilling chosen parameters", 320, 90); // Draw title
  }


  // method to draw bars
  void drawBars(float x, float y, float w, float h) {
    
    float maxValue = getMaxValue(); // Get the maximum value of airline counts
    float barWidth = (w / airlineCounts.size())/2; // Calculate the width of each bar
    float xPos = x; // Initial x position for the first bar

    for (String airline : airlineCounts.keySet()) 
    {
      float barHeight = map(airlineCounts.get(airline), 0, maxValue, 0, h); // Calculate the height of the current bar
      fill(52, 114, 244); // Set colour for bars
      rect(xPos, y + h - barHeight, barWidth, barHeight); // Draw the current bar
      xPos += barWidth; // Move to the next x position for the next bar
    }
  }


  // method to draw axes
  void drawAxes(float x, float y, float w, float h) {
    
    //stroke(0); // Set stroke color for axes
    line(x, y + h, x + (w/2), y + h); // Draw X-axis
    line(x, y, x, y + h); // Draw Y-axis
  }


  // method to draw labels and ticks
  void drawLabels(float x, float y, float w, float h) {
    
    fill(0); // Set fill color for labels and ticks
    float maxValue = getMaxValue(); // Get the maximum value of airline counts
    float labelStep = maxValue / 5; // Calculate step for labeling
    
    // Draw labels for Y-axis
    for (int i = 0; i <= maxValue; i += labelStep) 
    {
      float labelX = x - 50; 
      float labelY = y + h - map(i, 0, maxValue, 0, h);
      
      labelsFont = loadFont("Phosphate-Solid-15.vlw");                        // Loads smaller font for the labels
      textFont(labelsFont);                                                   // Sets the text font
      textFont(labelsFont);                                                   // Sets the text font                                              // Sets the text font
      text(i, labelX, labelY);
      
       float dashX = x-5;                                                       
       float dashY = labelY;                                                  
       line(dashX, dashY, dashX + 5, dashY);                                  
      float dashX = x-5;                                                       
      float dashY = labelY;                                                  
      line(dashX, dashY, dashX + 5, dashY);                                  
    }
    
    // Fixing fonts - SADHBH 5/4/24
     textFont(myFont);                                                          // Sets font for axes labels
     textSize(23);                                                              // Aligns text to the right
     pushMatrix();                                                              // Save the current transformation matrix
     translate(335, 500);                                                       // Translate to the label position
     rotate(-HALF_PI);                                                          // Rotate the text by -90 degrees
     text("Number of Flights", 0, 0);                                           // Label content specification
     popMatrix();                                                               // Restores the previous transformation matrix state after applying transformations
     textFont(labelsFont);                                                      // Switches back to font for x and y value labels

    // Draw labels for X-axis
    int i = 0;
    for (String airline : airlineCounts.keySet()) 
    {
      float labelX = (x + i * ((w / airlineCounts.size()))/2 + (w / (2 * airlineCounts.size())))-45;
      float labelY = y + h + 20;
      labelsFont = loadFont("Phosphate-Solid-15.vlw");                        // Loads smaller font for the labels
      textFont(labelsFont);                                                   // Sets the text font
      
         labelsFont = loadFont("Phosphate-Solid-15.vlw");                        // Loads smaller font for the labels
      textFont(labelsFont);                                                   // Sets the text font                                                // Sets the text font
      text(airline, labelX, labelY);
      i++;
    }
    
     textFont(myFont);                                                                   // Sets font for axes labels
     textSize(23);                                                                       // Sets size for axes labels
     text("Flight Destination States Abbreviated", 420, 745);                            // Label content and size specification
     textFont(labelsFont);                                                               // Switches back to font for x and y value labels

    
    // Draw ticks on X-axis
    for (int i2 = 0; i2 < airlineCounts.size(); i2++) 
    {
      float tickX = x + i2 * ((w / airlineCounts.size()))/2 + (w / (2 * airlineCounts.size()));
      float tickY = y + h + 5;
      line(tickX, y + h, tickX, tickY);
    }
  }

  
  
  // Gets the maximum value of airline counts
  float getMaxValue() {
    int maxValue = 0;
    for (int value : airlineCounts.values()) 
    {
      if (value > maxValue) 
      {
        maxValue = value;
      }
    }
    return maxValue;
  }
}
