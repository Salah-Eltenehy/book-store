package com.example.demo.controllers;


import com.example.demo.converters.CreateCartConverter;
import com.example.demo.converters.EditProfileCommand;
import com.example.demo.converters.LoginConverter;
import com.example.demo.model.User;
import com.example.demo.services.CustomerAgent;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin()
@RequestMapping("/bookstore/customer")
public class CustomerController {

    @Autowired
    private final CustomerAgent customerAgent;

    public CustomerController(CustomerAgent customerAgent) {
        this.customerAgent = customerAgent;
    }

    @PostMapping("/editProfile")
    public ResponseEntity<String> editProfile(@RequestBody String info){
        try {
            EditProfileCommand command = new EditProfileCommand(info) ;
            boolean state = customerAgent.editProfile(command.oldUsername, command.oldPassword, command.user);
            if (state)
                return new ResponseEntity<>("Success", HttpStatus.OK) ;
        }catch (Exception e){
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND) ;
        }
        return new ResponseEntity<>("Failed", HttpStatus.NOT_MODIFIED) ;

    }

    @PostMapping("/addCart")
    public ResponseEntity<String> addCart(@RequestBody String info){
        try {
            CreateCartConverter command = new CreateCartConverter(info) ;
            boolean state = customerAgent.createCart(command.username, command.total_cost, command.credit_cart_number,
                    command.cvv, command.expiry_date, command.books);
            if (state)
                return new ResponseEntity<>("Success", HttpStatus.OK) ;
        }catch (Exception e){
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND) ;
        }
        return new ResponseEntity<>("Failed", HttpStatus.NOT_MODIFIED) ;

    }

}
