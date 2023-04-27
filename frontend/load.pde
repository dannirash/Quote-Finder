// Copyright [2023] <Dany Rashwan>

import controlP5.*;
import processing.sound.*;
import java.io.IOException;

ControlP5 cp5;

//sound
SoundFile background, proceed, back, click, click2, click2REV, pageFlip, type;
//images
PImage[] bgd, mapButton, bptreeButton, searchButton, randomButton, startButton, backButton, nextArrowButton, backArrowButton;
//quotes
String[] quotesStr= {""};
String impStr;
//dropdownList
DropdownList categoriesList;
String categoryTxtIn;
int categoryItemIdx;
String quoteStr = "bla";
int currQuote = 0, quoteInc;
Textarea quoteTxt;
//fonts
PFont menuFont, defaultFont;
ControlFont ddlFont, ddlItemFont, tabFont, quoteFont, bangFont;
//txt file
PrintWriter inputTxt, tmp;
String[] outputTxt, categories;
Boolean loading = true;

void loadFiles() {
  //sounds
  background = new SoundFile(this, "sound/background.mp3");
  proceed = new SoundFile(this, "sound/proceed.wav");
  back = new SoundFile(this, "sound/back.wav");
  click = new SoundFile(this, "sound/click.mp3");
  click2 = new SoundFile(this, "sound/click2.mp3");
  click2REV = new SoundFile(this, "sound/click2REV.mp3");
  pageFlip = new SoundFile(this, "sound/pageFlip.mp3");
  type = new SoundFile(this, "sound/type.wav");
  //images
  //background
  bgd= new PImage[2];
  bgd[0] = loadImage("img/menu.jpg");
  bgd[1] = loadImage("img/search.jpg");
  //buttons
  mapButton = new PImage[3];
  mapButton[0] = loadImage("button/M0.png");
  mapButton[1] = loadImage("button/M1.png");
  mapButton[2] = loadImage("button/M2.png");
  bptreeButton = new PImage[3];
  bptreeButton[0] = loadImage("button/B0.png");
  bptreeButton[1] = loadImage("button/B1.png");
  bptreeButton[2] = loadImage("button/B2.png");
  startButton = new PImage[3];
  startButton[0] = loadImage("button/start0.png");
  startButton[1] = loadImage("button/start1.png");
  startButton[2] = loadImage("button/start2.png");
  searchButton = new PImage[3];
  searchButton[0] = loadImage("button/S0.png");
  searchButton[1] = loadImage("button/S1.png");
  searchButton[2] = loadImage("button/S2.png");
  randomButton = new PImage[3];
  randomButton[0] = loadImage("button/random0.png");
  randomButton[1] = loadImage("button/random1.png");
  randomButton[2] = loadImage("button/random2.png");
  backButton = new PImage[3];
  backButton[0] = loadImage("button/back0.png");
  backButton[1] = loadImage("button/back1.png");
  backButton[2] = loadImage("button/back2.png");
  backArrowButton = new PImage[3];
  backArrowButton[0] = loadImage("button/backArrow0.png");
  backArrowButton[1] = loadImage("button/backArrow1.png");
  backArrowButton[2] = loadImage("button/backArrow2.png");
  nextArrowButton = new PImage[3];
  nextArrowButton[0] = loadImage("button/nextArrow0.png");
  nextArrowButton[1] = loadImage("button/nextArrow1.png");
  nextArrowButton[2] = loadImage("button/nextArrow2.png");
  //fonts
  tabFont = new ControlFont(createFont("Arial", 1, true), 1);
  ddlFont = new ControlFont(createFont("Arial", 25, true), 25);
  ddlItemFont = new ControlFont(createFont("Arial", 17, true), 17);
  bangFont = new ControlFont(createFont("Arial", 12, true), 12);
  menuFont = createFont("American Typewriter", 30, true);
  defaultFont = createFont("Arial", 25, true);
  quoteFont = new ControlFont(createFont("Arial", 30, true), 30);
  
  tmp = createWriter("C:\\Program Files (x86)\\QuoteFinder\\windows-amd64\\data\\backend\\output.txt");
  tmp.print("loading... please try again in a second :)");
  tmp.close();
  outputTxt = loadStrings("backend/output.txt");
  delay(100);
  writeToTxt();
}

void load() {
  cp5 = new ControlP5(this);

  loadFiles();
  loadMainMenu();
  loadSearchMenu();
  loadResultMenu();

  background.loop();
  proceed.play();
  textFont(defaultFont);
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isTab()) {
    println("got an event from tab : "+theControlEvent.getTab().getName()+" with id "+theControlEvent.getTab().getId());
  }
  if (theControlEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theControlEvent.getGroup().getValue()+" from "+theControlEvent.getGroup());
  } else if (theControlEvent.isController()) {
    println("event from controller : "+theControlEvent.getController().getValue()+" from "+theControlEvent.getController());
  }
  if (theControlEvent.isAssignableFrom(Textfield.class)) {
    if (theControlEvent.getName() == "categoryTxtIn")
      categoryTxtIn = theControlEvent.getStringValue();
    println("controlEvent: accessing a string from controller '"
      +theControlEvent.getName()+"': "
      +theControlEvent.getStringValue()
      );
  }
}



void loadOutput() {
  String[] lines = loadStrings("file.txt");
  println("There are " + lines.length + " lines.");
  printArray(lines);
}
