class Parse {
    Table table;

    Parse() {
    }

    Table createTable(String fileName) {
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
}
