package com.example.demo.controllers;

import com.example.demo.services.SearchAgent;
import com.google.gson.Gson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
    String searchByISBN(String keyword, Integer offset) throws SQLException {
        return new Gson().toJson(searchAgent.searchByISBN(keyword, offset));
    }
    @GetMapping("/title")
    String searchByTitle(String keyword, Integer offset) throws SQLException {
        return new Gson().toJson(searchAgent.searchByTitle(keyword, offset));
    }
    @GetMapping("/category")
    String searchByCategory(String keyword, Integer offset) throws SQLException {
        return new Gson().toJson(searchAgent.searchByCategory(keyword, offset));
    }
    @GetMapping("/publisher")
    String searchByPublisher(String keyword, Integer offset) throws SQLException {
        return new Gson().toJson(searchAgent.searchByPublisher(keyword, offset));
    }
    @GetMapping("/author")
    String searchByAuthor(String keyword, Integer offset) throws SQLException {
        return new Gson().toJson(searchAgent.searchByAuthor(keyword, offset));
    }
    @GetMapping("/all")
    String getAllBooks(Integer offset) throws SQLException {
        return new Gson().toJson(searchAgent.getAllBooks(offset));
    }
}
