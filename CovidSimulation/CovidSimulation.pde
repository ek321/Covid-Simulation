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

void setup() {
  size(1600, 1600);
  background(0);
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

  pixelH = screenHeight / ROWS;
  pixelW = screenWidth / COLS;

  Random rng = new Random();
  for (int i = 0; i < ROWS; i++) {
    int b = rng.nextInt(30);
    // change later when covidstatus method is done
    if (b < 13 && population[i][0] != null) {
      population[i][0].setCovidStatus("infected");
    }
  }
}
 
 void makePop(){
   for(int i = 0; i < population.length; i++){
     for(int j = 0; j < population[0].length; j++){
       if(population[i][j] != null){
         boolean vaxxed = false;
       boolean booster = false;
       if(VAX_MODE == 1){
         Random rand = new Random();
         int vaxChance = rand.nextInt(9);
          if(vaxChance < 6){
            vaxxed = true;
         }
         population[i][j].setVaxType(vaxTypePerson());
         if(canBoost){
           booster = true;
         }
       }
       if(mask){
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
  rect(screenWidth, 0, textWidth, textHeight);
  textSize(18);
  fill(247, 183, 227);
  //user key so that they can input their choices
  text("Do not press a for Pre-Vax mode", screenWidth+20, 60);
  text("Press the b key 1 time for Pfizer", screenWidth+20, 160);
  text("Press the b key 2 times for Johnson+Johnson", screenWidth+20, 200);
  text("Press the b key 3 times for Moderna", screenWidth+20, 240);
  text("Press the b key 4 times for All", screenWidth+20, 280);
  text("Press the c key for Boost mode.", screenWidth+20, 380);
  text("Press the d key for mask mode.", screenWidth+20, 480);
  text("Press the e key to start.", screenWidth+20, 580);
  fill(142, 216, 245);
  if (VAX_MODE == VAX) {
    text("Vax mode on", screenWidth+20, 100);
  } else {
    text("Vax mode off", screenWidth+20, 100);
  }
  if (VAX_TYPE == PFIZER) {
    text("Vaccine mode chosen: Pfizer", screenWidth+20, 320);
  }
  if (VAX_TYPE == MODERNA) {
    text("Vaccine mode chosen: Moderna", screenWidth+20, 320);
  }
  if (VAX_TYPE == JOHNSON) {
    text("Vaccine mode chosen: Johnson", screenWidth+20, 320);
  }
  if (VAX_TYPE == ALL) {
    text("Vaccine mode chosen: All", screenWidth+20, 320);
  }
  if (canBoost) {
    text("Boost mode on", screenWidth+20, 420);
  }
  if (mask) {
    text("Mask mode on", screenWidth+20, 520);
  }
  if (key == 'e') {
    makePop();
    ticks();
  }
  //need to fix percent vaccinated
  text("time:"+time, screenWidth+20, 620);
  text("Total # of Covid Cases: " + covidCasesPop(), screenWidth+20, 660);
  text("Percentage of Population Infected: " + (100 * (float)covidCasesPop() / (population.length * population[0].length)), screenWidth+20, 700);
}

public void spread () {
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
  }
  else if(pep.getCovidStatus().equals("dead")){
    return color(255);
  }
  return color(255);
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
    VAX_MODE = VAX;
  }
  // cycle through vax types with key 'b'
  if (key == 'b') {
    if (VAX_MODE == VAX) {
      VAX_TYPE++;
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

  if (countdown == 0) {
    countdown = 60;
    spread();
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

public void mouseClicked() {
  //will display attributes of person that mouse clicked on
}
