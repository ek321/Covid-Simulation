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
// for time
int time;
int countdown;
// for coloring pixels
int pixelH;
int pixelW;
// for testing purposes
//int tick;

//new dimensions
int screenHeight = 1000;
int screenWidth = 1000;
int textHeight = 1600;
int textWidth = 600;

//boosted modes
boolean canBoost;

//mask mode
boolean mask = false;
int popVaxxed = 0;

//color vs sign representations
int COLOR_MODE = 0;
int SIGN_MODE = 1;
int DISPLAY_MODE = 1;

void setup() {
  size(1600, 1600);
  background(0);
  setPop();

  pixelH = screenHeight / ROWS;
  pixelW = screenWidth / COLS;
}

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
            popVaxxed++;
            vaxxed = true;
             if (canBoost){
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
void draw() {
  fill(89, 44, 138);
  rect(screenWidth, 0, textWidth, 445);
  fill(71, 79, 237);
  rect(screenWidth, 445, textWidth, textHeight-445);
  fill(242,240,94);
  textSize(20);
  text("Pre-Simulation Selections:", screenWidth+20, 25);
  textSize(16);
  fill(247, 183, 227);
  //user key so that they can input their choices
  text("Press a for Vax mode", screenWidth+20, 60);
  text("Press the b key 1 time for Pfizer", screenWidth+20, 130);
  text("Press the b key 2 times for Johnson+Johnson", screenWidth+20, 160);
  text("Press the b key 3 times for Moderna", screenWidth+20, 190);
  text("Press the b key 4 times for All", screenWidth+20, 220);
  text("Press the c key for Boost mode.", screenWidth+20, 290);
  text("Press the d key for mask mode.", screenWidth+20, 360);
  textSize(21);
  fill(242,176,94);
  text("Press the e key to start.", screenWidth+20, 430);
  fill(142, 216, 245);
  if (VAX_MODE % 2 == 1) {
    text("Vax mode on", screenWidth+20, 90);
      if (VAX_TYPE == PFIZER) {
        text("Vaccine mode chosen: Pfizer", screenWidth+20, 250);
      }
      if (VAX_TYPE == MODERNA) {
        text("Vaccine mode chosen: Moderna", screenWidth+20, 250);
      }
      if (VAX_TYPE == JOHNSON) {
        text("Vaccine mode chosen: Johnson", screenWidth+20, 250);
      }
      if (VAX_TYPE == ALL) {
        text("Vaccine mode chosen: All", screenWidth+20, 250);
      }
      if (canBoost) {
        text("Boost mode on", screenWidth+20, 320);
      }
  } else {
    VAX_TYPE = 0;
    text("Vax mode off", screenWidth+20, 90);
  }
  if (mask) {
    text("Mask mode on", screenWidth+20, 390);
  }
  if (key == 'e') {
    if (time == 0) {
      makePop();
    }
    if (time < 50) {
      ticks();
    }
  }

  //for person attribute, relocate later
  if (pressed) {
    int x = mouseX;
    int y = mouseY;
    perView(x, y);
  }

  fill(242,240,94);
  textSize(20);
  text("Simulation Statistics:", screenWidth+20, 470);
  textSize(18);
  fill(94,242,232);
  text("time:"+time, screenWidth+20, 500);
  text("Total # of Covid Cases: " + covidCasesPop(), screenWidth+20, 530);
  text("Percentage of Population Infected: " + (100 * (float)covidCasesPop() / (population.length * population[0].length)), screenWidth+20, 560);
  text("Population density:"+Math.round(popDen * 100.0)/100.0, screenWidth+20, 590);
}

//speadColor
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

//spreadSign
public void spreadSign () {
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      if (population[i][j] != null) {
        String temp = signPer(population[i][j]);
        // use pixelH and pixelW
        fill(255);
        textSize(25);
        text(temp, pixelH*j, pixelW*i);
      } else {
        fill(color(0));
        text(" ", pixelH*j, pixelW*i);
      }
    }
  }
}


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

public color colPer(Person pep) {
  if (pep.getCovidStatus().equals("infected")) {
    return color(252, 158, 69);
  } else if (pep.getCovidStatus().equals("negative")) {
    return color(69, 119, 252);
  } else if (pep.getCovidStatus().equals("recovery")) {
    return color(135, 245, 89);
  } else if (pep.getCovidStatus().equals("dead")) {
    return color(108,112,109);
  }
  return color(255);
}

public String signPer(Person pep){
  if(pep.getCovidStatus().equals("infected")){
    return "+";
  }
  else if(pep.getCovidStatus().equals("negative")){
    return "-";
  }
  else if(pep.getCovidStatus().equals("recovery")){
    return ",            ";
  }
  else if(pep.getCovidStatus().equals("dead")){
    return ".             ";
  }
  return "-";
}

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

void keyPressed () {
  // circle through vax mode with key 'a'
  if (key == 'a') {
    VAX_MODE++;
    if(VAX_MODE % 2 == 0){
      VAX_MODE = PRE_VAX;
    }
    else {
    VAX_MODE = VAX;
    }
  }
  // cycle through vax types with key 'b'
  if (key == 'b') {
    if (VAX_MODE % 2 == 1) {
      if (VAX_TYPE == ALL) {
        VAX_TYPE = PFIZER;
      } else {
        VAX_TYPE++;
      }
    }
  }
  //adds booster shot in after a while
  if (key == 'c') {
    if (VAX_MODE == VAX) {
      canBoost = true;
    }
  }
  if (key == 'd') {
    mask = true;
  }

  if (key == 'r') {
    reset();
  }
}

public void reset() {
  time = 0;
  background(0);
  population = new Person[ROWS][COLS];
  setPop();
}

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

public void ticks() {
  if (countdown > 0) {
    countdown --;
  }
//spreadColor
  if (countdown == 0) {
    countdown = 60;
   if(DISPLAY_MODE % 2 == 0){
     DISPLAY_MODE = COLOR_MODE;
     spreadColor();
   }
   else if(DISPLAY_MODE % 2 == 1){
     DISPLAY_MODE = SIGN_MODE;
     spreadSign();
   }
    time++;
    fill(255);
    setNext();
  }
}

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

public void perView(int x, int y) {
  // will display attributes of person that mouse clicked on
  Person temp = checkPer(x, y);
  if (temp != null) {
    fill(255);
    textSize(16);
    text("Personal Status -", screenWidth + 20, 630);
    text("Position: (" + (temp.getYCor() + 1) + ", " + (temp.getXCor() + 1) + ")", screenWidth + 20, 645);
    text("Age: " + temp.getAge(), screenWidth + 20, 660);
    if (temp.getVaxStatus()) {
      text("Vaccination Status: Vaccinated (" + temp.getVaxType().toString() + ")", screenWidth + 20, 675);
    } else {
      text("Vaccination Status: Unvaccinated", screenWidth + 20, 675);
    }
    text("Is Boosted: " + temp.isBoosted(), screenWidth + 20, 690);
    text("Covid Status: " + temp.getCovidStatus(), screenWidth + 20, 705);
    text("Wears a Mask: " + temp.getMaskStatus(), screenWidth + 20, 720);
  }
}

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
