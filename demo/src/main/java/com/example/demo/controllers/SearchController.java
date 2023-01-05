package com.example.demo.controllers;

import com.example.demo.services.SearchAgent;
import com.google.gson.Gson;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.SQLException;

@Controller
@CrossOrigin
@RequestMapping("/search")
public class SearchController {
    private final SearchAgent searchAgent;

    public SearchController(SearchAgent searchAgent) {
        this.searchAgent = searchAgent;
//        System.out.println(searchAgent.dbAgent);
    }
    @GetMapping("/isbn")
    ResponseEntity<String> searchByISBN(@RequestParam String keyword, @RequestParam Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.searchByISBN(keyword, offset)), HttpStatus.OK);
    }
    @GetMapping("/title")
    ResponseEntity<String> searchByTitle(@RequestParam String keyword, @RequestParam Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.searchByTitle(keyword, offset)), HttpStatus.OK);
    }
    @GetMapping("/category")
    ResponseEntity<String> searchByCategory(@RequestParam String keyword, @RequestParam Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.searchByCategory(keyword, offset)), HttpStatus.OK);
    }
    @GetMapping("/publisher")
    ResponseEntity<String> searchByPublisher(@RequestParam String keyword, @RequestParam Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.searchByPublisher(keyword, offset)), HttpStatus.OK);
    }
    @GetMapping("/author")
    ResponseEntity<String> searchByAuthor(@RequestParam String keyword, @RequestParam Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.searchByAuthor(keyword, offset)), HttpStatus.OK);
    }
    @GetMapping("/all")
    ResponseEntity<String> getAllBooks(@RequestParam Integer offset) throws SQLException {
        return new ResponseEntity<>(new Gson().toJson(searchAgent.getAllBooks(offset)), HttpStatus.OK);
    }
}
