package com.example.demo.controllers.RequestModels;

import com.example.demo.model.Book;
import lombok.*;
import java.sql.Date;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class SearchBook {
    private String ISBN;
    private String title;
    private String publisher;
    private int publication_year;
    private double price;
    private String category;
    private int stock;
    private int threshold;
    private String image_url;
    private String author;

    public SearchBook(Book book) {
        if (book == null){
            return;
        }

        this.ISBN = book.getISBN();
        this.title = book.getTitle();
        this.publisher = book.getPublisher();
        this.publication_year = book.getPublication_year().toLocalDate().getYear() ;
        this.price = book.getPrice();
        this.category = book.getCategory().toString();
        this.stock = book.getStock();
        this.threshold = book.getThreshold();
        this.image_url = book.getImage_url();
    }
}
