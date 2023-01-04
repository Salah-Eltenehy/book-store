package com.example.demo.converters;

import com.example.demo.model.Author;
import com.example.demo.model.Book;
import com.example.demo.model.BookOrder;
import com.example.demo.services.DBAgent;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class ResultSetToBookOrder {
    private DBAgent dbAgent;

    public ResultSetToBookOrder() {
        this.dbAgent = DBAgent.getInstance();
        System.out.println("--");
    }

    public BookOrder convert(ResultSet resultSet) throws SQLException {
        BookOrder order = new BookOrder();
        order.setISBN(resultSet.getString("ISBN"));
        order.setOrderId(resultSet.getInt("orderId"));
        order.setPublisher(resultSet.getString("publisher"));
        order.setQuantity(resultSet.getInt("quantity"));
        return order;
    }
}
