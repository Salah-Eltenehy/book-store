package com.example.demo.controllers;

import com.example.demo.model.Book;
import com.example.demo.services.SearchAgent;
import com.google.gson.Gson;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Controller
@CrossOrigin
@RequestMapping("/search")
public class SearchController {
    private final SearchAgent searchAgent;

    public SearchController(SearchAgent searchAgent) {
        this.searchAgent = searchAgent;
//        System.out.println(searchAgent.dbAgent);
    }
    @GetMapping("/isbn/{keyword}/{offset}")
    ResponseEntity<String> searchByISBN(@PathVariable String keyword, @PathVariable Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.searchByISBN(keyword, offset)), HttpStatus.OK);
    }
    @GetMapping("/title/{keyword}/{offset}")
    ResponseEntity<String> searchByTitle(@PathVariable String keyword, @PathVariable Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.searchByTitle(keyword, offset)), HttpStatus.OK);
    }
    @GetMapping("/category/{keyword}/{offset}")
    ResponseEntity<String> searchByCategory(@PathVariable String keyword, @PathVariable Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.searchByCategory(keyword, offset)), HttpStatus.OK);
    }
    @GetMapping("/publisher/{keyword}/{offset}")
    ResponseEntity<String> searchByPublisher(@PathVariable String keyword, @PathVariable Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.searchByPublisher(keyword, offset)), HttpStatus.OK);
    }
    @GetMapping("/author/{keyword}/{offset}")
    ResponseEntity<String> searchByAuthor(@PathVariable String keyword, @PathVariable Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.searchByAuthor(keyword, offset)), HttpStatus.OK);
    }
    @GetMapping("/all/{offset}")
    ResponseEntity<String> getAllBooks(@PathVariable Integer offset) throws SQLException {
//        System.out.println("all");
        List<Book> books = searchAgent.getAllBooks(offset);
        System.out.println(books.toString());
        ResponseEntity<String> response = new ResponseEntity<>(new Gson().toJson(books), HttpStatus.OK);
        return response ;
    }
}
