import 'dart:html';

class user
{

  int id = 0;
  String email ='';
  String username = '';
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String locationAddress ='';
  double X_axis = 0;
  double Y_axis = 0;
  bool manager = false;
  user(this.id,this.email, this.username, this.firstName, this.lastName,
      this.phoneNumber, this.locationAddress, this.X_axis, this.Y_axis,this.manager){
      this.email = email;
      this.username =username;
      this.firstName = firstName;
      this.lastName = lastName;
      this.phoneNumber = phoneNumber;
      this.locationAddress = locationAddress;
      this.X_axis =X_axis;
      this.Y_axis = Y_axis;
      this.id = id;
      this.manager = manager;
  }
}