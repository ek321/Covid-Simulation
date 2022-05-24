public class Vaccine{
  String type;
  float efficacy;
  
  /* Constructor for the Vaccine class
  */
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
  */
  //"Pfizer"
  //"Moderna"
  //"Johnson"
  String getType(){
    return type;
  }
  
  /* returns a decimal value of the efficacy that a given vaccine has against COVID-19
  */
  float getEfficacy(){
    return efficacy;
  }
  
  //float setEfficacy(){}
}
