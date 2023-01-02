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
        while (resultSet.next())
        {
            books.add(resultSetToBook.convert(resultSet));
        }
        resultSet.close();
        return books;
    }
    public ArrayList<Book> searchByISBN(String ISBN, Integer offset) throws SQLException
    {
        ISBN = "'".concat(ISBN.concat("%'"));
        String query = "SELECT * FROM book WHERE ISBN = " + ISBN + " LIMIT 20 OFFSET "+ ((offset - 1) * 20) + " ;";
        return getBooks(query);
    }
    public ArrayList<Book> searchByTitle(String title, Integer offset) throws SQLException
    {
        title = "'%".concat(title.concat("%'"));
        String query = "SELECT * FROM book WHERE title like " + title + " LIMIT 20 OFFSET "+ ((offset - 1) * 20) + " ;";
        return getBooks(query);
    }
    public ArrayList<Book> searchByCategory(String category, Integer offset) throws SQLException
    {
        category = "'%".concat(category.concat("%'"));
        String query = "SELECT * FROM book WHERE category like " + category + " LIMIT 20 OFFSET " + offset + " ;";
        return getBooks(query);
    }
    public ArrayList<Book> searchByPublisher(String publisher, Integer offset) throws SQLException
    {
        publisher = "'%".concat(publisher.concat("%'"));
        String query = "SELECT * FROM book WHERE publisher like " + publisher + " LIMIT 20 OFFSET " + offset + " ;";
        return getBooks(query);
    }
    public ArrayList<Book> searchByAuthor(String author, Integer offset) throws SQLException
    {
        author = "'%".concat(author.concat("%'"));
        String query = "Select * from book as b join author as a on a.ISBN = b.ISBN where a.author like " + author + " LIMIT 20 OFFSET " + offset + " ;";
        return getBooks(query);
    }
    public ArrayList<Book> getAllBooks(Integer offset) throws SQLException
    {
        String query = "Select * from book LIMIT 20 OFFSET "+ offset + " ;";
        return getBooks(query);
    }
}
