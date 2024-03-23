/* Yue Pan, Basic textbox with columns,9pm 16/03/2024

columns label implementation really bad, could use some help!
Make sure you use monospaced fonts since in Parse formatData() relies on spaces and assumes letters are all equal width to left align each column
Columns label currently simply cuts off all letters that exceed the width of the column, which sucks..., I've tried implementation which generate multiple textlabels and 
calculates their origin with maxWidthCount * WidthofLetter, but that doesn't seem to work, if you try with space = 8  it approximates it
I think the reason is that origin can only take int values but the exact origin mathematically are decimals so it loses accuracy 

*/

class Gui{
  
  public Gui(){
  }
  
  void textBox(String windowName, int xpos, int ypos, int xSize, int ySize, Table table){
      String displayData = parser.formatData(table);
      myTextarea = cp5.addTextarea(windowName)
                  .setPosition(xpos,ypos + 16)
                  .setSize(xSize, ySize - 16)
                  .setFont(createFont("Courier New",12))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(color(255,100))
                  .setColorForeground(color(255,100))
                  .setText(displayData)
                  ;
       int[] columnWidths = parser.getColumnWidths(table);
      
       StringBuilder output = new StringBuilder();
       for(int i = 0; i < table.getColumnCount(); i++)
       {
         if((table.getColumnTitle(i)).length() <= columnWidths[i]){
           output.append(table.getColumnTitle(i));
           for(int j = (table.getColumnTitle(i)).length(); j < columnWidths[i]; j++)
           {
           output.append(" ");
           }
         }else{
           String concatedString = (table.getColumnTitle(i)).substring(0, columnWidths[i]-3);
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
}