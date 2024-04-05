// Stores and formats data into to table and returns as a string representation of said data
// Yue Pan 
class Parse{
  Table table;
  
  Parse(){
  }
  
  /** 
   * Creates a Table object from a CSV file.
   * 
   * @param name of CSV file.
   * @return A Table object containing the data from the CSV file.
   */
  Table createTable(String fileName){
    table = loadTable(fileName, "header");
    return table;
  }
 

  HashMap<String, Integer> extractDateAndCountFlights(Table table) {
  HashMap<String, Integer> flightsPerDate = new HashMap<String, Integer>();
  for (TableRow row : table.rows()) {
    String date = row.getString(0); // Assuming date is in the first column
    if (flightsPerDate.containsKey(date)) {
      flightsPerDate.put(date, flightsPerDate.get(date) + 1);
    } else {
      flightsPerDate.put(date, 1);
    }
  }

  return flightsPerDate;
  }
 
  /** 
   * Converts a Table object into a string representation.
   * 
   * @param  Table object 
   * @return String representation of table object.
   */
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
  
  
  /**
   * Calculates the maximum widths of columns in the provided Table.
   * 
   * @param  Table object 
   * @return An array containing the maximum widths of each column.
   */ 
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
  
  /**
   * Formats the data in the provided Table object by padding spaces according to the maximum widths of each column
   * 
   * @param  Table
   * @return String representation of table object.
   */   
  String formatData(Table table)
  {
    
    if(table.getRowCount() > 10000)
    {
      return "";
    }
    StringBuilder output = new StringBuilder();
    
    for(TableRow row : table.rows())
    {
      for(int i = 0; i < row.getColumnCount(); i++)
      {
        output.append(row.getString(i));
         for(int j = (row.getString(i)).length(); j < maximumWidths[i]; j++)
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
