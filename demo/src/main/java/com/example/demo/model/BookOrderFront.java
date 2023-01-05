package com.example.demo.model;

import lombok.*;

import java.sql.Date;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class BookOrderFront {
    private int orderId;
    private String ISBN;
    private int quantity;
    private String publisher;
    private String title;
    private Date publication_year;
    private double price;
    private String category;
    private int stock;
    private int threshold;
    private String image_url;
    private String author;


}
