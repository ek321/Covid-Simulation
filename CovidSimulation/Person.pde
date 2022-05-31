public class Person{
  int age;
  int xCor;
  int yCor;
  boolean vax;
  String covidStatus;
  Vaccine vax_type;
  boolean mask;
  boolean booster;
  int covidDuration;

  //basic constructor for pre-vax, vax modes
  public Person(int age_,int xCor_, int yCor_,boolean vax_,Vaccine vaxType, String status_, boolean boosted_, boolean mask_){
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
  boolean getVaxStatus(){
    return vax;
  }
  
  //returns whether or not a Person is wearing a mask
  boolean getMaskStatus(){
    return mask;
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

 boolean isElderly(){
   if(age >= 65){
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
 String getCovidStatus(){
   return covidStatus;
 }

 void setCovidStatus(String stat){
   //String prev = covidStatus;
   //covidStatus = prev;
   if (covidStatus.equals("negative")){
     covidStatus = stat;
     covidDuration = 5;
   } else if (covidStatus.equals("infected")) {
     if (covidDuration != 0) {
       covidDuration --;
     }
   }
   
 }

 boolean isBoosted(){
   return booster;
 }

 /*returns true if the chance of catching covid is >50%
 returns false if it is <=50%
 */
 boolean catchCovid(){
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
 float calcCovid(){
   float result = 1.0;
   if(getVaxType() != null){
     result *= (1.0 - getVaxType().getEfficacy());
   }
   result *= neighInfect(this) / 1.5; //percent positive of neighbors
   if(isElderly()){
     result *= 1.5; //increases chance if the person is elderly
   }
   if(getMaskStatus()){
     result *= 0.5;
   }
   return result;
 }

 //returns the x and y coordinates of a Person
 //will be used to count the number of infected neighbors
 int getYCor(){
   return yCor;
 }
 int getXCor(){
   return xCor;
 }

}
