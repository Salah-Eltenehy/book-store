package com.example.demo.services;

import com.example.demo.converters.ResultSetToBook;
import com.example.demo.model.Book;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@Service
public class SearchAgent {
    private final ResultSetToBook resultSetToBook;
    private DBAgent dbAgent;
    public SearchAgent(ResultSetToBook resultSetToBook) {
        this.resultSetToBook = resultSetToBook;
        this.dbAgent = DBAgent.getInstance();
    }
    private ArrayList<Book> getBooks(String query) throws SQLException
    {
        ArrayList<Book> books = new ArrayList<>();
        ResultSet resultSet = dbAgent.getStatement().executeQuery(query);
        System.out.println(query);
        while (resultSet.next())
        {
//            System.out.println("resultset");
            books.add(resultSetToBook.convert(resultSet));
//            System.out.println(books.get(books.size() - 1));
        }
        resultSet.close();
        return books;
    }
    public ArrayList<Book> searchByISBN(String ISBN, Integer offset) throws SQLException
    {
        Integer from = ((offset - 1) * 20);
        Integer to = ((offset) * 20);
        ISBN = "'".concat(ISBN.concat("'"));
        String query = "SELECT * FROM BookStore.book WHERE ISBN = " + ISBN +
                " LIMIT " + from + " , " + to +" ;";
        return getBooks(query);
    }
    public ArrayList<Book> searchByTitle(String title, Integer offset) throws SQLException
    {
        Integer from = ((offset - 1) * 20);
        Integer to = ((offset) * 20);
        title = "\"".concat(title.concat("%\""));
        String query = "SELECT * FROM BookStore.book WHERE title like " + title +
                " LIMIT " +  from + " , " + to +" ;";
        return getBooks(query);
    }
    public ArrayList<Book> searchByCategory(String category, Integer offset) throws SQLException
    {
        Integer from = ((offset - 1) * 20);
        Integer to = ((offset) * 20);
        category = "'".concat(category.concat("'"));
        String query = "SELECT * FROM BookStore.book WHERE category = " + category +
                " LIMIT " + from + " , " + to +" ;";
        return getBooks(query);
    }
    public ArrayList<Book> searchByPublisher(String publisher, Integer offset) throws SQLException
    {
        Integer from = ((offset - 1) * 20);
        Integer to = ((offset) * 20);
        publisher = "\"".concat(publisher.concat("%\""));
        String query = "SELECT * FROM BookStore.book WHERE publisher like " + publisher +
                " LIMIT " + from + " , " + to +" ;";
        return getBooks(query);
    }
    public ArrayList<Book> searchByAuthor(String author, Integer offset) throws SQLException
    {
        Integer from = ((offset - 1) * 20);
        Integer to = ((offset) * 20);
        author = "\"".concat(author.concat("%\""));
        String query = "Select * from BookStore.book as b join BookStore.author as a on a.ISBN = b.ISBN where a.author like " + author +
                " LIMIT " + from + " , " + to +" ;";
        return getBooks(query);
    }
    public ArrayList<Book> getAllBooks(Integer offset) throws SQLException
    {
        Integer from = ((offset - 1) * 20);
        Integer to = ((offset) * 20);
        String query = "Select * from BookStore.book LIMIT "+ from + " , " + to +" ;";
        return getBooks(query);
    }
}
