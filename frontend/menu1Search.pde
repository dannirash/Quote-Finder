// Copyright [2023] <Dany Rashwan>

void searchMenu() {
  background(bgd[1]);
  fill(0);
  text(impStr, width/2 - impStr.length()*8, height/2 - 280);
}

void loadSearchMenu() {
  //tab (HIDDEN)
  cp5.addTab("Search")
    .setHeight(0)
    .setWidth(0)
    .activateEvent(true)
    .setId(2)
    .getCaptionLabel().align(CENTER, CENTER).setFont(tabFont)
    ;

  //input text
  categoryTxtIn = "";

  //Categories' input text
  cp5.addTextfield("categoryTxtIn")
    .setPosition(width/2+10-200, height/2-230)
    .setColorBackground(color(0, 190))
    .setSize(275, 30)
    .setLabel("")
    .moveTo("Search")
    .setFont(defaultFont)
    .setAutoClear(false)
    ;
  //Categories' set and clear
  cp5.addBang("setCategoryTxt")
    .setPosition(width/2+288-200, height/2-230)
    .setSize(60, 30)
    .setLabel("set")
    .setFont(bangFont)
    .moveTo("Search")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
  cp5.addBang("clearCategoryTxt")
    .setPosition(width/2+350-200, height/2-230)
    .setSize(60, 30)
    .setLabel("clear")
    .setFont(bangFont)
    .moveTo("Search")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
  //Categories' List
  categoriesList = cp5.addDropdownList("categoriesList")
    .setPosition(width/2+10-200, height/2-200)
    .moveTo("Search")
    ;
  customizeCategoriesList();

  //item selected (Random)
  categoryItemIdx = 0;

  //buttons
  cp5.addButton("searchButton")
    .setBroadcast(true)
    .setPosition(width/2 -120, height/2 + 180)
    .setImages(searchButton[0], searchButton[1], searchButton[2])
    .moveTo("Search")
    .updateSize()
    ;
  //back button used for search and result
  cp5.addButton("backButton")
    .setBroadcast(true)
    .setPosition(50, height/2 + 250)
    .setImages(backButton[0], backButton[1], backButton[2])
    .moveTo("Search")
    .updateSize()
    ;
}

public void categoriesList() {
  click2.play();
  categoryItemIdx = (int)categoriesList.getValue();
  categoryTxtIn = cp5.get(DropdownList.class, "categoriesList").getItem(categoryItemIdx).get("name").toString().toUpperCase();
}

public void setCategoryTxt() {
  if (cp5.get(Textfield.class, "categoryTxtIn").getText().length() >= 1)
  {
    click2.play();
    categoryTxtIn = cp5.get(Textfield.class, "categoryTxtIn").getText().toLowerCase();
    print(categoryTxtIn);
    //for loop categories, if categories match the categoryTxtIn show, if not delete
    if (categoryTxtIn != "") {
      categoriesList.clear();
      categoriesList.close().getCaptionLabel().set(categoryTxtIn);
      //categoriesList.addItem("Random Category", 0).setFont(ddlItemFont);
      for (int i=0; i < categories.length; i++) {
        if (categories[i].contains(categoryTxtIn)) {
          categoriesList.addItem(categories[i], i).setFont(ddlItemFont);
        }
      }
    }
  }
}

void keyReleased() {

  if (cp5.get(Textfield.class, "categoryTxtIn").getText().length() >= 1)
  {
    type.play();
    categoryTxtIn = cp5.get(Textfield.class, "categoryTxtIn").getText().toLowerCase();
    print(categoryTxtIn);
    categoriesList.open();
    //for loop categories, if categories match the categoryTxtIn show, if not delete
    if (categoryTxtIn != "") {
      categoriesList.clear();
      //categoriesList.open().getCaptionLabel().set(categoryTxtIn);
      //categoriesList.addItem("Random Category", 0).setFont(ddlItemFont);
      for (int i=0; i < categories.length; i++) {
        if (categories[i].contains(categoryTxtIn)) {
          categoriesList.addItem(categories[i], i).setFont(ddlItemFont);
        }
      }
    }
  }
}

public void writeToTxt() {
  //writes implementation and category to input.txt
  //debug
  inputTxt = createWriter("C:\\Program Files (x86)\\QuoteFinder\\windows-amd64\\data\\backend\\input.txt");
    
  if(loading)
    inputTxt.print("MAP,abbey");
  else
    inputTxt.print(impStr.toUpperCase() + "," + categoryTxtIn.toLowerCase());
  
  inputTxt.close();
  delay(100);
  
  //runs a.exe
  try {
    Runtime.getRuntime().exec("C:\\Program Files (x86)\\QuoteFinder\\windows-amd64\\data\\backend\\a.exe", null, new File("C:\\Program Files (x86)\\QuoteFinder\\windows-amd64\\data\\backend"));
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  delay(100);
  //reads output.txt
  outputTxt = loadStrings("backend/output.txt");
  
  println("There are " + outputTxt.length + " lines.");
  printArray(outputTxt);
  delay(100);
}

public void clearCategoryTxt() {
  click2REV.play();
  categoryTxtIn = "";
  categoryItemIdx = 0;
  cp5.get(Textfield.class, "categoryTxtIn").clear();
  categoriesList.open().getCaptionLabel().set("Categories");
  categoriesList.clear();
  //categoriesList.addItem("Random Category", 0).setFont(ddlFont);
  for (int i=0; i < categories.length; i++) {
    categoriesList.addItem(categories[i], i).setFont(ddlItemFont);
  }
}

void customizeCategoriesList() {
  categoriesList.setSize(400, 300);
  categoriesList.setItemHeight(40);
  categoriesList.setBarHeight(60);
  categoriesList.getCaptionLabel()
    .set("Categories")
    .align(ControlP5.CENTER, ControlP5.CENTER)
    ;
  categoriesList.setFont(ddlFont);
  //categoriesList.addItem("Random Category", 0).setFont(ddlFont);

  categories = loadStrings("quotes/categories.txt");
  for (int i=0; i < categories.length; i++) {
    categoriesList.addItem(categories[i], i).setFont(ddlItemFont);
  }

  categoriesList.setColorBackground(color(0, 128));
  categoriesList.setColorActive(color(60));
}

public void searchButton() {
  if(categoryTxtIn == "" )//|| categoriesList.getItem(categoryItemIdx).get("name").toString().toUpperCase().contains("RANDOM CATEGORY"))
    categoryTxtIn = categories[(int)random(0, categories.length-1)].toUpperCase();
  //output implementation, category in a text file
  writeToTxt();
  click.play();
  proceed.play();
  println("Searching");
  cp5.getTab("Result").bringToFront();
  cp5.getController("backButton").moveTo("Result");
}

public void backButton() {
  click.play();
  back.play();
  println("Back");
  if (cp5.getTab("Result").isActive()) {
    cp5.getController("backButton").moveTo("Search");
    cp5.getTab("Search").bringToFront();
  } else if (cp5.getTab("Search").isActive())
    cp5.getTab("default").bringToFront();
}
