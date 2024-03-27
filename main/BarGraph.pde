// by Aoife Mahon
import java.util.Collections;
import java.util.HashMap;

class BarGraph {
  
  Table dataTable; 

  int x, y, barWidth, graphHeight;
  final int SPACE_BETWEEN_BARS = 100;

  BarGraph(Table dataTable, int x, int y, int barWidth, int graphHeight) {
    this.dataTable = dataTable;
    this.x = x;
    this.y = y;
    this.barWidth = barWidth;
    this.graphHeight = graphHeight;
  }

  void draw() {
    // Extracting data for plotting the graph
    ArrayList<String> dates = new ArrayList<String>();
    ArrayList<Integer> flightCounts = new ArrayList<Integer>();

    for (TableRow row : dataTable.rows()) 
    {
      String date = row.getString(0); // Assume date is in the first column
      dates.add(date);

      int flightCount = row.getInt(1); // Assume flight count is in the second column
      flightCounts.add(flightCount);
    }

    PFont barGraphFont = loadFont("Phosphate-Solid-28.vlw");
    textFont(barGraphFont);
    text("Number of Flights for each Date ", 250, 100);

    int maxValue = Collections.max(flightCounts); // Get the maximum flight count

    for (int i = 0; i < dates.size(); i++) 
    {
      String date = dates.get(i);
      int flightCount = flightCounts.get(i);

      // Calculate bar height based on flight count
      float barHeight = map(flightCount, 0, maxValue, 0, graphHeight); // Use map() to scale the bars
      // Calculate bar position
      float xPos = x + i * (barWidth + SPACE_BETWEEN_BARS); // Adjust the spacing between bars
      float yPos = y - barHeight; // Bars grow upwards
      // Draw the bar
      fill(4, 45, 131);
      rect(xPos, yPos, barWidth, barHeight);
      // Draw the date label
      fill(0);
      textSize(15);
      text(date, xPos, y + 30); // Adjust position as needed
      text(flightCount, xPos, 190);
    }
  }
}
