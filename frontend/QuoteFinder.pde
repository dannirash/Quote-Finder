// Copyright [2023] <Dany Rashwan>

void setup() {
  size(1366, 768);
  load();  //loads files and cp5 controls
}

void draw() {
  if (cp5.getTab("default").isActive())     //mainMenu
    mainMenu();
  else if (cp5.getTab("Search").isActive()) //searchMenu
    searchMenu();
  else                                      //resultMenu
    resultMenu();
}

void exit() {
  inputTxt = createWriter("C:\\Program Files (x86)\\QuoteFinder\\windows-amd64\\data\\backend\\input.txt");
  inputTxt.print("END_PROGRAM,please");
  inputTxt.close();
  super.exit();
} 
