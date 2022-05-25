public class Person{
  int age;
  int xCor;
  int yCor;
  boolean vax;
  String covidStatus;
  Vaccine vax_type;
 //to be implemented later: boolean mask;
 // to be implemented later: boolean booster;

  //basic constructor for pre-vax, vax modes
  public Person(int age_,int xCor_, int yCor_,boolean vax_,Vaccine vaxType, String status_){
    age = age_;
    xCor = xCor_;
    yCor = yCor_;
    vax = vax_;
    vax_type = vaxType;
    covidStatus = status_;
  }

  //returns whether or not a person has been vaccinated against COVID-19
  boolean getVaxStatus(){
    return vax;
  }

  //if a person is vaccinated, this will return a string containing the vaccine that they received
  //Possible returns:
  //"Pfizer"
  //"Moderna"
  //"Johnson"
  Vaccine getVaxType(){
    Vaccine res = vax_type;
    boolean possible = getVaxStatus();
    if(possible){
      res = vax_type;
    }
    else {
      return null;
    }
    return res;
  }

 // boolean isElderly(){}

 //returns:
 //"negative"
 //"positive"
 /*Note: we would like to add a feature where someone is recovered after a certain number of days
 in that case, another return string, "recovered" would be added.
 */
 String getCovidStatus(){
   return covidStatus;
 }

 void setCovidStatus(){
   covidStatus = "infected";
 }

 //boolean isBoosted(){}
 boolean catchCovid(int neighbors){
   float temp = calcCovid(neighbors);
   if(temp > 0.5){
     return true;
   }
   return false;
 }

 //helper method for catchCovid
 //returns the chance of catching covid
 float calcCovid(int neighbors){
   float result = 1.0;
   if(getVaxType() != null){
     result *= (1.0 - getVaxType().getEfficacy());
   }
   return result;
 }

}
