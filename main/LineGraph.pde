// Niamh Murphy 20-21/03/24
class LineGraph {
    HashMap<String, Integer> airlineCounts;

    LineGraph(HashMap<String, Integer> airlineCounts) {
        this.airlineCounts = airlineCounts;
    }

    void draw(float x, float y, float w, float h) {
        drawAxes(x, y, w, h);
        drawLines(x, y, w, h);
        drawLabels(x, y, w, h);
    }

    void drawAxes(float x, float y, float w, float h) {
        stroke(0);
        line(x, y + h, x + w, y + h); 
        line(x, y, x, y + h); 
    }

    void drawLines(float x, float y, float w, float h) {
        float maxValue = getMaxValue();
        
        stroke(255, 0, 0);
        strokeWeight(2);
        noFill();
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
        float labelStep = maxValue / 5; 
       
        for (int i = 0; i <= maxValue; i += labelStep) {
        float labelX = x - 10; 
        float labelY = y + h - map(i, 0, maxValue, 0, h);
        text(i, labelX, labelY);
         }
    
       int i = 0;
       for (String airline : airlineCounts.keySet()) {
          float labelX = x + i * (w / airlineCounts.size()) + (w / (2 * airlineCounts.size())); ;
          float labelY = y + h + 20;
          text(airline, labelX, labelY);
          i++;
       }

       for (int i2 = 0; i2 < airlineCounts.size(); i2++) {
          float tickX = x + i2 * (w / airlineCounts.size()) + (w / (2 * airlineCounts.size()));;
          float tickY = y + h + 5;
          line(tickX, y + h, tickX, tickY);
       }

    }

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
