package com.example.demo.converters;

import com.example.demo.model.Author;
import com.example.demo.model.Book;
import com.example.demo.services.DBAgent;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@Component
public class ResultSetToBook {
    private DBAgent dbAgent;

    public ResultSetToBook() {
        this.dbAgent = DBAgent.getInstance();
        System.out.println("--");
    }

    private String getAuthors(String query) throws SQLException
    {
        String res = "";
        ResultSet resultSet = dbAgent.getStatement().executeQuery(query);
        while (resultSet.next())
        {
            res = res.concat(resultSet.getString("author") + ", ");
        }
        resultSet.close();
        return res.substring(0, res.length() - 2);
    }
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
        if(book.getISBN() != null) {
            String ISBN = book.getISBN();
            ISBN = "'".concat(ISBN.concat("'"));
            String query = "SELECT * FROM BookStore.author WHERE ISBN = " + ISBN + " ;";
            book.setAuthor(getAuthors(query));
        }
        else
        {
            book.setAuthor(null);
            System.out.println("!!!!");
        }
        return book;
    }
}
