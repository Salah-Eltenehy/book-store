package com.example.demo.converters;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.data.util.Pair;

import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CreateCartConverter {
    public String username;
    public int total_cost;
    public String credit_cart_number;
    public String cvv;
    public Date expiry_date;
    public Map<String, Integer> books;

    public CreateCartConverter(String info) throws Exception {
        JSONObject jsonObject = new JSONObject(info);
        username = jsonObject.getString("username");
        total_cost = jsonObject.getInt("total_cost");
        credit_cart_number = jsonObject.getString("credit_cart_number");
        cvv = jsonObject.getString("cvv");
        String date = jsonObject.getString("expiry_date");
        try
        {
            SimpleDateFormat obj = new SimpleDateFormat("MM/dd/yyyy");
            long date1 = obj.parse(date).getTime();
            expiry_date = new Date(date1);
        } catch (Exception e) {
            throw new Exception("In valid date format " + date);
        }
        JSONArray booksJSON = jsonObject.getJSONArray("books");
        books = new HashMap<>();
        for(int i=0 ; !booksJSON.isNull(i) ; i++){
            JSONObject book = booksJSON.getJSONObject(i) ;
            String ISBN = book.getString("ISBN");
            int no_books = book.getInt("no_books");
            books.put(ISBN, no_books) ;
        }

    }

}
