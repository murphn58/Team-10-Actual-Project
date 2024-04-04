//Yue
class Query{
  Table returnTable = null;
  
  Query(Table table){               // expects Table to be passed
    returnTable = table.copy();
  }
  
  Table getTable(){
    return returnTable;
  }
    void searchDates(String input) throws Exception// expects "MM/DD/YY-MM/DD/YY" in form of "start-end"
  {
    String[] dateArray = input.split("-", 2);
    Date startDate = new SimpleDateFormat("MM/dd/yy").parse(dateArray[0]);
    Date endDate = new SimpleDateFormat("MM/dd/yy").parse(dateArray[1]);
    
    Date rowDate = null;
    Table tempTable = this.returnTable.copy();
    tempTable.clearRows();
    
    for(TableRow row : returnTable.rows())
    {
       if(row.getString(0) != "")
       {
         rowDate = new SimpleDateFormat("MM/dd/yyyy HH:mm").parse(row.getString(0));

         if(rowDate.before(startDate) == false && rowDate.after(endDate) == false)
         {
           tempTable.addRow(row);
         }
       }
    }
    
    this.returnTable = tempTable;
  }
  void searchStates(String input){   // changes the attached returnTable, expected "D:INPUT" or "O:INPUT" for destination or origin, can tell the difference between airport/state, abbreviations, full location name, and WAC
    // 
    int targetColumn = 0;
    String shortenedInput = input;
    Table tempTable = null;
    
    if(input.matches("D:.*"))
    {
      // dest indices starts at 7
      targetColumn += 7;
    }
    
    if(input.matches("O:.*"))
    {  
      // origin indices starts at 3
      targetColumn += 3;
      println("finding origins");
    }
    
     shortenedInput = shortenedInput.substring(2);
     shortenedInput.trim();
     if(shortenedInput.length() <= 3)
     {
       //is abbreviation, airport or orr state or dest state, or  orr WAC code or dest WAC code
       if(shortenedInput.matches("[0-9]+"))   // if it's WAC
       {
         targetColumn += 3;
         tempTable = filterTable(returnTable, shortenedInput, targetColumn);
         
       }else{   // abbreviated origin airport or origin state
         tempTable = filterTable(returnTable, shortenedInput, targetColumn);  // assumes airports
         if(tempTable.getRowCount() == 0)  // returned nothing
         {
           targetColumn += 2;
           tempTable = filterTable(returnTable, shortenedInput, targetColumn); // tries states
         }
       }
     }else
     {
       //is full name, orr state or dest state
       targetColumn += 1;
       tempTable = filterTable(returnTable, shortenedInput, targetColumn);
       
     }
     
     this.returnTable = tempTable;
  }
  
  void sortByLateness()                  // sorts the attached returnTable by how "late" the arrival time is, jank implementation of difference between day change vs early
  {
    Table tempTable = this.returnTable;
    tempTable.addColumn("lateTime", Table.INT);
    
    for(TableRow row: tempTable.rows()){
      if(row.getString("CANCELLED").equals("1"))
      {
        row.setInt("lateTime", -99);  // defaulting to top of list
      }else    // column 14 = actual , column 13 = planned 
      {
        if(row.getString("ARR_TIME").equals("") == false && row.getString("CRS_ARR_TIME").equals("") == false)
        {
          int actualArrivalTime = Integer.parseInt(row.getString("ARR_TIME"));
          int plannedArrivalTime = Integer.parseInt(row.getString("CRS_ARR_TIME"));
          
          int difference = actualArrivalTime - plannedArrivalTime;
          if(difference < 0)
          {
            if(actualArrivalTime < 500 && plannedArrivalTime >= 2200)    // if the difference changed days
            {
              difference = actualArrivalTime + 2400 - plannedArrivalTime;
            }
          }
          row.setInt("lateTime", difference);
        }
      }
    }
    
    tempTable.sort("lateTime");
    tempTable.removeColumn("lateTime");
    returnTable = tempTable;
  }
  
  Table filterTable(Table table, String targetExpression, int targetColumn)   // returns a table that only contains the target expression in the target column, partially matches from left to right so the full word is not needed
  {
    Table tempReturnTable = table.copy();
    tempReturnTable.clearRows();
    
    for(TableRow row : table.matchRows(targetExpression + ".*", targetColumn))
    {
      tempReturnTable.addRow(row);
    }
    
    return tempReturnTable;
  }
  
  void searchAirline(String airlinePrefix){  
    returnTable = filterTable(returnTable, airlinePrefix, 1);  
 }
 
 void reset(){
   returnTable = table;
  }
  
  int getCount()
  {
    return returnTable.getRowCount();
  }
  
  
  HashMap<String, Integer> flightAttributes()
  {
    HashMap<String, Integer> displayedFlightAttributes = new HashMap<>();
    for(TableRow row : returnTable.rows()) {
      if(row.getString("CANCELLED").equals("1"))
      {
        displayedFlightAttributes.put("CANCELLED",  displayedFlightAttributes.getOrDefault("CANCELLED", 0) + 1);                      
      }
      if(row.getString("DIVERTED").equals("1"))
      {
        displayedFlightAttributes.put("DIVERTED",  displayedFlightAttributes.getOrDefault("DIVERTED", 0) + 1);                      
      }
  }
  
  return  displayedFlightAttributes;
  }
}
