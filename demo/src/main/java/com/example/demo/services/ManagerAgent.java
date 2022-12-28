package com.example.demo.services;

import com.example.demo.model.Book;
import com.example.demo.services.interfaces.IManagerAgent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
@Slf4j
public class ManagerAgent implements IManagerAgent {
    private final DBAgent dbAgent;

    public ManagerAgent() {
        this.dbAgent = DBAgent.getInstance();
    }

    private boolean executeQuery(String query){
        System.out.println(query);
        try {
            int result = this.dbAgent.getStatement().executeUpdate(query);
            return result == 1;
        }catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean addNewBook(Book newBook) {
        if(newBook.getThreshold() < 0 || newBook.getStock() < newBook.getThreshold() || newBook.getPrice() < 0) return false;
        String insertQuery = "INSERT INTO book(ISBN, title, publisher, publication_year, price, category, stock, threshold) " +
                             "VALUES (" + toSQLString(newBook.getISBN()) + ", " + toSQLString(newBook.getTitle()) +  ", " +
                             toSQLString(newBook.getPublisher()) + ", " + toSQLDate(newBook.getPublication_year()) + ", " +
                             newBook.getPrice() + ", " + toSQLString(newBook.getCategory()) + ", " +
                             newBook.getStock() + ", " + newBook.getThreshold() + ");";
        return executeQuery(insertQuery);
    }

    @Override
    public boolean modifyBookQuantity(String iSBN, int quantityDifference) {
        String updateQuery = "UPDATE BOOK " +
                             "SET STOCK = STOCK + " + quantityDifference +
                             " WHERE ISBN = "+ toSQLString(iSBN) + ";";
        return executeQuery(updateQuery);
    }

    @Override
    public boolean confirmBookOrder(String iSBN) {
        String deleteQuery = "DELETE FROM BOOK_ORDER " +
                             "WHERE ISBN = " + toSQLString(iSBN) + ";";
        return executeQuery(deleteQuery);
    }

    @Override
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
