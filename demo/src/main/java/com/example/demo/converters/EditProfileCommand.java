package com.example.demo.converters;

import com.example.demo.model.User;
import org.json.JSONException;
import org.json.JSONObject;

public class EditProfileCommand {
    public String oldUsername;
    public String oldPassword ;

    private String username;
    private String password;
    private String first_name;
    private String last_name;
    private String email;
    private String phone_number;
    private String shipping_address;
    private boolean is_manager;

    //not in json
    public User user ;

    public EditProfileCommand(String jsonInfo) throws JSONException {
        JSONObject jsonObject = new JSONObject(jsonInfo);
        oldUsername = jsonObject.getString("oldUsername") ;
        oldPassword = jsonObject.getString("oldPassword") ;

        username = jsonObject.getString("username") ;
        password = jsonObject.getString("password") ;
        first_name = jsonObject.getString("first_name") ;
        last_name = jsonObject.getString("last_name") ;
        email = jsonObject.getString("email") ;
        phone_number = jsonObject.getString("phone_number") ;
        shipping_address = jsonObject.getString("shipping_address") ;
        is_manager = jsonObject.getBoolean("is_manager") ;

        user = new User(username,password, first_name, last_name, email,phone_number, shipping_address, is_manager) ;
    }

}
