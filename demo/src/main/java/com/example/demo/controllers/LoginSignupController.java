package com.example.demo.controllers;


import com.example.demo.converters.LoginConverter;
import com.example.demo.model.Book;
import com.example.demo.model.User;
import com.example.demo.services.LoginSignupService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin()
@RequestMapping("/bookstore")
public class LoginSignupController {

    @Autowired
    private final LoginSignupService service ;

    public LoginSignupController(LoginSignupService service) {
        this.service = service;
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody String info){
        try {
            LoginConverter converter = new LoginConverter(info) ;
            User user = service.login(converter.username, converter.password);
            return new ResponseEntity<>(new Gson().toJson(user), HttpStatus.OK) ;
        }catch (Exception e){
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND) ;
        }
    }

    @PostMapping("/signup")
    public ResponseEntity<String> signup(@RequestBody String info){
        try {
            User user = new User(info) ;
            user = service.signup(user);
            return new ResponseEntity<>(new Gson().toJson(user), HttpStatus.OK) ;
        }catch (Exception e){
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND) ;
        }
    }
}
