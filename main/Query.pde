//Yue Pan
class Query{
  Table returnTable = null;
  Table returnSortedTable = null;
  
  Query(Table table, Table sortedTable){               // expects Table to be passed
    returnTable = table.copy();
    returnSortedTable = sortedTable.copy();
  }
  
  /**
   * Returns Table associated with Query
   * 
   * @return table
   */
  Table getTable(){
    return returnTable;
  }
  
  void setTable(Table table){
    this.returnTable = table;
  }
  
  /**
   * Reset Table associated with Query with original
   * 
   * 
   */
  void reset(){
   returnTable = table;
  }
  
  /**
   * Modifies the associated table with the dates within range
   * 
   * 
   */
   
    void searchDates(String input) throws Exception// expects "MM/DD/YY-MM/DD/YY" in form of "start-end"
  {
    setTable(searchDatesThreads(returnTable, input));
  }
    
  /**
   * Modifies the associated table with by only including the queried states, deduces which column index to call filterTable()
   * 
   * 
   */
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
    if(input.matches("D:.*") == false && input.matches("O:.*") == false)
    {
      returnTable.clearRows();
      return;
    }
    
     shortenedInput = shortenedInput.substring(2);
     shortenedInput.trim();
     if(shortenedInput.length() <= 3)
     {
       //is abbreviation, airport or orr state or dest state, or  orr WAC code or dest WAC code
       if(shortenedInput.matches("[0-9]+"))   // if it's WAC
       {
         targetColumn += 3;
         tempTable = filterTable(returnTable, shortenedInput, targetColumn, 4);
         
       }else{   // abbreviated origin airport or origin state
         tempTable = filterTable(returnTable, shortenedInput, targetColumn, 4);  // assumes airports
         if(tempTable.getRowCount() == 0)  // returned nothing
         {
           targetColumn += 2;
           tempTable = filterTable(returnTable, shortenedInput, targetColumn, 4); // tries states
         }
       }
     }else
     {
       //is full name, orr state or dest state
       targetColumn += 1;
       tempTable = filterTable(returnTable, shortenedInput, targetColumn, 4);
       
     }
     
     this.returnTable = tempTable;
  } 
 
 /**
   * Modifies the associated table with by sorting by delay in time
   * 
   * 
   */
  void sortByLateness()                  // sorts the attached returnTable by how "late" the arrival time is, jank implementation of difference between day change vs early
  {

     returnTable = returnSortedTable;

  }
  
  void searchAirline(String airlinePrefix){  
    returnTable = filterTable(returnTable, airlinePrefix, 1, 4);  
 }


 /**
   * Returns row count
   * 
   * @return count 
   */
   
  int getCount()
  {
    return returnTable.getRowCount();
  }
  
  /**
   * Returns Hashmap with counting the cancelled and diverted flights associated with the query object's table
   * 
   * @return Hashmap
   */
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

import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;


/** Thread implementation of Queries for general matching
  *  
  */
class FilterThread extends Thread {
     Table table;
     Queue<TableRow> rowsQueue;
     String targetExpression;
     int targetColumn;
     int startIndex;
     int endIndex;

    FilterThread(Table table, Queue<TableRow> rowsQueue, String targetExpression, int targetColumn, int startIndex, int endIndex) {
        this.table = table;
        this.rowsQueue = rowsQueue;
        this.targetExpression = targetExpression;
        this.targetColumn = targetColumn;
        this.startIndex = startIndex;
        this.endIndex = endIndex;
    }
  
  /** @override run, add matching rows to concurrent linked queue
    *  
    */
    public void run() {
        for (int i = startIndex; i < endIndex; i++) {
            TableRow row = table.getRow(i);
            if (row.getString(targetColumn).matches(targetExpression + ".*")) {
                rowsQueue.add(row);
            }
        }
    }
}
  /** threads creator,
    *  @param table to search
    *  @param matching expression
    *  @param target column
    *  @param desired thread count ( currently is 4)
    *  
    *  @return table of matching rows
    */
Table filterTable(Table table, String targetExpression, int targetColumn, int numThreads) {
    ArrayList<Queue<TableRow>> threadQueues = new ArrayList<>();
    ArrayList<FilterThread> threads = new ArrayList<>();
    int rowsPerThread = table.getRowCount() / numThreads;
    int startIndex = 0;
    int endIndex = rowsPerThread;

    for (int i = 0; i < numThreads; i++) {
        Queue<TableRow> rowsQueue = new ConcurrentLinkedQueue<>();
        threadQueues.add(rowsQueue);
        if (i == numThreads - 1) {
            endIndex = table.getRowCount();
        }
        FilterThread thread = new FilterThread(table, rowsQueue, targetExpression, targetColumn, startIndex, endIndex);
        println("thread " + i + " started");
        threads.add(thread);
        thread.start();
        startIndex = endIndex;
        endIndex += rowsPerThread;
    }

    // wait for all threads to finish
    for (FilterThread thread : threads) {
        try {
            thread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    
    Queue<TableRow> finalQueue = new ConcurrentLinkedQueue<>();
    for (Queue<TableRow> queue : threadQueues) {
        finalQueue.addAll(queue);
    }

    // Create a new table and add rows from the queue
    Table tempReturnTable = table.copy();
    tempReturnTable.clearRows();
    //debugging prints
    println("starting final join"); 
    println(System.currentTimeMillis());
    tempReturnTable.addRows(new Table(finalQueue));
    println("finished");
    println(System.currentTimeMillis());

    return tempReturnTable;
}

/** Thread implementation of Queries for date range matching
  *  
  */
class DateSearchThread extends Thread {
    Table table;
    Queue<TableRow> rowsQueue;
    Date startDate;
    Date endDate;
    int startIndex;
    int endIndex;

    DateSearchThread(Table table, Queue<TableRow> rowsQueue, Date startDate, Date endDate, int startIndex, int endIndex) {
        this.table = table;
        this.rowsQueue = rowsQueue;
        this.startDate = startDate;
        this.endDate = endDate;
        this.startIndex = startIndex;
        this.endIndex = endIndex;
    }

    public void run() {
        for (int i = startIndex; i < endIndex; i++) {
            TableRow row = table.getRow(i);
            try {
                String dateString = row.getString(0);
                if(dateString.contains(" "))
                {
                  String[] tempArray= dateString.split(" ");
                  dateString = tempArray[0];
                }
                if (!dateString.isEmpty()) {
                    Date rowDate = new SimpleDateFormat("MM/dd/yyyy").parse(dateString);
                    if (!rowDate.before(startDate) && !rowDate.after(endDate)) {
                        rowsQueue.add(row);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

  /** threads creator, 4 seems to work well so sticking with it
    *  @param table to search
    *  @param desired date range in String
    *  
    *  @return table of matching rows
    */
Table searchDatesThreads(Table table, String input) throws Exception {
    String[] dateArray = input.split("-", 2);
    Date startDate = new SimpleDateFormat("MM/dd/yy").parse(dateArray[0]);
    Date endDate = new SimpleDateFormat("MM/dd/yy").parse(dateArray[1]);

    ArrayList<Queue<TableRow>> threadQueues = new ArrayList<>();
    ArrayList<DateSearchThread> threads = new ArrayList<>();
    int rowsPerThread = table.getRowCount() / 4;
    int startIndex = 0;
    int endIndex = rowsPerThread;
    
    for (int i = 0; i < 4; i++) {
      Queue<TableRow> rowsQueue = new ConcurrentLinkedQueue<>();
      threadQueues.add(rowsQueue);
      if (i == 4 - 1) {
            endIndex = table.getRowCount();
        }
        DateSearchThread thread = new DateSearchThread(table, rowsQueue, startDate, endDate, startIndex, endIndex);
        threads.add(thread);
        thread.start();
        startIndex = endIndex;
        endIndex += rowsPerThread;
    }

    // Wait for all threads to finish
    for (DateSearchThread thread : threads) {
        try {
            thread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    Queue<TableRow> finalQueue = new ConcurrentLinkedQueue<>();
    for (Queue<TableRow> queue : threadQueues) {
        finalQueue.addAll(queue);
    }

    // Create a new table and add rows from the queue
    Table tempTable = table.copy();
    tempTable.clearRows();
    tempTable.addRows(new Table(finalQueue));
    println("Date query finished");
    return tempTable;
}
