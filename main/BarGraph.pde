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
    text("Amount of Flights per Airline fulfilling chosen parameters", 450, 20); // Draw title
  }

  // method to draw bars
  void drawBars(float x, float y, float w, float h) {
    
    float maxValue = getMaxValue(); // Get the maximum value of airline counts
    float barWidth = w / airlineCounts.size(); // Calculate the width of each bar
    float xPos = x; // Initial x position for the first bar

    for (String airline : airlineCounts.keySet()) 
    {
      float barHeight = map(airlineCounts.get(airline), 0, maxValue, 0, h); // Calculate the height of the current bar
      fill(41, 64, 203); // Set colour for bars
      rect(xPos, y + h - barHeight, barWidth, barHeight); // Draw the current bar
      xPos += barWidth; // Move to the next x position for the next bar
    }
  }

  // method to draw axes
  void drawAxes(float x, float y, float w, float h) {
    
    stroke(0); // Set stroke color for axes
    line(x, y + h, x + w, y + h); // Draw X-axis
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
      float labelX = x - 10; 
      float labelY = y + h - map(i, 0, maxValue, 0, h);
      text(i, labelX, labelY);
    }

    // Draw labels for X-axis
    int i = 0;
    for (String airline : airlineCounts.keySet()) 
    {
      float labelX = x + i * (w / airlineCounts.size()) + (w / (2 * airlineCounts.size()));
      float labelY = y + h + 20;
      text(airline, labelX, labelY);
      i++;
    }

    // Draw ticks on X-axis
    for (int i2 = 0; i2 < airlineCounts.size(); i2++) 
    {
      float tickX = x + i2 * (w / airlineCounts.size()) + (w / (2 * airlineCounts.size()));
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
