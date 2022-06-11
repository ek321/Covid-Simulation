public class Button {
  String name;
  int xCor;
  int yCor;
  int xLR = 80;
  int yLR = 40;
  int textSize;
  
  // constructor for button
  public Button (String name_, int xCor_, int yCor_, int textSize_) {
    name = name_;
    xCor = xCor_;
    yCor = yCor_;
    textSize = textSize_;
    // press = false;
  }
  
  // draws a labeled button at the indicated coordinates
  public void drawButton() {
    fill(255);
    rect(xCor, yCor, xLR, yLR);
    fill(0);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(name, xCor, yCor, xLR, yLR);
    textAlign(LEFT);
  }
  
  // checks if a button is pressed or not
  public boolean pressButton(int x, int y) {
    if (x > xCor && x < (xCor + (xLR))) {
      if (y > yCor && y < (yCor + (yLR))) {
        
        return true;
      }
    }
    return false;
  }
  
  // returns the name of the button
  public String getName() {
    return name;
  }
  
}
