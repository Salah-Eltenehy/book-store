package com.example.demo.services;

import com.example.demo.controllers.RequestModels.BookRequest;
import com.example.demo.converters.ResultSetToBook;
import com.example.demo.converters.ResultSetToBookOrder;
import com.example.demo.model.Book;
import com.example.demo.model.BookOrder;
import com.example.demo.model.BookOrderFront;
import com.example.demo.services.interfaces.IManagerAgent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@Service
@Slf4j
public class ManagerAgent implements IManagerAgent {
    private final DBAgent dbAgent;
    ResultSetToBook resultSetToBook;

    ResultSetToBookOrder resultSetToBookOrder;

    private  final SearchAgent searchAgent;

    public ManagerAgent(SearchAgent searchAgent) {
        this.searchAgent = searchAgent;
        this.dbAgent = DBAgent.getInstance();
        resultSetToBook = new ResultSetToBook();
        resultSetToBookOrder = new ResultSetToBookOrder();
    }

    private boolean executeQuery(String query) throws Exception {
        System.out.println(query);
        try {
            int result = this.dbAgent.getStatement().executeUpdate(query);
            return result != 0;
        }catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
            throw new Exception(e.getMessage()) ;
        }
    }

    private ResultSet select(String sql) throws SQLException {
        return dbAgent.getStatement().executeQuery(sql);
    }

    @Override
    public boolean addNewBook(BookRequest newBookRequest) throws Exception {
        System.out.println(newBookRequest.toString());
        String getBook =  "SELECT * FROM BOOK WHERE ISBN = " + toSQLString(newBookRequest.getISBN())  + " ;";
        ResultSet book = select(getBook) ;
        if (book.next()){
            throw new Exception(newBookRequest.getISBN() + " ISBN is already exist!");
        }

        String getPublisher =  "SELECT * FROM publisher WHERE name = " + toSQLString(newBookRequest.getPublisher())  + " ;";
        ResultSet publisher = select(getPublisher) ;
        if (!publisher.next()){
            String insertPublisher = "INSERT INTO publisher(name, address, telephone_number) " +
                    "VALUES (" + toSQLString(newBookRequest.getPublisher()) + ", " + toSQLString(newBookRequest.getAddress()) +  ", " +
                    toSQLString(newBookRequest.getTelephone_number())  +");";
            if(!executeQuery(insertPublisher))
                throw new Exception("could not insert publisher");
        }

        Book newBook = new Book(newBookRequest.getISBN(), newBookRequest.getTitle(), newBookRequest.getPublisher(),
                                Date.valueOf(LocalDate.of(Integer.parseInt(newBookRequest.getPublication_year()),1,1)) ,
                                newBookRequest.getPrice(), newBookRequest.getCategory(), newBookRequest.getStock(),
                                newBookRequest.getThreshold(), newBookRequest.getImage_url());
        if(newBook.getThreshold() < 0 || newBook.getStock() < newBook.getThreshold() || newBook.getPrice() < 0) return false;
        String insertQuery = "INSERT INTO book(ISBN, title, publisher, publication_year, price, category, stock, threshold, image_url) " +
                             "VALUES (" + toSQLString(newBook.getISBN()) + ", " + toSQLString(newBook.getTitle()) +  ", " +
                             toSQLString(newBook.getPublisher()) + ", " + toSQLDate(newBook.getPublication_year()) + ", " +
                             newBook.getPrice() + ", " + toSQLString(newBook.getCategory().toString()) + ", " +
                             newBook.getStock() + ", " + newBook.getThreshold() + ", " + toSQLString(newBook.getImage_url()) +");";

        return executeQuery(insertQuery) && insertAuthors(newBookRequest.getAuthors(), newBook.getISBN());
    }
    private boolean insertAuthors(String authorString, String ISBN) throws Exception {
        String[] authors = authorString.split(", ");
        String insertAuthorsQuery;
        boolean result = true;
        for (String author : authors) {
            insertAuthorsQuery = "INSERT INTO AUTHOR(ISBN, author) " +
                    "VALUES(" + toSQLString(ISBN) + ", " + toSQLString(author) + ");";
            result = executeQuery(insertAuthorsQuery) && result;
        }
        return result;
    }
    @Override
    public boolean modifyBookQuantity(String iSBN, int quantityDifference) throws Exception {
        String updateQuery = "UPDATE BOOK " +
                             "SET STOCK = " + quantityDifference +
                             " WHERE ISBN = "+ toSQLString(iSBN) + ";";
        return executeQuery(updateQuery);
    }

    @Override
    public boolean placeBookOrder(BookOrder bookOrder) throws Exception {
        String getBook =  "SELECT * FROM BOOK WHERE ISBN = " + toSQLString(bookOrder.getISBN())  + " ;";
        ResultSet book = select(getBook) ;
        if (!book.next()){
            throw new Exception("Book do not exist " + bookOrder.getISBN());
        }
        Book book1 = resultSetToBook.convert(book) ;

        String query = "INSERT INTO BOOK_ORDER(ISBN, quantity, publisher) VALUES " +
                "(" +
                toSQLString(bookOrder.getISBN()) + ", " +
                bookOrder.getQuantity() + ", " +
                toSQLString(book1.getPublisher())
                + ");";
        return executeQuery(query);
    }

    @Override
    public List<BookOrderFront> getAllOrders() throws Exception {
        String query = "SELECT * FROM Book_Order;";
        ArrayList<BookOrderFront> orders = new ArrayList<>();
        ResultSet resultSet = dbAgent.getStatement().executeQuery(query);
        System.out.println(query);
        while (resultSet.next()) {
            BookOrder bookOrder=resultSetToBookOrder.convert(resultSet);
            Book book=  searchAgent.findByISBN(bookOrder.getISBN());
            BookOrderFront bookOrderFront= BookOrderFront.builder().orderId(bookOrder.getOrderId())
                    .author(book.getAuthor()).image_url(book.getImage_url()).category(book.getCategory().toString())
                    .ISBN(book.getISBN()).price(book.getPrice()).publication_year(book.getPublication_year())
                    .quantity(bookOrder.getQuantity()).publisher(book.getPublisher()).threshold(book.getThreshold())
                    .stock(book.getStock()).title(book.getTitle()).build();
            orders.add(bookOrderFront);
        }
        resultSet.close();
        return orders;
    }

    @Override
    public boolean confirmBookOrder(String iSBN) throws Exception {
        String deleteQuery = "DELETE FROM BOOK_ORDER " +
                             "WHERE ISBN = " + toSQLString(iSBN) + ";";
        return executeQuery(deleteQuery);
    }

    @Override
    public boolean promoteUser(String userName) throws Exception {
        String promoteUserQuery = "UPDATE USER " +
                                  "SET IS_MANAGER = 1 " +
                                  "WHERE USERNAME = " + toSQLString(userName) + ";";
        return executeQuery(promoteUserQuery);
    }

    private String toSQLString(String strAttribute){
        return "\"" + strAttribute + "\"";
    }    private String toSQLDate(Date dateAttribute){
        return "date'" + dateAttribute + "'";
    }

}
