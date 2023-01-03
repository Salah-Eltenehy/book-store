package com.example.demo.services.interfaces;

import com.example.demo.controllers.RequestModels.BookRequest;
import com.example.demo.model.Book;
import com.example.demo.model.BookOrder;

public interface IManagerAgent {
    boolean addNewBook(BookRequest newBookRequest);   /// true if a book is added successfully
    boolean modifyBookQuantity(String iSBN, int difference); /// true if the difference in the book quantity is applied successfully
    boolean confirmBookOrder(String iSBN);  /// return true if confirmation done successfully, deletion of order means its acceptance
    boolean promoteUser(String userName);  /// true if the user is promoted successfully
    // true if the order is placed only when the quantity of a book
    // drops from above a given threshold to below the given threshold
    boolean placeBookOrder(BookOrder bookOrder);
}
