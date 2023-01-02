package com.example.demo.converters;

import com.example.demo.model.Book;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;
@Component
public class ResultSetToBook {
    public Book convert(ResultSet resultSet) throws SQLException
    {
        Book book = new Book();
        book.setISBN(resultSet.getString("ISBN"));
        book.setTitle(resultSet.getString("title"));
        book.setPublisher(resultSet.getString("publisher"));
        book.setPublication_year(resultSet.getDate("publication_year"));
        book.setPrice(resultSet.getDouble("price"));
        book.setCategory(resultSet.getString("category"));
        book.setStock(resultSet.getInt("stock"));
        book.setThreshold(resultSet.getInt("threshold"));
        book.setImage_url(resultSet.getString("image_url"));
        return book;
    }
}
