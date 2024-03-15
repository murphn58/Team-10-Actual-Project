/* Yue Pan, Parse class template for creating tables, 6pm 13/03/2024 */
class Parse{
  Table table;
  
  public Parse(){
  }

  Table createTable(String fileName){
    table = loadTable(fileName, "header");
    return table;
  } 
  
}
