/* Yue Pan, Parse class template for creating tables, 6pm 13/03/2024
   Yue Pan, Parse class updated, 9pm 16/03/2024
    int[] getColumnWidths(table) => maximum character count of the longest string in each column of a table
    String formatData(table) => Whole table String output left-alignd. Columns with string < longest Length will have whitespace inserted until they are equal
   */
class Parse{
  Table table;
  
  public Parse(){
  }

  Table createTable(String fileName){
    table = loadTable(fileName, "header");
    return table;
  } 
  
  String getData(Table table){
    String data = "";
    for(TableRow row : table.rows())
    {
      for(int i = 0; i < row.getColumnCount(); i++)
      {
        data += row.getString(i) + ",";
      }
        data += "\n";
    }
    return data;
  }
  
  int[] getColumnWidths(Table table){
    int[] maxWidths = new int[table.getColumnCount()];
    int minimumWidth = 6;
     
    for(TableRow row : table.rows())
    {
      for(int i = 0; i < row.getColumnCount(); i++)
      {
        maxWidths[i] = Math.max(maxWidths[i], (row.getString(i)).length());
        if(maxWidths[i] < minimumWidth)
        {
          maxWidths[i] = minimumWidth;
        }
      }
    }
    
    return maxWidths;
  }
  
  String formatData(Table table)
  {
    int[] maxWidths = getColumnWidths(table);
    
    StringBuilder output = new StringBuilder();
    
    for(TableRow row : table.rows())
    {
      for(int i = 0; i < row.getColumnCount(); i++)
      {
        output.append(row.getString(i));
         for(int j = (row.getString(i)).length(); j < maxWidths[i]; j++)
         {
           output.append(" ");
         }
        
        if(i < row.getColumnCount() - 1)
        {
           output.append(" ");
        }
      }
      output.append("\n");
    }
    
    return output.toString();
  }
}
