public class Button {
  String name;
  int xCor;
  int yCor;
  int xLR = 80;
  int yLR = 40;
  boolean press;
  int textSize;
  
  //constructor for button
  public Button (String name_, int xCor_, int yCor_, int textSize_) {
    name = name_;
    xCor = xCor_;
    yCor = yCor_;
    textSize = textSize_;
  }
  
  public void drawButton() {
    fill(255);
    rect(xCor, yCor, xLR, yLR);
    fill(0);
    text(name, xCor + 4, yCor + 4, xLR, yLR);
  }
}
