package com.example.demo.services;

import com.example.demo.model.Book;
import com.example.demo.model.BookOrder;
import com.example.demo.model.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.Date;

@Service
@Slf4j
public class CustomerAgent {
    private final DBAgent dbAgent;
    private final LoginSignupService loginSignupService ;

    public CustomerAgent(LoginSignupService loginSignupService) {
        this.loginSignupService = loginSignupService;
        this.dbAgent = DBAgent.getInstance();
    }

    private boolean executeQuery(String query){
        System.out.println(query);
        try {
            int result = this.dbAgent.getStatement().executeUpdate(query);
            return result != 0;
        }catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean editProfile(String username, String password, User user) throws SQLException {
        User old = loginSignupService.login(username, password) ;
        if(old == null){
            System.out.println("username or the password is incorrect for " + username);
            return false ;
        }
        String updateQuery = "UPDATE USER SET password = " + toSQLString(user.getPassword())  ;
        if(!old.getUsername().equals(user.getUsername())){
            updateQuery = updateQuery + ", username = " + toSQLString(user.getUsername()) ;
        }
        if(!old.getFirst_name().equals(user.getFirst_name())){
            updateQuery = updateQuery + ", first_name = " + toSQLString(user.getFirst_name()) ;
        }
        if(!old.getLast_name().equals(user.getLast_name())){
            updateQuery = updateQuery + ", last_name = " + toSQLString(user.getLast_name()) ;
        }
        if(!old.getEmail().equals(user.getEmail())){
            updateQuery = updateQuery + ", email = " + toSQLString(user.getEmail()) ;
        }
        if(!old.getPhone_number().equals(user.getPhone_number())){
            updateQuery = updateQuery + ", phone_number = " + toSQLString(user.getPhone_number()) ;
        }
        if(!old.getShipping_address().equals(user.getShipping_address())){
            updateQuery = updateQuery + ", shipping_address = " + toSQLString(user.getShipping_address()) ;
        }
        updateQuery = updateQuery + " WHERE username = "+ toSQLString(username) + ";";

        System.out.println(updateQuery);

        return executeQuery(updateQuery);
    }




    public boolean addNewBook(Book newBook) {
        if(newBook.getThreshold() < 0 || newBook.getStock() < newBook.getThreshold() || newBook.getPrice() < 0) return false;
        String insertQuery = "INSERT INTO book(ISBN, title, publisher, publication_year, price, category, stock, threshold) " +
                "VALUES (" + toSQLString(newBook.getISBN()) + ", " + toSQLString(newBook.getTitle()) +  ", " +
                toSQLString(newBook.getPublisher()) + ", " + toSQLDate(newBook.getPublication_year()) + ", " +
                newBook.getPrice() + ", " + toSQLString(newBook.getCategory()) + ", " +
                newBook.getStock() + ", " + newBook.getThreshold() + ");";
        return executeQuery(insertQuery);
    }



    public boolean placeBookOrder(BookOrder bookOrder) {
        String query = "INSERT INTO BOOK_ORDER(ISBN, quantity, publisher) VALUES " +
                "(" +
                toSQLString(bookOrder.getISBN()) + ", " +
                bookOrder.getQuantity() + ", " +
                toSQLString(bookOrder.getPublisher())
                + ");";
        return executeQuery(query);
    }

    public boolean confirmBookOrder(String iSBN) {
        String deleteQuery = "DELETE FROM BOOK_ORDER " +
                "WHERE ISBN = " + toSQLString(iSBN) + ";";
        return executeQuery(deleteQuery);
    }

    public boolean promoteUser(String userName) {
        String promoteUserQuery = "UPDATE USER " +
                "SET IS_MANGER = 1 " +
                "WHERE USERNAME = " + toSQLString(userName) + ";";
        return executeQuery(promoteUserQuery);
    }

    private String toSQLString(String strAttribute){
        return "'" + strAttribute + "'";
    }
    private String toSQLDate(Date dateAttribute){
        return "date'" + dateAttribute + "'";
    }

}
