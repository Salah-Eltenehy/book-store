package com.example.demo.controllers.RequestModels;

import lombok.*;
import org.json.JSONException;
import org.json.JSONObject;

import java.sql.Date;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Data
public class BookRequest {
    private String ISBN;
    private String title;
    private String publisher;
    private String publication_year;
    private double price;
    private String category;
    private int stock;
    private int threshold;
    private String image_url;
    private String authors;

    private String address;
    private String telephone_number;

    public BookRequest(String info) throws JSONException {
        JSONObject jsonObject = new JSONObject(info);
        ISBN = jsonObject.getString("ISBN");
        title = jsonObject.getString("title");
        publisher = jsonObject.getString("publisher");
        publication_year = jsonObject.getString("publication_year");
        price = jsonObject.getInt("price");
        category = jsonObject.getString("category");
        stock = jsonObject.getInt("stock");
        threshold = jsonObject.getInt("threshold");
        image_url = jsonObject.getString("image_url");
        authors = jsonObject.getString("authors");
        address = jsonObject.getString("address");
        telephone_number = jsonObject.getString("telephone_number");
    }
}
