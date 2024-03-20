import controlP5.*;

ControlP5 cp5;
DropdownList dropdown1, dropdown2;
Button submitButton, returnButton;
Textarea resultTextarea;
String selectedOption1 = "";
String selectedOption2 = "";

void setup() {
  size(400, 300);
  cp5 = new ControlP5(this);
  
  // Create dropdown list 1
  dropdown1 = cp5.addDropdownList("dropdown1")
                  .setPosition(50, 50)
                  .setSize(120, 200)
                  .setCaptionLabel("Dropdown 1");
  dropdown1.addItem("Option A", 1);
  dropdown1.addItem("Option B", 2);
  dropdown1.addItem("Option C", 3);
  
  // Create dropdown list 2
  dropdown2 = cp5.addDropdownList("dropdown2")
                  .setPosition(200, 50)
                  .setSize(120, 200)
                  .setCaptionLabel("Dropdown 2");
  dropdown2.addItem("Option 1", 1);
  dropdown2.addItem("Option 2", 2);
  dropdown2.addItem("Option 3", 3);
  
  // Create submit button
  submitButton = cp5.addButton("submit")
                     .setPosition(50, 150)
                     .setSize(100, 30)
                     .setCaptionLabel("Submit");
  
  // Create return button
  returnButton = cp5.addButton("return")
                    .setPosition(200, 150)
                    .setSize(100, 30)
                    .setCaptionLabel("Return");
  
  // Create result text area
  resultTextarea = cp5.addTextarea("ResultText")
                       .setPosition(50, 200)
                       .setSize(300, 80)
                       .setFont(createFont("Arial", 12))
                       .setLineHeight(14)
                       .setColor(color(0))
                       .setColorBackground(color(255))
                       .setColorForeground(color(0));
}

void draw() {
  background(240);
}

void controlEvent(ControlEvent event) {
  if (event.isFrom(dropdown1)) {
    selectedOption1 = getSelectedOption(dropdown1, event);
  } else if (event.isFrom(dropdown2)) {
    selectedOption2 = getSelectedOption(dropdown2, event);
  } else if (event.isFrom(submitButton)) {
    resultTextarea.setText("Selected Options:\n" + selectedOption1 + "\n" + selectedOption2);
    dropdown1.hide();
    dropdown2.hide();
  } else if (event.isFrom(returnButton)) {
    dropdown1.show();
    dropdown2.show();
    selectedOption1 = "";
    selectedOption2 = "";
    resultTextarea.clear();
  }
}

String getSelectedOption(DropdownList dropdown, ControlEvent event) {
  int selectedIndex = (int)event.getValue();
  return dropdown.getItem(selectedIndex).get("name").toString();
}
