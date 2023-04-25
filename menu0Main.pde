void mainMenu() {
  background(bgd[0]);
  fill(255);
  textFont(menuFont);
  text("Implementation: ", width/2 + 230, height/2 + 50);
  text(impStr, width/2 + 450, height/2 + 50);
}

void loadMainMenu() {
  //tab (HIDDEN)
  cp5.getTab("default")
    .setHeight(0)
    .setWidth(0)
    .activateEvent(true)
    .setLabel("Menu")
    .setId(1)
    .getCaptionLabel().align(CENTER, CENTER).setFont(tabFont)
    ;
  //text
  impStr = "Map";
  //buttons
  cp5.addButton("mapButton")
    .setBroadcast(true)
    .setPosition(width/2 + 190, height/2 + 130)
    .setImages(mapButton[0], mapButton[1], mapButton[2])
    .updateSize()
    ;
  cp5.addButton("bptreeButton")
    .setBroadcast(true)
    .setPosition(width/2 + 410, height/2 + 130)
    .setImages(bptreeButton[0], bptreeButton[1], bptreeButton[2])
    .updateSize()
    ;
  cp5.addButton("startButton")
    .setBroadcast(true)
    .setPosition(width/2 + 280, height/2 + 230)
    .setImages(startButton[0], startButton[1], startButton[2])
    .updateSize()
    ;
}

public void mapButton() {
  click.play();
  println("Map Implementation");
  impStr = "Map";
}
public void bptreeButton() {
  click.play();
  println("B+ Tree Implemtation");
  impStr = "B+ Tree";
}
public void startButton() {
  click.play();
  proceed.play();
  println("Starting");
  cp5.getTab("Search").bringToFront();
}
