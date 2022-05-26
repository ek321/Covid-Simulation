import java.util.*;

int ROWS = 100;
int COLS = 100;
// vax mode variables
final int PRE_VAX = 0;
final int VAX = 1;
int VAX_MODE = 1;
// different vax types
final int PFIEZER = 0;
final int JOHNSON = 1;
final int MODERNA = 2;
final int ALL = 3;
int VAX_TYPE = 1;
// array to keep track of people on the board
Person[][] population;
// for time
int ticks;
// for coloring pixels
int pixelH;
int pixelW;
// for testing purposes
int time;

void setup() {
  size(1000, 1000);
  population = new Person[ROWS][COLS];
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      int age = (int) (Math.random() * (100 - 18 + 1)) + 18;
      boolean vax;
      Random rand = new Random();
      int chance = rand.nextInt(10);
      if(chance > 6){
        vax = false;
      }
      else {
        vax = true;
      }
      //boolean vax = (VAX_MODE == VAX);
      population[i][j] = new Person(age, i, j, vax, vaxTypePerson(), "negative");
    }
  }

  pixelH = height / ROWS;
  pixelW = width / COLS;

  int infectNum = 100;
  Random rng = new Random();
  
  for (int i = 0; i < infectNum; i++) {
    int b = rng.nextInt(ROWS);
    // change later when covidstatus method is done
    population[b][0].covidStatus = "infected";
  }
  
}

void draw() {
  int countdown = 60 * 100;
  spread();
  while (countdown > 0) {
    countdown --;
  }
  time++;
  fill(255);
  text(time, 20, 20);
}

/*public void spread (Person[][] pop) {
  for (int i = 0; i < pop.length; i++) {
    for (int j = 0; j < pop[0].length; j++) {
      color temp = colPer(pop[i][j]);
      // use pixelH and pixelW
      fill (temp);
      rect(j * pixelH, i * pixelW, pixelH, pixelW);
    }
  }

  for (int i = 0; i < pop.length; i++) {
    for (int j = 0; j < pop[0].length; j++) {
      // use pixelH and pixelW
      pop[i][j].setCovidStatus();
    }
  }
}*/

  public void spread () {
    for (int i = 0; i < population.length; i++) {
      for (int j = 0; j < population[0].length; j++) {
        color temp = colPer(population[i][j]);
        // use pixelH and pixelW
        fill (temp);
        rect(j * pixelH, i * pixelW, pixelH, pixelW);
      }
    }
  
    for (int i = 0; i < population.length; i++) {
      for (int j = 0; j < population[0].length; j++) {
        // use pixelH and pixelW
        population[i][j].setCovidStatus();
      }
    }
  }

public color colPer(Person pep) {
  if (pep.getCovidStatus().equals("infected")) {
    return color(252, 158, 69);
  } else if (pep.getCovidStatus().equals("negative")){
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
  if (VAX_TYPE == PFIEZER) {
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
  //idk how we create an "all" vaccine
  //maybe we could add a random thing here like
  /* if(VAX_TYPE == ALL)
   Random rng = new Random();
   int chance = rng.nextInt(3);
   and then we assign the vaccine
   based on the numbers above
   */
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
      VAX_TYPE = PFIEZER;
    }
  }
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

//public void tick() {

//}
