public class Vaccine{
  String type;
  float efficacy;

  // Constructor for the Vaccine class
  public Vaccine(String type_){
    type = type_;
    if(type.equals("Pfizer")){
      efficacy = 0.945;
    }
    else if(type.equals("Moderna")){
      efficacy = 0.959;
    }
    else if(type.equals("Johnson")){
      efficacy = 0.748;
    }
  }

  /* returns a string of the vaccine name
    - "Pfizer"
    - "Moderna"
    - "Johnson"
  */
  String getType(){
    return type;
  }

  // returns a decimal value of the efficacy that a given vaccine has against COVID-19
  float getEfficacy(){
    return efficacy;
  }
  
  // sets the efficacy of the vaccine based on the type
  void setEfficacy(){
    if(getType().equals("Pfizer")){
      efficacy -= 0.00131037 * 100;
    }
    else if(getType().equals("Johnson")){
      efficacy -= 0.00073268 * 100;
    }
    else if(getType().equals("Moderna")){
      efficacy -= 0.0010126 * 100;
    }
  }
  
  // increases efficacy of vaccines based on type
  void boost(){
    if(type.equals("Pfizer")){
      efficacy = 0.945;
    }
    else if(type.equals("Moderna")){
      efficacy = 0.959;
    }
    else if(type.equals("Johnson")){
      efficacy = 0.748;
    }
  }
  
  // returns the type of vaccine
  String toString() {
    return type;
  }
}
