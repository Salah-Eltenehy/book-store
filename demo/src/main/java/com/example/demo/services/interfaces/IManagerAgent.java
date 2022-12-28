package com.example.demo.services.interfaces;

import com.example.demo.model.Book;

public interface IManagerAgent {
    boolean addNewBook(Book newBook);   /// true if a book is added successfully
    boolean modifyBookQuantity(String iSBN, int difference); /// true if the difference in the book quantity is applied successfully
    boolean confirmBookOrder(String iSBN);  /// return true if confirmation done successfully, deletion of order means its acceptance
    boolean promoteUser(String userName);  /// true if the user is promoted successfully
}
