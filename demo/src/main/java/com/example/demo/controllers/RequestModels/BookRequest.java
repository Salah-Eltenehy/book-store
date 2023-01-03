package com.example.demo.controllers.RequestModels;

import lombok.*;

import java.sql.Date;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Data
public class BookRequest {
    private String isbn;
    private String title;
    private String publisher;
    private Date publication_year;
    private double price;
    private String category;
    private int stock;
    private int threshold;
    private String image_url;
    private String authors;
}
