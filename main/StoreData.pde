// class to store data into subsets - NIAMH AND SADHBH 13/3/24
class StoreData {
  
  void setup(){
    dateTable = new Table();
    mKTCarrierTable = new Table();
    
    // SADHBH
    dateTable.addColumn("Flight Date");
    for(int i = 1; i < lines.length; i++){
      String[] partsBySpace = lines[i].split(" ");
      if(partsBySpace.length > 0){
         TableRow newRow = dateTable.addRow();
         newRow.setString(0, partsBySpace[0]);
      }
    }
    
    // NIAMH
    mKTCarrierTable.addColumn("MKT Carrier");
    for(int i2 = 1; i2 < lines.length; i2++){
      String[] partsByComma = lines[i2].split(",");
      if(partsByComma.length > 1){
        TableRow newRow = mKTCarrierTable.addRow();
        String dataBetweenCommas = partsByComma[1];
        newRow.setString(0, dataBetweenCommas);
      }
    }
    
    saveTable(dateTable, "data/FL_DATE.csv");
    saveTable(mKTCarrierTable, "data/MKT_CARRIER.csv");
  }

}
