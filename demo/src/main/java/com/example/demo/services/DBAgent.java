package com.example.demo.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBAgent
{
    private Connection connection;
    private static DBAgent instance = null;

    public static DBAgent getInstance()
    {
        if (instance == null)
        {
            instance = new DBAgent();
        }
        return instance;
    }
    private DBAgent()
    {
        connect();
    }

    private void connect()
    {
        try
        {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "csed2024");
            System.out.println("db connected");
        }
        catch (SQLException e)
        {
            System.out.println(e.getMessage());
        }
    }
}
