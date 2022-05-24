public class Person{
  int age;
  boolean vax;
  String covidStatus;
  String vax_type;
 //to be implemented later: boolean mask;
 // to be implemented later: boolean booster;
  
  //basic constructor for pre-vax, vax modes
  public Person(int age_,boolean vax_,String vaxType, String status_){
    age = age_;
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
  String getVaxType(){
    String res = "";
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
 
 //String setCovidStatus(){}
 //boolean isBoosted(){}
 //boolean catchCovid(){}
  
}