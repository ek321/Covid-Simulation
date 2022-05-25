  int ROWS = 100;
  int COLS = 100;
  // vax mode variables
  final int PRE_VAX = 0;
  final int VAX = 1;
  int VAX_MODE = 0;
  // different vax types
  final int PFIEZER = 0;
  final int JOHNSON = 1;
  final int MODERNA = 2;
  final int ALL = 3;
  int VAX_TYPE = 0;
  // array to keep track of people on the board
  Person[][] population;
  // for time
  int ticks;
  // for coloring pixels
  int pixelH;
  int pixelW;

void setup(){
  size(1000,1000);
  population = new Person[ROWS][COLS];
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      int age = (int) (Math.random() * (100 - 18 + 1)) + 18;
      boolean vax = (VAX_MODE == VAX);
      population[i][j] = new Person(age, i, j, vax, vaxTypePerson(), "negative");
    }
  }
  
  pixelH = height / ROWS;
  pixelW = width / COLS;
  
  int infectNum = 5;
  for (int i = 0; i < infectNum; i++) {
    int a = (int) (Math.random() * (ROWS));
    int b = (int) (Math.random() * (COLS));
    population[a][b].setCovidStatus();
  }
}

void draw() {
  int countdown = 60 * 5;
  spread(population);
  while (countdown != 0) {
    countdown --;
  }
  
}

public void spread (Person[][] pop) {
  for (int i = 0; i < pop.length; i++) {
    for (int j = 0; j < pop[0].length; j++) {
      color temp = colPer(pop[i][j]);
      // use pixelH and pixelW
      fill (temp);
      rect(j * pop[0].length, i * pop.length,  pop[0].length, pop.length);
    }
  }
}

public color colPer(Person pep) {
  if (pep.getCovidStatus().equals("infected")) {
    return color(252, 158, 69);
  } else {
    return color(69, 119, 252);
  }
  // return color(0, 0, 0);
}

public Vaccine vaxTypePerson(){
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
  } else if (VAX_TYPE == MODERNA){
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
    if (VAX_MODE < VAX){
      VAX_MODE ++;
    } else {
      VAX_MODE = PRE_VAX;
    }
  }

  // cycle through vax types with key 'b'
  if (key == 'b') {
    if (VAX_TYPE < ALL){
      VAX_TYPE ++;
    } else {
      VAX_TYPE = PFIEZER;
    }
  }
}

public int neighInfect(Person pep) {
  int counter = 0;
  Person temp = population[pep.getXCor() - 1][pep.getYCor()];
  if (temp.getCovidStatus().equals("infected")){
    counter ++;
  }
  temp = population[pep.getXCor() + 1][pep.getYCor()];
  if (temp.getCovidStatus().equals("infected")){
    counter ++;
  }
  temp = population[pep.getXCor()][pep.getYCor() - 1];
  if (temp.getCovidStatus().equals("infected")){
    counter ++;
  }
  temp = population[pep.getXCor()][pep.getYCor() + 1];
  if (temp.getCovidStatus().equals("infected")){
    counter ++;
  }
  
  return counter;
}

//public void tick() {

//}
