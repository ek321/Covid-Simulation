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
  Person[][] POPULATION;
  
void setup(){
  size(1000,1000);
  POPULATION = new Person[height / ROWS][width / COLS];
  
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
