package com.example.demo.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
public class Author {
    private String ISBN;
    private String author;

    public Author(String ISBN, String author) {
        this.ISBN = ISBN;
        this.author = author;
    }
}
