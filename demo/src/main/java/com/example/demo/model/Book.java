package com.example.demo.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;

@Setter
@Getter
@NoArgsConstructor
public class Book {
    private String ISBN;
    private String title;
    private String publisher;
    private Date publication_year;
    private double price;
    private String category;
    private int stock;
    private int threshold;

    public Book(String ISBN, String title, String publisher, Date publication_year, double price, String category, int stock, int threshold)
    {
        this.ISBN = ISBN;
        this.title = title;
        this.publisher = publisher;
        this.publication_year = publication_year;
        this.price = price;
        this.category = category;
        this.stock = stock;
        this.threshold = threshold;
    }
}