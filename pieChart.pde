// experimenting with displaying data with pie charts 
// sourses used: https://processing.org/examples/piechart.html

int[] angles = { 30, 10, 45, 35, 60, 38, 75, 67 };
color[] sliceColors = { 
  #8CDDFC, // blue
  #9BFC8C, // green
  #D78CFC, // purple
  #FC8CE4, // pink
  #FCB78C, // orange
  #FCF18C, // yellow
  #FCA38C, // red 
  #8C96FC  // dark blue 
};

void setup() {
  size(640, 360);
  background(255);
  noStroke();
  noLoop(); 
  
  PieChart pieChart = new PieChart(300, angles);
  pieChart.draw();
}

class PieChart {
  float diameter;
  int[] data;
  
  PieChart(float diameter, int[] data) {
    this.diameter = diameter;
    this.data = data;
  }
  
  void draw() {
    float lastAngle = 0;
    for (int i = 0; i < data.length; i++) {
      fill(sliceColors[i % sliceColors.length]);
      arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
      lastAngle += radians(data[i]);
    }
  }
}
