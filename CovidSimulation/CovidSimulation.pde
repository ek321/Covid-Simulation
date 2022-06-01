import java.util.*;

int ROWS = 10;
int COLS = 10;
// vax mode variables
final int PRE_VAX = 0;
final int VAX = 1;
int VAX_MODE = 0;
// different vax types
final int PFIZER = 0;
final int JOHNSON = 1;
final int MODERNA = 2;
final int ALL = 3;
int VAX_TYPE = 1;
// array to keep track of people on the board
Person[][] population;
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

void setup() {
  size(1600, 1600);
  background(0);
  population = new Person[ROWS][COLS];
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      int age = (int) (Math.random() * (100 - 18 + 1)) + 18;
      boolean vax;
      Random rand = new Random();
      int chance = rand.nextInt(10);
      if (chance > 6) {
        vax = false;
      } else {
        vax = true;
      }
      //boolean vax = (VAX_MODE == VAX);
      boolean booster = false;
      if (canBoost) {
        booster = true;
      }
      population[i][j] = new Person(age, i, j, vax, vaxTypePerson(), "negative", booster, true);
    }
  }

  pixelH = screenHeight / ROWS;
  pixelW = screenWidth / COLS;

  Random rng = new Random();

  for (int i = 0; i < ROWS; i++) {
    int b = rng.nextInt(30);
    // change later when covidstatus method is done
    if (b < 13) {
      population[i][0].setCovidStatus();
    }
  }
}

void draw() {
  fill(89,44,138);
  rect(screenWidth, 0, textWidth, textHeight);
  textSize(18);
  fill(247,183,227);
  text("Press the a key for Vax mode.",screenWidth+20,20);
  text("Do not press a for Pre-Vax mode",screenWidth+20,60);
  text("Press the b key 1 time for Pfizer",screenWidth+20,100);
  text("Press the b key 2 times for Johnson+Johnson",screenWidth+20,140);
  text("Press the b key 3 times for Moderna",screenWidth+20,180);
  text("Press the b key 4 times for All",screenWidth+20,220);
  text("Press the c key for Boost mode.",screenWidth+20,260);
  text("Press the d key to start.",screenWidth+20,300);
 if(key == 'd'){
    ticks();
  }
}

public void spread () {
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      color temp = colPer(population[i][j]);
      // use pixelH and pixelW
      fill (temp);
      rect(j * pixelH, i * pixelW, pixelH, pixelW);
    }
  }
}

public void setNext() {
  for (int i = 0; i < population[0].length; i++) {
    for (int j = 0; j < population.length; j++) {
      // use pixelH and pixelW
      population[j][i].catchCovid();
      if (i == population.length / 2) {
        if (population[j][i].isBoosted()) {
          population[j][i].getVaxType().boost();
        }
      }
      if (population[j][i].getVaxStatus()) {
        population[j][i].getVaxType().setEfficacy();
      }
    }
  }
}



public color colPer(Person pep) {
  if (pep.getCovidStatus().equals("infected")) {
    return color(252, 158, 69);
  } else if (pep.getCovidStatus().equals("negative")) {
    return color(69, 119, 252);
  }
  return color(0, 0, 0);
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
    ans = new Vaccine("MODERNA");
  }

  if (temp) {
    VAX_TYPE = ALL;
  }

  return ans;
}

void keyPressed () {
  // circle through vax mode with key 'a'
  if (key == 'a') {
    if (VAX_MODE < VAX) {
      VAX_MODE ++;
    } else {
      VAX_MODE = PRE_VAX;
    }
  }

  // cycle through vax types with key 'b'
  if (key == 'b') {
    if (VAX_TYPE < ALL) {
      VAX_TYPE ++;
    } else {
      VAX_TYPE = PFIZER;
    }
  }

  //adds booster shot in after a while
  if (key == 'c') {
    if (VAX_MODE == VAX) {
      canBoost = true;
    }
  }
 /* if(key == 'd'){
    ticks();
  }*/
}

public int neighInfect(Person pep) {
  int counter = 0;
  Person temp;
  // check for out of bounds on left
  if (pep.getXCor() != 0) {
    temp = population[pep.getXCor() - 1][pep.getYCor()];
    if (temp.getCovidStatus().equals("infected")) {
      counter ++;
    }
  }

  // check for out of bounds on right
  if (pep.getXCor() != population[0].length - 1) {
    temp = population[pep.getXCor() + 1][pep.getYCor()];
    if (temp.getCovidStatus().equals("infected")) {
      counter ++;
    }
  }

  // check for out of bounds on top
  if (pep.getYCor() != 0) {
    temp = population[pep.getXCor()][pep.getYCor() - 1];
    if (temp.getCovidStatus().equals("infected")) {
      counter ++;
    }
  }

  // check for out of bounds on bottom
  if (pep.getYCor() != population.length - 1) {
    temp = population[pep.getXCor()][pep.getYCor() + 1];
    if (temp.getCovidStatus().equals("infected")) {
      counter ++;
    }
  }

  return counter;
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
    text(time, 20, 20);
    text("Total # of Covid Cases: " + covidCasesPop(), 20, 40);
    text("Percentage of People Vaccinated: " + vaxStatusPop(), 20, 60);
    setNext();
  }
}

public int covidCasesPop() {
  int counter = 0;
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      if (population[i][j].getCovidStatus().equals("infected")) {
        counter++;
      }
    }
  }
  return counter;
}

public float vaxStatusPop() {
  float counter = 0;
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      if (population[i][j].getVaxStatus()) {
        counter ++;
      }
    }
  }
  counter = counter / (population.length * population[0].length);
  return Math.round(counter * 100.0) / 100.0;
}
