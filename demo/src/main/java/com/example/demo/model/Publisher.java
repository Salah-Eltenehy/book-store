package com.example.demo.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Publisher {
    private String name;
    private String address;
    private String telephone_number;

    public Publisher(String name, String address, String telephone_number) {
        this.name = name;
        this.address = address;
        this.telephone_number = telephone_number;
    }
}
