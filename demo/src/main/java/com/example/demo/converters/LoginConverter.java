package com.example.demo.converters;


import org.json.JSONException;
import org.json.JSONObject;

public class LoginConverter {
    public String username;
    public String password ;

    public LoginConverter(String json) throws JSONException {
        JSONObject jsonObject = new JSONObject(json);
        username = jsonObject.getString("username") ;
        password = jsonObject.getString("password") ;
    }
}
