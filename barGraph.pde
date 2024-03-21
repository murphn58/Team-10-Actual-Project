import java.util.Collections;

class BarGraph {

  ArrayList<String> dates;
  ArrayList<Integer> flightCounts;
  int x, y, barWidth, graphHeight, flightCount;
  final int SPACE_BETWEEN_BARS = 150;

  BarGraph(ArrayList<String> dates, ArrayList<Integer> flightCounts, int x, int y, int barWidth, int graphHeight) {
    this.dates = dates;
    this.flightCounts = flightCounts;
    this.x = x;
    this.y = y;
    this.barWidth = barWidth;
    this.graphHeight = graphHeight;
  }

  void draw() {

    PFont barGraphFont = createFont("Arial-BoldMT-48.vlw", 40, true);
    textFont(barGraphFont);
    text("Number of Flights for each Date ", 250, 100);

    int maxValue = Collections.max(flightCounts); // Get the maximum flight count

    for (int i = 0; i < dates.size(); i++)
    {
      String date = dates.get(i);
      flightCount = flightCounts.get(i);

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
