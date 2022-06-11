public class Person {
  int age;
  int xCor;
  int yCor;
  boolean vax;
  String covidStatus;
  Vaccine vax_type;
  boolean mask;
  boolean booster;
  int covidDuration = 5;
  int recoveryDuration = 5;

  /* Section 1 *********************************
    *basic constructor for pre-vax, vax modes
  */
  public Person(int age_, int xCor_, int yCor_, String status_) {
    age = age_;
    xCor = xCor_;
    yCor = yCor_;
    vax = false;
    vax_type = null;
    covidStatus = status_;
    booster = false;
    mask = false;
    covidDuration = 5;
  }

  
  /* Section 2 *********************************
    *calculating/setting covid status of a person
  */
  
  /* returns:
    "negative"
    "infected"
    "recovered"
  */
  public String getCovidStatus() {
    return covidStatus;
  }

  // sets the covid status of the person
  public void setCovidStatus(String stat) {
    if (covidStatus.equals("negative")) {
      covidStatus = stat;
      covidDuration = 5;
    } else if (covidStatus.equals("infected")) {
      if (covidDuration != 1) {
        covidDuration --;
      } else if (covidDuration == 1) {
        Random rand = new Random();
        int chance = rand.nextInt(10);
        if(chance < 2&& isElderly()){
          covidStatus = "dead";
          recoveryDuration = 0;
        }
        else if(chance < 1){
           covidStatus = "dead";
          recoveryDuration = 0;
        }
        else {
          covidDuration = 5;
          covidStatus = "recovery";
        }
      }
    } else if (covidStatus.equals("recovery")) {
      if (recoveryDuration != 1) {
        recoveryDuration --;
      } else if (recoveryDuration == 1) {
        recoveryDuration = 5;
        covidStatus = "negative";
      }
    }
  }
  
  /* returns true if the chance of catching covid is >50%
    returns false if it is <=50%
  */
  boolean catchCovid() {
    double temp = calcCovid();
    Random rng = new Random();
    double chance = rng.nextInt(3);
    if (chance < temp) {
      setCovidStatus("infected");
      return true;
    } else {
      setCovidStatus("negative");
      return false;
    }
  }

  /* helper method for catchCovid
    returns the chance of catching covid for one Person
    takes into account vaccine status, type, and number of infected neighbors
  */
  public float calcCovid() {

    float result = 1.0;
    if (getVaxType() != null) {
      result *= (1.0 - getVaxType().getEfficacy());
    }
    result *= neighInfect(this) / 1.5; //percent positive of neighbors
    if (isElderly()) {
      result *= 1.5; //increases chance if the person is elderly
    }
    if (getMaskStatus()) {
      result *= 0.5;
    }
    return result;
  }
  
  
  /* Section 3 *********************************
    *get/set methods for person attributes
  */
  
  /*if a person is vaccinated, this will return a string containing the vaccine that they received
    Possible returns:
    - "Pfizer"
    - "Moderna"
    - "Johnson"
  */
  public Vaccine getVaxType() {
    Vaccine res = vax_type;
    boolean possible = getVaxStatus();
    if (possible) {
      res = vax_type;
    } else {
      return null;
    }
    return res;
  }

  public void setVaxType(Vaccine res){
    vax_type = res;
  }

  // returns whether the person is considered elderly
  public boolean isElderly() {
    if (age >= 65) {
      return true;
    }
    return false;
  }
  
  // returns whether or not a person has been vaccinated against COVID-19
  public boolean getVaxStatus() {
    return vax;
  }
  
  // sets the vax status of the person
  public void setVaxStatus(boolean temp){
    vax = temp;
  }
  
  // returns whether the person is boosted or not
  public boolean isBoosted() {
    return booster;
  }
  
  public void boosterShot(boolean res){
    booster = res;
  }

  // returns whether or not a Person is wearing a mask
  public boolean getMaskStatus() {
    return mask;
  }
  
  // sets the mask status of the person
  public void setMaskStatus(boolean temp){
    mask = temp;
  }

  // returns the x and y coordinates of a Person
  // will be used to count the number of infected neighbors
  public int getYCor() {
    return yCor;
  }
  public int getXCor() {
    return xCor;
  }
  
  // returns the age of the person
  public int getAge() {
    return age;
  }
}
