package com.example.demo.services;

import com.example.demo.converters.ResultSetToBook;
import com.example.demo.model.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Map;

@Service
@Slf4j
public class CustomerAgent {
    private final DBAgent dbAgent;
    private final LoginSignupService loginSignupService ;
    ResultSetToBook resultSetToBook ;

    public CustomerAgent(LoginSignupService loginSignupService) {
        this.loginSignupService = loginSignupService;
        this.dbAgent = DBAgent.getInstance();
        this.resultSetToBook = new ResultSetToBook() ;
    }

    private boolean executeQuery(String query) throws SQLException {
        System.out.println(query);
        int result = this.dbAgent.getStatement().executeUpdate(query);
        return result != 0;

    }

    public User editProfile(String username, String password, User user) throws Exception {
        User old = loginSignupService.login(username, password) ;
        if(old == null){
            System.out.println("username or the password is incorrect for " + username);
            throw new Exception("username or the password is incorrect for " + username);
        }
        boolean edit = false ;
        String updateQuery = "UPDATE USER SET " ;

        if(!old.getUsername().equals(user.getUsername()) && !user.getUsername().equals("")){
            edit = true ;
            updateQuery = updateQuery + "username = " + toSQLString(user.getUsername()) ;
        }

        if(!password.equals(user.getPassword()) && !user.getPassword().equals("")){
            if(!edit){
                edit = true;
            }else{
                updateQuery = updateQuery + ", ";
            }
            updateQuery = updateQuery + "password = " + toSQLString(user.getPassword()) ;
        }
        if(!old.getFirst_name().equals(user.getFirst_name()) && !user.getFirst_name().equals("")){
            if(!edit){
                edit = true;
            }else{
                updateQuery = updateQuery + ", ";
            }
            updateQuery = updateQuery + "first_name = " + toSQLString(user.getFirst_name()) ;
        }
        if(!old.getLast_name().equals(user.getLast_name()) && !user.getLast_name().equals("")){
            if(!edit){
                edit = true;
            }else{
                updateQuery = updateQuery + ", ";
            }
            updateQuery = updateQuery + "last_name = " + toSQLString(user.getLast_name()) ;
        }
        if(!old.getEmail().equals(user.getEmail()) && !user.getEmail().equals("")){
            if(!edit){
                edit = true;
            }else{
                updateQuery = updateQuery + ", ";
            }
            updateQuery = updateQuery + "email = " + toSQLString(user.getEmail()) ;
        }
        if(!old.getPhone_number().equals(user.getPhone_number()) && !user.getPhone_number().equals("")){
            if(!edit){
                edit = true;
            }else{
                updateQuery = updateQuery + ", ";
            }
            updateQuery = updateQuery + "phone_number = " + toSQLString(user.getPhone_number()) ;
        }
        if(!old.getShipping_address().equals(user.getShipping_address()) && !user.getShipping_address().equals("")){
            if(!edit){
                edit = true;
            }else{
                updateQuery = updateQuery + ", ";
            }
            updateQuery = updateQuery + "shipping_address = " + toSQLString(user.getShipping_address()) ;
        }
        updateQuery = updateQuery + " WHERE username = "+ toSQLString(username) + ";";

        System.out.println(updateQuery);
        if(!edit){
            throw new Exception("user is the same " + username);
        }

        if(executeQuery(updateQuery)){
            return user ;
        }
        return null;
    }


    public ArrayList<Book> createCart(String username, int total_cost, String credit_cart_number, String cvv, Date expiry_date, Map<String, Integer> books) throws Exception {
        username = toSQLString(username) ;
        String query = "SELECT * FROM USER WHERE username = " + username + " ;";
        System.out.println(query);
        ResultSet resultSet = dbAgent.getStatement().executeQuery(query);
        if(!resultSet.next())
            throw new Exception("username don't exist");

        ArrayList<Book> booksArray = new ArrayList<>() ;
        for(String ISBN: books.keySet()){
            query = "SELECT * FROM BOOK WHERE ISBN = " + toSQLString(ISBN) + " ;";
            System.out.println(query);
            resultSet = dbAgent.getStatement().executeQuery(query);
            if(!resultSet.next())
                throw new Exception(ISBN + " do not exist");
            Book book = resultSetToBook.convert(resultSet);
            if(book.getStock()< books.get(ISBN)){
                throw new Exception("for book " + ISBN + " Stock is " + book.getStock() + " and order is " +books.get(ISBN));
            }
            booksArray.add(book) ;

        }



        String insertQuery = "INSERT INTO CART(username, total_price, purchased_date, credit_cart_number, cvv, expiry_date) " +
                "VALUES (" + toSQLString(username) + ", " + total_cost +  ", " + toSQLDate(Date.valueOf(LocalDate.now()))+ ", " +
                toSQLString(credit_cart_number) + toSQLString(cvv) +  ", " + toSQLDate(expiry_date) + ");";
        System.out.println(insertQuery);
        if(this.dbAgent.getStatement().executeUpdate(insertQuery)== 0){
            throw new Exception("could not add cart");
        }

        query = "SELECT * FROM CART WHERE username = " + username + " ORDER BY cart_id DESC ;";
        System.out.println(query);
        resultSet = dbAgent.getStatement().executeQuery(query);
        if(!resultSet.next())
            throw new Exception("error");

        Cart cart = getCart(resultSet) ;
        for(String ISBN: books.keySet()){
            insertQuery = "INSERT INTO cart_book(cart_id, ISBN, no_books) " +
                    "VALUES (" + cart.getCart_id() + ", " + toSQLString(ISBN) +  ", " + books.get(ISBN) + ");";
            System.out.println(insertQuery);
            if(this.dbAgent.getStatement().executeUpdate(insertQuery)== 0){
                throw new Exception("could not add book");
            }
        }
        return booksArray;

    }


    private Cart getCart(ResultSet resultSet) throws SQLException {
        Cart cart = new Cart();
        cart.setUsername(resultSet.getString("username"));
        cart.setCart_id(resultSet.getInt("cart_id"));
        cart.setTotal_price(resultSet.getInt("total_price"));
        String state = resultSet.getString("state") ;
        if(state.equals("not purchased"))
            cart.setState(CartState.NOT_PURCHASED);
        else
            cart.setState(CartState.PURCHASED);


        return cart ;

    }

    private String toSQLDate(Date dateAttribute){
        return "date'" + dateAttribute + "'";
    }

    private String toSQLString(String strAttribute){
        return "\"" + strAttribute + "\"";
    }

}
