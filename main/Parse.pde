
class Parse{
  Table table;
  
  Parse(){
  }
  
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
