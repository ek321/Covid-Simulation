public class Button {
  String name;
  int xCor;
  int yCor;
  int xLR = 80;
  int yLR = 40;
  //boolean press;
  int textSize;
  
  //constructor for button
  public Button (String name_, int xCor_, int yCor_, int textSize_) {
    name = name_;
    xCor = xCor_;
    yCor = yCor_;
    textSize = textSize_;
    // press = false;
  }
  
  public void drawButton() {
    fill(255);
    rect(xCor, yCor, xLR, yLR);
    fill(0);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(name, xCor, yCor, xLR, yLR);
    textAlign(LEFT);
  }
  
  public boolean pressButton(int x, int y) {
    if (x > xCor && x < (xCor + (xLR))) {
      if (y > yCor && y < (yCor + (yLR))) {
        
        return true;
      }
    }
    return false;
  }
  
  public String getName() {
    return name;
  }
  
}
