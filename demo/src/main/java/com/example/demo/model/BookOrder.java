package com.example.demo.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.concurrent.Flow;

@Setter
@Getter
@NoArgsConstructor
public class BookOrder
{
    private int orderId;
    private String ISBN;
    private int quantity;
    private String publisher;

    public BookOrder(int orderId, String ISBN, int quantity, String publisher) {
        this.orderId = orderId;
        this.ISBN = ISBN;
        this.quantity = quantity;
        this.publisher = publisher;
    }

    public BookOrder(String json) throws JSONException {
        JSONObject jsonObject = new JSONObject(json);
        ISBN = jsonObject.getString("ISBN") ;
        quantity = jsonObject.getInt("quantity") ;
    }
}
