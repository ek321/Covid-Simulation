import java.util.*;

int ROWS = 20;
int COLS = 20;
// vax mode variables
final int PRE_VAX = 0;
final int VAX = 1;
int VAX_MODE = 0;
// different vax types
final int PFIZER = 1;
final int JOHNSON = 2;
final int MODERNA = 3;
final int ALL = 4;
int VAX_TYPE = 0;
// array to keep track of people on the board
Person[][] population;
double popDen = 0.8;
boolean pressed = false;
// for time/start
int time;
int timeEnd = 50;
int countdown;
boolean play = false;
// for coloring pixels
int pixelH;
int pixelW;
// buttons
ArrayList<Button> buttonList = new ArrayList<Button>();

//new dimensions
int screenHeight = 1000;
int screenWidth = 1000;
int textHeight = 1600;
int textWidth = 600;

//boosted modes
boolean canBoost;

//mask mode
boolean mask = false;

//color vs sign representations
final int COLOR_MODE = 0;
final int SIGN_MODE = 1;
int DISPLAY_MODE = 0;

void setup() {
  size(1600, 1600);
  background(0);
  setPop();
  setButtons();

  pixelH = screenHeight / ROWS;
  pixelW = screenWidth / COLS;
}

/* Preliminary selections for the population NOT depending on user input
 Factors set by user input are either false or null
 */
public void setPop() {
  population = new Person[ROWS][COLS];
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      double temp = Math.random();
      if (temp < popDen) {
        int age = (int) (Math.random() * (100 - 18 + 1)) + 18;
        population[i][j] = new Person(age, i, j, "negative");
      } else {
        population[i][j] = null;
      }
    }
  }

  Random rng = new Random();
  for (int i = 0; i < ROWS; i++) {
    int b = rng.nextInt(30);
    // change later when covidstatus method is done
    if (b < 13 && population[i][0] != null) {
      population[i][0].setCovidStatus("infected");
    }
  }
}

/*Takes the user input and cycles through the population again to make needed changes
 */
void makePop() {
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      if (population[i][j] != null) {
        boolean vaxxed = false;
        boolean booster = false;
        if (VAX_MODE == 1) {
          Random rand = new Random();
          int vaxChance = rand.nextInt(9);
          if (vaxChance < 6) {
            vaxxed = true;
            if (canBoost) {
              booster = true;
            }
          }
          population[i][j].setVaxType(vaxTypePerson());
        }
        if (mask) {
          population[i][j].setMaskStatus(true);
        }
        population[i][j].setVaxStatus(vaxxed);
        population[i][j].boosterShot(booster);
      }
    }
  }
}

void setButtons() {
  //buttons setup
  Button preVax = new Button ("preVax", screenWidth+20, 65, 20);
  buttonList.add(preVax);
  Button vax = new Button ("vax", screenWidth+110, 65, 20);
  buttonList.add(vax);
  Button Pfizer = new Button ("Pfizer", screenWidth+20, 135, 20);
  buttonList.add(Pfizer);
  Button Johnson = new Button ("Johnson", screenWidth+110, 135, 16);
  buttonList.add(Johnson);
  Button Moderna = new Button ("Moderna", screenWidth+200, 135, 16);
  buttonList.add(Moderna);
  Button All = new Button ("All", screenWidth+290, 135, 20);
  buttonList.add(All);
  Button Boost = new Button ("Boost", screenWidth+20, 235, 20);
  buttonList.add(Boost);
  Button noBoost = new Button ("No\nBoost", screenWidth+110, 235, 14);
  buttonList.add(noBoost);
  Button Mask = new Button ("Mask", screenWidth+20, 305, 20);
  buttonList.add(Mask);
  Button noMask = new Button ("No\nMask", screenWidth+110, 305, 14);
  buttonList.add(noMask);
  Button Color = new Button ("Color", screenWidth+20, 370, 20);
  buttonList.add(Color);
  Button Sign = new Button ("Sign", screenWidth+110, 370, 20);
  buttonList.add(Sign);
  Button Start = new Button ("Start/Pause", screenWidth+20, 435, 12);
  buttonList.add(Start);
  Button AddTime = new Button ("Add\nTime", screenWidth+110, 435, 14);
  buttonList.add(AddTime);
  Button RemoveTime = new Button ("Remove\nTime", screenWidth+200, 435, 14);
  buttonList.add(RemoveTime);
  Button Reset = new Button ("Reset", screenWidth+290, 435, 20);
  buttonList.add(Reset);
}

void draw() {
  // draw the partition between simulation and side menu
  fill(89, 44, 138);
  rect(screenWidth, 0, textWidth, 550);
  fill(71, 79, 237);
  rect(screenWidth, 510, textWidth, textHeight-510);
  fill(242, 240, 94);

  disText();

  if (play) {
    if (time == 0) {
      makePop();
    }
    if (time < timeEnd) {
      ticks();
    }
  }

  //displays the buttons on the side menu
  for (int i = 0; i < buttonList.size(); i++) {
    buttonList.get(i).drawButton();
  }

  //for person attribute, relocate later
  if (pressed) {
    int x = mouseX;
    int y = mouseY;
    perView(x, y);
    pButton(x, y);
  }
}

public void disText() {
  textSize(20);
  text("Pre-Simulation Selections:", screenWidth+20, 25);
  textSize(16);
  fill(247, 183, 227);
  //user key so that they can input their choices
  text("Vax Mode: ", screenWidth+20, 60);
  text("Vax Type: ", screenWidth+20, 130);
  text("Booster Shot: ", screenWidth+20, 230);
  text("Mask Available: ", screenWidth+20, 300);
  text("Display Mode: ", screenWidth+20, 365);
  text("System Settings: ", screenWidth+20, 430);

  textSize(21);
  fill(242, 176, 94);
  text("Press the f key to start.", screenWidth+20, 500);
  fill(142, 216, 245);
  if (VAX_MODE % 2 == 1) {
    text("Vax mode on", screenWidth+210, 90);
    if (VAX_TYPE == PFIZER) {
      text("Vaccine mode chosen: Pfizer", screenWidth+20, 200);
    }
    if (VAX_TYPE == MODERNA) {
      text("Vaccine mode chosen: Moderna", screenWidth+20, 200);
    }
    if (VAX_TYPE == JOHNSON) {
      text("Vaccine mode chosen: Johnson", screenWidth+20, 200);
    }
    if (VAX_TYPE == ALL) {
      text("Vaccine mode chosen: All", screenWidth+20, 200);
    }
    if (canBoost) {
      text("Boost mode on", screenWidth+200, 260);
    }
    if (!canBoost) {
      text("Boost mode off", screenWidth+200, 260);
    }
  } else {
    VAX_TYPE = 0;
    text("Vax mode off", screenWidth+210, 90);
  }
  if (mask) {
    text("Mask mode on", screenWidth+200, 335);
  } else if (!mask) {
    text("Mask mode off", screenWidth+200, 335);
  }

  fill(142, 216, 245);
  if (DISPLAY_MODE == COLOR_MODE) {
    text("Color mode on", screenWidth+200, 398);
  } else if (DISPLAY_MODE == SIGN_MODE) {
    text("Sign mode on", screenWidth+200, 398);
  }

  fill(242, 240, 94);
  textSize(20);
  text("Simulation Statistics:", screenWidth+20, 530);
  textSize(18);
  fill(94, 242, 232);
  text("time:"+time, screenWidth+20, 560);
  text("Simulation Stop Time: " + timeEnd, screenWidth + 130, 560);
  text("Total # of Covid Cases: " + covidCasesPop(), screenWidth+20, 590);
  text("Percentage of Population Infected: " + (100 * (float)covidCasesPop() / (population.length * population[0].length)), screenWidth+20, 620);
  text("Population density:"+Math.round(popDen * 100.0)/100.0, screenWidth+20, 650);
}

/* Visualizes the simulation as blocks of color
 blue = not infected
 orange = positive
 green = recovered
 gray = dead
 */
public void spreadColor () {
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      if (population[i][j] != null) {
        color temp = colPer(population[i][j]);
        // use pixelH and pixelW
        fill (temp);
        rect(j * pixelH, i * pixelW, pixelH, pixelW);
      } else {
        fill(color(0));
        rect(j * pixelH, i * pixelW, pixelH, pixelW);
      }
    }
  }
}

/*Visualizes the simulation using signs
 "+" = positive
 "-" = negative
 "," = recovered
 "." = dead
 */
public void spreadSign () {
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      if (population[i][j] != null) {
        String temp = signPer(population[i][j]);
        // use pixelH and pixelW
        fill(109, 130, 201);
        rect(j * pixelH, i * pixelW, pixelH, pixelW);
        fill(255);
        textSize(25);
        text(temp, pixelH*j+(pixelH/2), pixelW*i+(pixelW/2));
      } else {
        fill(color(0));
        text(" ", pixelH*j+(pixelH/2), pixelW*i+(pixelW/2));
      }
    }
  }
}

//advances the simulation
public void setNext() {
  for (int i = 0; i < population[0].length; i++) {
    for (int j = 0; j < population.length; j++) {
      if (population[i][j] != null) {
        // use pixelH and pixelW
        population[i][j].catchCovid();
        if (i == population.length / 2) {
          if (population[i][j].isBoosted() && population[i][j].getVaxType() != null) {
            population[i][j].getVaxType().boost();
          }
        }
        if (population[i][j].getVaxStatus()) {
          population[i][j].getVaxType().setEfficacy();
        }
      }
    }
  }
}

//returns which color a Person will be represnted as based on their covid status
public color colPer(Person pep) {
  if (pep.getCovidStatus().equals("infected")) {
    return color(252, 158, 69);
  } else if (pep.getCovidStatus().equals("negative")) {
    return color(69, 119, 252);
  } else if (pep.getCovidStatus().equals("recovery")) {
    return color(135, 245, 89);
  } else if (pep.getCovidStatus().equals("dead")) {
    return color(108, 112, 109);
  }
  return color(255);
}

//returns what symbol a Person will be represented as based on their covid status
public String signPer(Person pep) {
  if (pep.getCovidStatus().equals("infected")) {
    return "+";
  } else if (pep.getCovidStatus().equals("negative")) {
    return "-";
  } else if (pep.getCovidStatus().equals("recovery")) {
    return ",";
  } else if (pep.getCovidStatus().equals("dead")) {
    return ".";
  }
  return "-";
}

// sets the Vaccine type that someone will receive based on user input
public Vaccine vaxTypePerson() {
  boolean temp = (VAX_TYPE == ALL);
  Vaccine ans = new Vaccine("Pfizer");
  if (temp) {
    int rng = (int) (Math.random() * (3));
    VAX_TYPE = rng;
  }
  if (VAX_TYPE == PFIZER) {
    ans = new Vaccine("Pfizer");
  } else if (VAX_TYPE == JOHNSON) {
    ans = new Vaccine("Johnson");
  } else if (VAX_TYPE == MODERNA) {
    ans = new Vaccine("Moderna");
  }
  return ans;
}

//resets the simulation page, so someone can make their selections and run the simulation again
public void reset() {
  time = 0;
  background(0);
  population = new Person[ROWS][COLS];
  setPop();
}

//counts the number of infected neighbors that a Person has
public int neighInfect(Person pep) {
  if (pep != null) {
    int counter = 0;
    Person temp;
    // check for out of bounds on left
    if (pep.getXCor() != 0) {
      temp = population[pep.getXCor() - 1][pep.getYCor()];
      if (temp != null && temp.getCovidStatus().equals("infected")) {
        counter ++;
      }
    }

    // check for out of bounds on right
    if (pep.getXCor() != population[0].length - 1) {
      temp = population[pep.getXCor() + 1][pep.getYCor()];
      if (temp != null && temp.getCovidStatus().equals("infected")) {
        counter ++;
      }
    }

    // check for out of bounds on top
    if (pep.getYCor() != 0) {
      temp = population[pep.getXCor()][pep.getYCor() - 1];
      if (temp != null && temp.getCovidStatus().equals("infected")) {
        counter ++;
      }
    }

    // check for out of bounds on bottom
    if (pep.getYCor() != population.length - 1) {
      temp = population[pep.getXCor()][pep.getYCor() + 1];
      if (temp != null && temp.getCovidStatus().equals("infected")) {
        counter ++;
      }
    }

    return counter;
  } else {
    return 1;
  }
}

//advances the simulation
public void ticks() {
  if (countdown > 0) {
    countdown --;
  }
  //spreadColor
  if (countdown == 0) {
    countdown = 60;
    if (DISPLAY_MODE == COLOR_MODE) {
      spreadColor();
    } else if (DISPLAY_MODE == SIGN_MODE) {
      spreadSign();
    }
    time++;
    fill(255);
    setNext();
  }
}

//counts the number of covid cases in the population
public int covidCasesPop() {
  int counter = 0;
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      if (population[i][j] != null) {
        if (population[i][j].getCovidStatus().equals("infected")) {
          counter++;
        }
      }
    }
  }
  return counter;
}

public float vaxStatusPop() {
  float counter = 0;
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      if (population[i][j] != null) {
        if (population[i][j].getVaxStatus()) {
          counter++;
        }
      }
    }
  }
  counter = counter / (population.length * population[0].length);
  return Math.round(counter * 100.0) / 100.0;
}

public void mousePressed() {
  pressed = true;
}

public void mouseReleased() {
  pressed = false;
}

//user selection
public void pButton(int x, int y) {
  Button temp = checkButton(x, y);
  if (temp != null) {
    //changing vax mode
    String s = temp.getName();
    if (s.equals("preVax")) {
      VAX_MODE = PRE_VAX;
    } else if (s.equals("vax")) {
      VAX_MODE = VAX;
    }

    //changing vax type/boost
    if (VAX_MODE == VAX) {
      if (s.equals("Pfizer")) {
        VAX_TYPE = PFIZER;
      } else if (s.equals("Johnson")) {
        VAX_TYPE = JOHNSON;
      } else if (s.equals("Moderna")) {
        VAX_TYPE = MODERNA;
      } else if (s.equals("All")) {
        VAX_TYPE = ALL;
      } else if (s.equals("Boost")) {
        //adds booster shot in after a while
        canBoost = true;
      } else if (s.equals("No\nBoost")) {
        canBoost = false;
      }
    }

    //changing mask mode
    if (s.equals("Mask")) {
      mask = false;
    } else if (s.equals("No\nMask")) {
      mask = true;
    }

    //resetting the simulation
    if (s.equals("Reset")) {
      //add pause function so that it doesn't immediately restart (probably)
      reset();
    }

    //changing display mode
    if (s.equals("Color")) {
      DISPLAY_MODE = COLOR_MODE;
    } else if (s.equals("Sign")) {
      DISPLAY_MODE = SIGN_MODE;
    }

    //changing time max (need to 
    if (s.equals("Add\nTime")) {
      timeEnd = timeEnd + 5;
    } else if (s.equals("Remove\nTime")) {
      if (timeEnd > 0) {
        timeEnd = timeEnd - 5;
      }
    }

    //start simulation
    if (s.equals("Start/Pause")) {
      if (!play) {
        play = true;
      } else if (play) {
        play = false;
      }
    }
  }
}

public Button checkButton(int x, int y) {
  // go through arraylist of buttons and check if they are pressed
  Button temp;
  for (int i = 0; i < buttonList.size(); i++) {
    temp = buttonList.get(i);
    if (temp.pressButton(x, y)) {
      return temp;
    }
  }
  return null;
}

/*When someone presses over a Person, their attributes will appear under "Simulation Stats" in the side panel
 */
public void perView(int x, int y) {
  // will display attributes of person that mouse clicked on
  Person temp = checkPer(x, y);
  if (temp != null) {
    fill(255);
    textSize(16);
    text("Personal Status -", screenWidth + 20, 670);
    text("Position: (" + (temp.getYCor() + 1) + ", " + (temp.getXCor() + 1) + ")", screenWidth + 20, 685);
    text("Age: " + temp.getAge(), screenWidth + 20, 700);
    if (temp.getVaxStatus()) {
      text("Vaccination Status: Vaccinated (" + temp.getVaxType().toString() + ")", screenWidth + 20, 715);
    } else {
      text("Vaccination Status: Unvaccinated", screenWidth + 20, 715);
    }
    text("Is Boosted: " + temp.isBoosted(), screenWidth + 20, 730);
    text("Covid Status: " + temp.getCovidStatus(), screenWidth + 20, 745);
    text("Wears a Mask: " + temp.getMaskStatus(), screenWidth + 20, 760);
  }
}

//returns the Person at a given location
public Person checkPer(int x, int y) {
  for (int i = 0; i < population.length; i ++) {
    for (int j = 0; j < population[0].length; j++) {
      Person temp = population[i][j];
      if (temp != null) {
        if (clickPer(temp, x, y)) {
          return temp;
        }
      }
    }
  }
  return null;
}

public boolean clickPer(Person pep, int x, int y) {
  if ((y < ((pep.getXCor() + 1) * pixelH)) && (y > (pep.getXCor() * pixelH))) {
    if ((x < ((pep.getYCor() + 1) * pixelW)) && (x > (pep.getYCor() * pixelH))) {
      return true;
    }
  }
  return false;
}
