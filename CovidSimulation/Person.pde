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

  //basic constructor for pre-vax, vax modes
  public Person(int age_, int xCor_, int yCor_, boolean vax_, Vaccine vaxType, String status_, boolean boosted_, boolean mask_) {
    age = age_;
    xCor = xCor_;
    yCor = yCor_;
    vax = vax_;
    vax_type = vaxType;
    covidStatus = status_;
    booster = boosted_;
    mask = mask_;
    covidDuration = 5;
  }

  //returns whether or not a person has been vaccinated against COVID-19
  public boolean getVaxStatus() {
    return vax;
  }

  //returns whether or not a Person is wearing a mask
  public boolean getMaskStatus() {
    return mask;
  }

  //if a person is vaccinated, this will return a string containing the vaccine that they received
  //Possible returns:
  //"Pfizer"
  //"Moderna"
  //"Johnson"
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

  boolean isElderly() {
    if (age >= 65) {
      return true;
    }
    return false;
  }

  //returns:
  //"negative"
  //"infected"
  /*Note: we would like to add a feature where someone is recovered after a certain number of days
   in that case, another return string, "recovered" would be added.
   */
  public String getCovidStatus() {
    return covidStatus;
  }

  public void setCovidStatus(String stat) {
    //String prev = covidStatus;
    //covidStatus = prev;
    if (covidStatus.equals("negative")) {
      covidStatus = stat;
      covidDuration = 5;
    } else if (covidStatus.equals("infected")) {
      if (covidDuration != 1) {
        covidDuration --;
      } else if (covidDuration == 1) {
        covidDuration = 5;
        covidStatus = "recovery";
      }
    } else if (covidStatus.equals("recovery")) {
      if (recoveryDuration != 1) {
        recoveryDuration --;
      } else if (recoveryDuration == 1) {
        Random rng = new Random();
        int chance = rng.nextInt(5);
        if(chance != 0){
          recoveryDuration = 0;
          covidStatus = "dead";
        }
        recoveryDuration = 5;
        covidStatus = "negative";
      }
    }
  }

  public boolean isBoosted() {
    return booster;
  }

  /*returns true if the chance of catching covid is >50%
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

  //helper method for catchCovid
  //returns the chance of catching covid for one Person
  //takes into account vaccine status, type, and number of infected neighbors
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

  //returns the x and y coordinates of a Person
  //will be used to count the number of infected neighbors
  public int getYCor() {
    return yCor;
  }
  public int getXCor() {
    return xCor;
  }
}
