// Niamh Murphy 20-21/03/24
// Represents a Line Graph visualization of airline data.
class LineGraph { 
  
    HashMap<String, Integer> airlineCounts;                                       // HashMap to store the count of occurrences of each airline
    Query query;                                                                  // The Query object used to retrieve data

// Constructs a LineGraph object
    LineGraph(Query query) {
      this.query = query;
      airlineCounts = new HashMap<>();                                            // Initializes 'airlineCounts' HashMap. 
      countAirlines();                                                            // Calls countAirlines() method which counts occurrences of each airlue

    }
    
     // Method to count occurrences of each airline in data provided
  void countAirlines(){
    Table table = query.getTable();                                                // Get the table from the Query object
    for(TableRow row : table.rows()) {                                             // Iterates through each row of table.
      String airline = row.getString(1);                                           // Retrieves String of current row, representing airline name
      airlineCounts.put(airline, airlineCounts.getOrDefault(airline, 0) + 1);      // Uncrements count of airline in airlineCounts HashMap 
    }
  }

// Draws the line graph
// x = The x-coordinate of the top-left corner of the graph
// y = The y-coordinate of the top-left corner of the graph
// w = The width of the graph
// h = The height of the graph
    void draw(float x, float y, float w, float h) {
        drawAxes(x, y, w, h);                                                     // Draws the axes
        drawLines(x, y, w, h);                                                    // Draws lines representing data points
        drawLabels(x, y, w, h);                                                   // Draws labels and ticks
<<<<<<< Updated upstream
        text("Amount of Flights per Airline fulfilling chosen parameters", 450, 20); // Draws title
=======
        textSize(28);
        text("Amount of Flights per Airline fulfilling chosen parameters", 320, 90); // Draws title
>>>>>>> Stashed changes
    }

    void drawAxes(float x, float y, float w, float h) {
        stroke(0);                                                                
        line(x, y + h, x + w, y + h);                                             // X-axis
        line(x, y, x, y + h);                                                     // Y-axis
    }

    void drawLines(float x, float y, float w, float h) {
        float maxValue = getMaxValue();                                           
        
        stroke(255, 0, 0);                                                        // Colours line
        //strokeWeight(2);                                                          // Sets line width
        noFill();                                                                 // Removes filling in under line

        beginShape();
        int i = 0;
        for (String airline : airlineCounts.keySet()) {
            float xValue = x + i * (w / airlineCounts.size()) + (w / (2 * airlineCounts.size())); 
            float yValue = y + h - map(airlineCounts.get(airline), 0, maxValue, 0, h);
            fill(255, 0, 0);
            ellipse(xValue, yValue, 8, 8);
            noFill();
            vertex(xValue, yValue);
            i++;
        }
        endShape();
    }

    void drawLabels(float x, float y, float w, float h) {
        fill(0);
        
        float maxValue = getMaxValue();                                        
        float labelStep = maxValue / 5;                                        // Calculate step for labelling
        // Draw labels for y-axis
        for (int i = 0; i <= maxValue; i += labelStep) {
        float labelX = x - 10; 
        float labelY = y + h - map(i, 0, maxValue, 0, h);
        text(i, labelX, labelY);
         }
    
       int i = 0;
       // Draw labels for x-axis 
       for (String airline : airlineCounts.keySet()) {
          float labelX = x + i * (w / airlineCounts.size()) + (w / (2 * airlineCounts.size())); ;
          float labelY = y + h + 20;
          text(airline, labelX, labelY);
          i++;
       }
       // Draw ticks on x-axis
       for (int i2 = 0; i2 < airlineCounts.size(); i2++) {
          float tickX = x + i2 * (w / airlineCounts.size()) + (w / (2 * airlineCounts.size()));;
          float tickY = y + h + 5;
          line(tickX, y + h, tickX, tickY);
       }

    }
    
// Gets the maximum value of airline counts.    
    float getMaxValue() {
        int maxValue = 0;
        for (int value : airlineCounts.values()) {
            if (value > maxValue) {
                maxValue = value;
            }
        }
        return maxValue;
    }
}
