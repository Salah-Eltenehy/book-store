
class user
{

  String email ='';
  String username = '';
  String first_name = '';
  String last_name = '';
  String phone_number = '';
  String  shipping_address ='';
  bool is_manager = false;
  user(this.email, this.username, this.first_name, this.last_name,
      this.phone_number, this. shipping_address, this.is_manager){
      this.email = email;
      this.username =username;
      this.first_name = first_name;
      this.last_name = last_name;
      this.phone_number = phone_number;
      this. shipping_address =  shipping_address;
      this.is_manager = is_manager;
  }
}