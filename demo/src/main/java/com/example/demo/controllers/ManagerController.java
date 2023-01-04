package com.example.demo.controllers;

import com.example.demo.controllers.RequestModels.BookRequest;
import com.example.demo.model.Book;
import com.example.demo.model.BookOrder;
import com.example.demo.services.interfaces.IManagerAgent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin()
@RequestMapping("/bookstore/manager")
public class ManagerController {
    @Autowired
//    @Resource(name = "ManagerAgent")
    private IManagerAgent managerAgent;

    @PostMapping("/add/book")
    public ResponseEntity<String> addNewBook(@RequestBody String newBookRequest){ //
//        System.out.println(s);
//        return ResponseEntity.status(HttpStatus.CREATED).body("Added Successfully");
        try {
            BookRequest book = new BookRequest(newBookRequest);
            boolean status = this.managerAgent.addNewBook(book);
            if (status) return ResponseEntity.status(HttpStatus.CREATED).body("Added Successfully");
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body(e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body("Failed to Add the Book");
    }

    @PutMapping("/modify/book/{iSBN}")
    public ResponseEntity<String> modifyBookQuantity(@PathVariable("iSBN") String iSBN, @RequestBody int quantityToAdd){
        boolean status = this.managerAgent.modifyBookQuantity(iSBN, quantityToAdd);
        if(status) return ResponseEntity.status(HttpStatus.OK).body("Book Quantity modified successfully");
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).body("Failed to Modify Book Quantity");
    }
    @PostMapping("/place/order/book")
    public ResponseEntity<String> placeOrderOnBook(@RequestBody BookOrder bookOrder) {
        boolean status = this.managerAgent.placeBookOrder(bookOrder);
        if (status)
            return ResponseEntity.status(HttpStatus.OK).body("Order is placed Successfully!");
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).body("Failed to place the order!!");
    }

    @DeleteMapping("/delete/order/{iSBN}")
    public ResponseEntity<String> confirmBookOrder(@PathVariable("iSBN") String iSBN){
        boolean status = this.managerAgent.confirmBookOrder(iSBN);
        if (status) return ResponseEntity.status(HttpStatus.OK).body("Book order Confirmed Successfully");
        return ResponseEntity.status(422).body("Failed to Confirm the Order");
    }

    @PutMapping("/promote/{userName}")
    public ResponseEntity<String> promoteUser(@PathVariable("userName") String userName){
        boolean status = this.managerAgent.promoteUser(userName);
        if (status) return ResponseEntity.status(HttpStatus.OK).body("User Promoted Successfully");
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).body("Failed to Promote the User");
    }


}
