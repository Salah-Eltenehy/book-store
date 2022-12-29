package com.example.demo.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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
}
