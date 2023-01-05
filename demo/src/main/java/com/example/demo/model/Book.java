package com.example.demo.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class Book {
    private String ISBN;
    private String title;
    private String publisher;
    private Date publication_year;
    private double price;
    private Category category;
    private int stock;
    private int threshold;
    private String image_url;
    private String author;

    public Book(String ISBN, String title, String publisher, Date publication_year, double price,
                String category, int stock, int threshold, String image_url)
    {
        this.ISBN = ISBN;
        this.title = title;
        this.publisher = publisher;
        this.publication_year = publication_year;
        this.price = price;
        this.category = Category.valueOf(category);
        this.stock = stock;
        this.threshold = threshold;
        this.image_url = image_url;
    }

    public void setCategory(String category) {
        this.category = Category.valueOf(category);
    }
}
