package com.example.demo.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Sale {
    int saleID;
    String userName;
    String iSBN;
    int amount;
    LocalDate saleDate;
    double price;
}
