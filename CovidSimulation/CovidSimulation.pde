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

void setup(){
  size(1000,1000);
  population = new Person[height / ROWS][width / COLS];
  for (int i = 0; i < population.length; i++) {
    for (int j = 0; j < population[0].length; j++) {
      int age = (int) (Math.random() * (100 - 18 + 1)) + 18;
      boolean vax = (VAX_MODE == VAX);
      population[i][j] = new Person(age, vax, vaxTypePerson(), "hasCovid");
    }
  }
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

//public void tick() {

//}
