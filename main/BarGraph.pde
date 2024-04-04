<<<<<<< Updated upstream
=======

// Bar Chart Class - AOIFE 18/3/24
>>>>>>> Stashed changes
class BarGraph {

  HashMap<String, Integer> airlineCounts;                                       // HashMap to store the count of occurrences of each airline
  Query query;                                                                  // The Query object used to retrieve data

  // Constructs a LineGraph object
  BarGraph(Query query) {
    this.query = query;
    airlineCounts = new HashMap<>();                                            // Initializes 'airlineCounts' HashMap.
    countAirlines();                                                            // Calls countAirlines() method which counts occurrences of each airlue
  }

  void countAirlines() {
    Table table = query.getTable();                                                // Get the table from the Query object
    for (TableRow row : table.rows())
    {                                                                              // Iterates through each row of table.
      String airline = row.getString(1);                                           // Retrieves String of current row, representing airline name
      airlineCounts.put(airline, airlineCounts.getOrDefault(airline, 0) + 1);      // Uncrements count of airline in airlineCounts HashMap
    }
  }

<<<<<<< Updated upstream
  // Draws the bar graph
  void draw(float x, float y, float w, float h) {
    
    drawBars(x, y, w, h); // Draw bars representing data points
    drawAxes(x, y, w, h); // Draw axes
    drawLabels(x, y, w, h); // Draw labels and ticks
    text("Amount of Flights per Airline fulfilling chosen parameters", 450, 20); // Draw title
=======
  void draw(float xPos, float yPos, float width, float height) {
    drawAxes(xPos, yPos, width, height);                                                     // Draws the axes
    drawBars(xPos, yPos, width, height);                                                    // Draws lines representing data points
    drawLabels(xPos, yPos, width, height);                                                   // Draws labels and ticks
    textSize(28);
    text("Amount of Flights per Airline fulfilling chosen parameters", 320, 90);           // Draws title
>>>>>>> Stashed changes
  }

  void drawAxes(float xPos, float yPos, float width, float height) {
    stroke(0);
    line(xPos, yPos + height, xPos + width, yPos + height);                                             // X-axis
    line(xPos, yPos, xPos, yPos + height);                                                              // Y-axis
  }

  void drawBars(float xPos, float yPos, float width, float height) {
    float maxValue = getMaxValue();
    stroke(255, 0, 0);                                                                   // Set color for bars

    float barWidth = width / airlineCounts.size();                                     // Calculate the width of each bar
    int i = 0;
    for (String airline : airlineCounts.keySet())
    {
<<<<<<< Updated upstream
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
=======
      float barHeight = map(airlineCounts.get(airline), 0, maxValue, 0, height);           // Map the count to the height of the graph
      float barX = xPos + i * barWidth + (barWidth / 2);                                   // Calculate the x position of the bar
      float barY = yPos + height - barHeight;                                              // Calculate the y position of the bar
      noStroke(); // Remove outline
      fill(0, 0, 255);
      rect(barX, barY, barWidth * 0.8, barHeight);                                         // Draw the bar
      i++;
    }
  }

  void drawLabels(float xPos, float yPos, float width, float height) {
    fill(0);
>>>>>>> Stashed changes

    float maxValue = getMaxValue();
    float labelStep = maxValue / 5;

    // Draw labels for y-axis
    for (int i = 0; i <= maxValue; i += labelStep) 
    {
      float labelX = xPos - 10;
      float labelY = yPos + height - map(i, 0, maxValue, 0, height);
      textSize(28);
      text(i, labelX, labelY);
    }

    int i = 0;
    // Draw labels and ticks on x-axis
    for (String airline : airlineCounts.keySet()) 
    {
      float labelX = xPos + (i + 0.5) * (width / airlineCounts.size());          // Adjusted x position for labels
      float labelY = yPos + height + 20;
      textSize(14);
      text(airline, labelX, labelY);                                             // Draw airline name
      float tickX = xPos + (i + 0.5) * (width / airlineCounts.size());           // Adjusted x position for ticks
      float tickY = yPos + height + 5;
      line(tickX, yPos + height, tickX, tickY);                                  // Draw ticks
      i++;
    }
  }

  // Gets the maximum value of airline counts.
  float getMaxValue() {
    int maxValue = 0;
    for (int value : airlineCounts.values())
    {
      if (value > maxValue) {
        maxValue = value;
      }
    }
    return maxValue;
  }
}
