void resultMenu() {
  quoteStr = outputTxt[currQuote];//quotesStr[currQuote];
  quoteTxt.setText(quoteStr);
  background(0);
  fill(255);
  
  if (categoryTxtIn != "")
    text(categoryTxtIn.toUpperCase(), width/2 - categoryTxtIn.length()*10, height/2 - 250);
  else 
    text(categoriesList.getItem(categoryItemIdx).get("name").toString().toUpperCase(), width/2 + 30, height/2 - 250);
}

void loadResultMenu() {
  //tab (HIDDEN)
  cp5.addTab("Result")
    .setHeight(0)
    .setWidth(0)
    .activateEvent(true)
    .setId(3)
    .getCaptionLabel().align(CENTER, CENTER).setFont(tabFont)
    ;
  //initializers
  currQuote = 0;
  quoteInc = 1;
  quoteStr = outputTxt[currQuote];//quotesStr[currQuote];

  //buttons
  cp5.addButton("nextArrowButton")
    .setBroadcast(true)
    .setPosition(width/2 + 402, height/2 - 30)
    .setImages(nextArrowButton[0], nextArrowButton[1], nextArrowButton[2])
    .moveTo("Result")
    .updateSize()
    ;

  cp5.addButton("backArrowButton")
    .setBroadcast(true)
    .setPosition(width/2 - 470, height/2 - 30)
    .setImages(backArrowButton[0], backArrowButton[1], backArrowButton[2])
    .moveTo("Result")
    .updateSize()
    ;

  //text area
  quoteTxt = cp5.addTextarea("quoteTxt")
    .setPosition(width/2 - 400, height/2 - 200)
    .setSize(800, 400)
    .setFont(quoteFont)
    //.setLineHeight(14)
    .setColor(color(255))
    .setColorBackground(color(255, 100))
    .moveTo("Result")
    .setColorForeground(color(255, 100))
    .setText(quoteStr)
    ;
    
      //buttons
  cp5.addButton("randomButton")
    .setBroadcast(true)
    .setPosition(width/2 -120, height/2 + 210)
    .setImages(randomButton[0], randomButton[1], randomButton[2])
    .moveTo("Result")
    .updateSize()
    ;
}

public void backArrowButton() {

  if (currQuote > 0)
  {
    pageFlip.play();
    currQuote--;
  }
  println("backArrow");
}

public void nextArrowButton() {

  if (currQuote < outputTxt.length-1)//quotesStr.length-1)
  {
    pageFlip.play();
    currQuote++;
  }
  println("nextArrow");
}

public void randomButton() {
  delay(100);
  categoryTxtIn = categories[(int)random(0, categories.length-1)].toUpperCase();
  //output implementation, category in a text file
  writeToTxt();
  click.play();
  proceed.play();
  println("Randomizing");
}
