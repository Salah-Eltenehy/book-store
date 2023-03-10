package com.example.demo.services;

import com.example.demo.model.User;
import org.springframework.stereotype.Service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

@Service
public class LoginSignupService {
    private final DBAgent dbAgent;

    public LoginSignupService() {
        dbAgent = DBAgent.getInstance();
    }


    public User login(String username, String password) throws SQLException, NoSuchAlgorithmException {
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        messageDigest.update(password.getBytes());
        String hashedPassword = new String(messageDigest.digest());

        username = "'".concat(username.concat("'")) ;
        password = "'".concat(hashedPassword.concat("'")) ;
        String query = "SELECT * FROM USER WHERE username = " + username + " AND password = " + password + " ;";
        System.out.println(query);
        ResultSet resultSet = dbAgent.getStatement().executeQuery(query);
        if(resultSet.next())
            return getUser(resultSet);
        else
            return null ;
    }

    public User signup(User user) throws Exception {
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        messageDigest.update(user.getPassword().getBytes());
        String hashedPassword = new String(messageDigest.digest());

        String regex = "^(.+)@(.+)$";
        boolean valid = Pattern.compile(regex).matcher(user.getEmail()).matches();
        if (!valid)
            throw new Exception("invalid");
        
        String insertQuery = "INSERT INTO USER(username, password, first_name, last_name, email, phone_number, shipping_address) " +
                "VALUES (" + toSQLString(user.getUsername()) + ", " + toSQLString(hashedPassword) +  ", " +
                toSQLString(user.getFirst_name()) + ", " + toSQLString(user.getLast_name()) + ", " +
                toSQLString(user.getEmail()) + ", " + toSQLString(user.getPhone_number()) + ", " +
                toSQLString(user.getShipping_address()) +");";
        System.out.println(insertQuery);
        this.dbAgent.getStatement().executeUpdate(insertQuery);

        return user ;

    }

    private User getUser(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setUsername(resultSet.getString("username"));
        user.setPassword(resultSet.getString("password"));
        user.setFirst_name(resultSet.getString("first_name"));
        user.setLast_name(resultSet.getString("last_name"));
        user.setEmail(resultSet.getString("email"));
        user.setPhone_number(resultSet.getString("phone_number"));
        user.setShipping_address(resultSet.getString("shipping_address"));
        user.set_manager(resultSet.getBoolean("is_manager"));
        return user ;

    }
    private String toSQLString(String strAttribute){
        return "\"" + strAttribute + "\"";
    }
}
