/* Yue Pan, Basic textbox with columns,9pm 16/03/2024

use monospaced fonts since in Parse formatData() relies on spaces and assumes letters are all equal width to left align each column

*/
final int MAXIMUM_LINES = 30;

class Gui{
  int currentPage = 0;
  int index = 0;
  
  public Gui(){
  }
  
  /** 
   * creates a Control5P text box
   * 
   * @param name of window
   * @param x position
   * @param y position
   * @param width
   * @param height
   * @param table object to display
   *
   * 
   */
  void textBox(String windowName, int xpos, int ypos, int xSize, int ySize, Table table)
  {
      String displayData = "";
      
      myTextarea = cp5.addTextarea(windowName)
                  .setPosition(xpos, ypos + 16)
                  .setSize(xSize, ySize - 16)
                  .setFont(createFont("Courier New",12))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(color(255,100))
                  .setColorForeground(color(255,100))
                  ;
                  
         if(table.getRowCount() < 10000)
         {
          displayData = parser.formatData(table);
          myTextarea.setText(displayData);
         }
         
        if(displayData.equals(""))
        {
          myTextarea.hide();
        }
    
  }
   /** 
   * creates a Control5P textlabel
   * 
   * @param name of window
   * @param x position
   * @param y position
   * @param width
   * @param height
   * @param table object to display
   *
   * 
   */
    void textlabels(String windowName, int xpos, int ypos, int xSize, int ySize, Table table)
  {
  
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
       
       myTextlabel //= cp5.addTextlabel("columns")
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
   * @param x position of centre, 
   * @param y position of centre, 
   * @param radius
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
   /** 
   * returns index of text box
   * 
   * 
   *
   * @return int index
   */
  int returnIndex()
  {
    return index;
  }
  
   /** 
   * returns current page of text box
   * 
   * 
   *
   * @return current page
   */
  int returnCurrentPage()
  {
    return currentPage;
  }
   /** 
   * reset current page to 0
   * 
   * 
   *
   * @return current page
   */
  void resetIndices(){
      this.currentPage = 0;
      this.index = 0;
  }
  
   /** 
   * displays next 30 entries in text box
   * 
   */
  void textboxForward()
  {
          int totalPages = (int) Math.ceil((double)query.getCount()/ MAXIMUM_LINES);
          if(this.currentPage >= totalPages)
          {
             return;
          }else
          {
            currentPage++;  
          }
          
          int startIndex = currentPage * MAXIMUM_LINES;
          int endIndex = startIndex + MAXIMUM_LINES;
          if( gui.returnCurrentPage() >= totalPages)
          {
            endIndex = query.getCount();
          }
          Table temp = table.copy();
          temp.clearRows();
          for(int i = startIndex; i < endIndex ; i++)
          {
            temp.addRow((query.getTable()).getRow(i));
          }
          maximumWidths = parser.getColumnWidths(temp);
          gui.textlabels("results", 50, 160, 1300, 450, temp);
          myTextarea.setText(parser.formatData(temp));
  }
  /** 
   * displays previous 30 entries in text box
   * 
   */
    void textboxBackward()
  {
          int totalPages = (int) Math.ceil((double)query.getCount()/ MAXIMUM_LINES);
          if(this.currentPage <= 0)
          {
             return;
          }else
          {
            currentPage--;  
          }
          
          int startIndex = currentPage * MAXIMUM_LINES;
          int endIndex = startIndex + MAXIMUM_LINES;
          if( gui.returnCurrentPage() >= totalPages)
          {
            endIndex = query.getCount();
          }
          Table temp = table.copy();
          temp.clearRows();
          for(int i = startIndex; i < endIndex ; i++)
          {
            temp.addRow((query.getTable()).getRow(i));
          }
          maximumWidths = parser.getColumnWidths(temp);
          gui.textlabels("results",50, 160, 1300, 450, temp);
          myTextarea.setText(parser.formatData(temp));
  }
}
