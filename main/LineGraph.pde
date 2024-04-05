/** 
* Written by Niamh Murphy
* Class creates a Line Graph visualisation of the airline data.
* Written by NM to create one specific graph, 20/03/24 16:00 -> 21/03/24 11:00
* Amended by NM to create graphs dynamically, 27/03/24 21:00
* Amended by NM to fix bug where the user could not choose to view 
* the line graph before viewing the pie chart, 28/03/24 19:00
* Other minor edits/improvements made throughout process, by Niamh
*/
class LineGraph { 
   
    HashMap<String, Integer> dataCount;                                            // HashMap to store the count of occurrences of each data point for this class
    Query query;                                                                   // The Query object used to retrieve data
    
    /** Method to construct a LineGraph object
    * @param query passing in the current query specifications from user 
    */
    LineGraph(Query query) {                                                       
      this.query = query;
      dataCount = new HashMap<>();                                                 // Initializes 'dataCount' HashMap 
      countData();                                                                 // Calls dataCount() method which counts occurrences of each data point
    }
    
     /** Method to count occurrences of each airline in data provided
     */
    void countData(){
      Table table = query.getTable();                                                // Get the table from the Query object
      for(TableRow row : table.rows())                                               // Iterates through each row of table until it reaches the end
      {                                                                            
        String destination = row.getString(9);                                           // Retrieves String of current row (destination name); could be changed so pie chart represents different data?
        dataCount.put(destination, dataCount.getOrDefault(destination, 0) + 1);          // Increments count of data points in 'dataCount' HashMap 
      }
     }

/** This method draws the line graph, by calling the draw methods I've created 
* @param x  the x-coordinate of the top-left corner of the graph
* @param y  the y-coordinate of the top-left corner of the graph
* @param w  the width of the graph
* @param h  the height of the graph
*/
    void draw(float x, float y, float w, float h) {
        drawAxes(x, y, w, h);                                                     // Draws the x and y axes, using my drawAxes(...) method
        drawLines(x, y, w, h);                                                    // Draws lines and dots representing data points, using my drawLines(..) method
        drawLabels(x, y, w, h);                                                   // Draws labels and dashes, using my drawLabels(...) method
        textFont(myFont);
        text("Amount of Flights to Each Destination Available;" 
                + " Fulfilling User-Specified Parameters", 110, 90);              // Draws title above graph
    }
    
/** This method specifies how the axes of the graph should be drawn
* @param x  the x-coordinate of the top-left corner of the graph
* @param y  the y-coordinate of the top-left corner of the graph
* @param w  the width of the graph
* @param h  the height of the graph
*/
    void drawAxes(float x, float y, float w, float h) {
        stroke(0);                                                                // Specifies black lines                 
        line(x, y + h, x + w, y + h);                                             // Specifies x-axis
        line(x, y, x, y + h);                                                     // Specifies y-axis
    }
    
/** This method specifies how the dots and the line, connecting
*   the dots, on the line graph should be drawn
* @param x  the x-coordinate of the top-left corner of the graph
* @param y  the y-coordinate of the top-left corner of the graph
* @param w  the width of the graph
* @param h  the height of the graph
*/
    void drawLines(float x, float y, float w, float h) {
        float maxValue = getMaxValue();                                           
        
        stroke(255, 0, 0);                                                        // Colours line
        //strokeWeight(2);                                                        // Sets line width, had to be removed as was affecting other line and text widths
        noFill();                                                                 // Removes filling in under line

        beginShape();                                                             // Begins defining the shape of the data on the graph
        int i = 0;                                                                // Initialize a counter variable for iterating through data
        // Iterate through each destination in the dataCount map
        for (String destination : dataCount.keySet())                             
        {
            float xValue = x + i * (w / dataCount.size()) + (w / (2 * dataCount.size()));  // Calculates the x-coordinate for the current destination's data point
            float yValue = y + h - map(dataCount.get(destination), 0, maxValue, 0, h);     // Calculates the y-coordinate for the current destination's data poin
            fill(255, 0, 0);                                                               // Fills dots in red
            ellipse(xValue, yValue, 5, 5);                                                 // Draws a small  circle, representing the data point, at the calculated co-ordinates
            noFill();                                                                      // Turns off filling for the subsequent shape
            vertex(xValue, yValue);                                                        // Adds the line at the current data point's co-ordinates 
            i++;                                                                           // Increments the counter for the next iteration
        }
        endShape();                                                                        // Ends the defining of the shape
    }
    
/** This method draws the labels and dashes line graph 
* @param x  the x-coordinate of the top-left corner of the graph
* @param y  the y-coordinate of the top-left corner of the graph
* @param w  the width of the graph
* @param h  the height of the graph
*/
    void drawLabels(float x, float y, float w, float h) {
        fill(0);                                                                  // Sets colour to black
        
        float maxValue = getMaxValue();                                           // Gets the maximum value from the data set                   
        float labelStep = maxValue/5;                                             // Calculates the gap size for the labels on the y-axis
        // Draws labels for y-axis
        for (int i = 0; i <= maxValue; i += labelStep)                            
        {
          float labelX = x - 20;                                                  // X-co-ordinate for the labels, positioned to the left of the y-axis
          float labelY = y + h - map(i, 0, maxValue, 0, h);                       // Y-coordinate for the labels, mapped to the data range
          labelsFont = loadFont("Phosphate-Solid-15.vlw");                        // Loads smaller font for the labels
          textFont(labelsFont);                                                   // Sets the text font
          text(i, labelX, labelY);                                                // Draws the labels at the calculated coordinates
          
           // Draw dashes on y-axis
           float dashX = x;                                                        // X-coordinate for dashes, on the y-axis
           float dashY = labelY;                                                   // Y-coordinate for dashes, same as label
           line(dashX, dashY, dashX + 5, dashY);                                   // Draws a horizontal dash
         }
    
       int i = 0;
       // Draws labels for x-axis 
       for (String destination : dataCount.keySet()) 
       {
          float labelX = x + i * (w / dataCount.size()) + (w / (2 * dataCount.size())); ;  // Calculate x-coordinate for the label
          float labelY = y + h + 20;                                                       // Sets y-coordinate for the labels, below the x-axis
          text(destination, labelX, labelY);                                               // Draws the labels at the calculated coordinates
          i++;                                                                             // Increments the counter for the next iteration
       }
       // Draws ticks on x-axis
       for (int i2 = 0; i2 < dataCount.size(); i2++)  
       {
          float dashX = x + i2 * (w / dataCount.size()) + (w / (2 * dataCount.size()));;   // Calculates x-coordinates for the dashes
          float dashY = y + h + 5;                                                         // Sets y-coordinates for the dashes, at the x-axis
          line(dashX, y + h, dashX, dashY);                                                // Draws a vertical line at each label on x-axis
       }

    }
    
/** Method gets the maximum value of the data in the dataCount HashMap being used in the line graph
*/
    float getMaxValue() {
        int maxValue = 0;                                                         // Initialises the maximum value as 0
        // Iterates through the values in the dataCount map
        for (int value : dataCount.values())                                      
        {
            if (value > maxValue)                                                 // Check if the current value is greater than the current maximum value
            {
                maxValue = value;                                                 // If it is, update the maximum value
            }
        }
        return maxValue;                                                          // Result shoudld be the maximum value found in the dataCount map
    }
}
