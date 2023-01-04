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
            if (status) return ResponseEntity.status(HttpStatus.OK).body("Added Successfully");
        }catch (Exception e){
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body(e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body("Failed to Add the Book");
    }

    @GetMapping("/modify/book/{ISBN}/{quantityToAdd}")
    public ResponseEntity<String> modifyBookQuantity(@PathVariable("ISBN") String ISBN, @PathVariable int quantityToAdd){
        try {
            boolean status = this.managerAgent.modifyBookQuantity(ISBN, quantityToAdd);
            if(status) return ResponseEntity.status(HttpStatus.OK).body("Book Quantity modified successfully");
            return ResponseEntity.status(HttpStatus.NOT_MODIFIED).body("Failed to Modify Book Quantity");
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.NOT_MODIFIED).body(e.getMessage());
        }
    }

    @PostMapping("/place/order/book")
    public ResponseEntity<String> placeOrderOnBook(@RequestBody String bookOrder) {
        try {
            boolean status = this.managerAgent.placeBookOrder(new BookOrder(bookOrder));
            if (status)
                return ResponseEntity.status(HttpStatus.OK).body("Order is placed Successfully!");
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.NOT_MODIFIED).body(e.getMessage());
        }

        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).body("Failed to place the order!!");
    }

    @DeleteMapping("/delete/order/{iSBN}")
    public ResponseEntity<String> confirmBookOrder(@PathVariable("iSBN") String iSBN){
        try {
            boolean status = this.managerAgent.confirmBookOrder(iSBN);
            if (status) return ResponseEntity.status(HttpStatus.OK).body("Book order Confirmed Successfully");
            return ResponseEntity.status(422).body("Failed to Confirm the Order");
        }catch (Exception e){
            return ResponseEntity.status(422).body(e.getMessage());

        }

    }

    @PutMapping("/promote/{userName}")
    public ResponseEntity<String> promoteUser(@PathVariable("userName") String userName){
        try {
            boolean status = this.managerAgent.promoteUser(userName);
            if (status) return ResponseEntity.status(HttpStatus.OK).body("User Promoted Successfully");
            return ResponseEntity.status(HttpStatus.NOT_MODIFIED).body("Failed to Promote the User");
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.NOT_MODIFIED).body(e.getMessage());
        }

    }


}
