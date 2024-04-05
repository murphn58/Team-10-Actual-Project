/* Yue Pan, Basic textbox with columns,9pm 16/03/2024

use monospaced fonts since in Parse formatData() relies on spaces and assumes letters are all equal width to left align each column

*/

class Gui{
  
  public Gui(){
  }
  
  /** 
   * creates a Control5P text box
   * 
   * @param name of window, x position, y position, width, height, table object to display
   *
   * 
   */
  void textBox(String windowName, int xpos, int ypos, int xSize, int ySize, Table table)
  {
      String displayData = parser.formatData(table);
      myTextarea = cp5.addTextarea(windowName)
                  .setPosition(xpos, ypos + 16)
                  .setSize(xSize, ySize - 16)
                  .setFont(createFont("Courier New",12))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(color(255,100))
                  .setColorForeground(color(255,100))
                  .setText(displayData)
                  ;
                  
        if(displayData.equals(""))
        {
          myTextarea.hide();
        }
      
       StringBuilder output = new StringBuilder();
       for(int i = 0; i < table.getColumnCount(); i++)
       {
         if((table.getColumnTitle(i)).length() <= maximumWidths[i]){
           output.append(table.getColumnTitle(i));
           for(int j = (table.getColumnTitle(i)).length(); j < maximumWidths[i]; j++)
           {
           output.append(" ");
           }
         }else{
           String concatedString = (table.getColumnTitle(i)).substring(0, maximumWidths[i]-3);
           output.append(concatedString);
           output.append("   ");    
         }
         
         output.append(" ");
       }
       
       myTextlabel = cp5.addTextlabel("columns")
                  .setPosition(xpos,ypos)
                  .setFont(createFont("Courier New",12))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(color(255,0))
                  .setColorForeground(color(255,100))
                  .setText(output.toString())
                  ;
                     
      
    
  }
  
  
  /** 
   * creates a Control5P pie chart
   * 
   * @param x position of centre, y position of centre, radius
   *
   * 
   */
  void pie(int xpos, int ypos, int size)
  {
    myChart = cp5.addChart("pieChart")
               .setPosition(xpos, ypos)
               .setSize(size, size)
               .setView(Chart.PIE); // Set view mode to PIE            
  }
 
 /** 
   * append data to the pie chart via a Hash map
   * 
   * @param hashmap 
   *
   * 
   */
  void pieAppendData(HashMap<String, Integer> input)
  {
    int totalFlights = query.getCount();
    int normalFlights = totalFlights - input.getOrDefault("CANCELLED", 0) - input.getOrDefault("DIVERTED", 0);
    
    ChartData normal = new ChartData(normalFlights, "normal");
    ChartData cancelledFlights = new ChartData(input.getOrDefault("CANCELLED", 0), "cancelled");
    ChartData divrtedFlights = new ChartData(input.getOrDefault("DIVERTED", 0), "diverted");
  
    myChart.addDataSet("data");
    myChart.addData("data",normal);
    myChart.addData("data",cancelledFlights);
    myChart.addData("data",divrtedFlights);
  
    myChart.setColors("data",color(25,75,79), color(221,68,68), color(255,220,220));
  
  }
}
