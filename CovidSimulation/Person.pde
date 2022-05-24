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
  
}
