
class Parse{
  Table table;
  
  Parse(){
  }
  
  Table createTable(String fileName){
    table = loadTable(fileName, "header");
    return table;
  }

}