import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:order_processing/screen/MainApp.dart';

import '../../../Book.dart';
import '../../CardUtils/CardUtils.dart';
import '../CartScreen.dart';
import 'CartStates.dart';
class CartCubit extends Cubit<CartStates> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController ccvController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  double totalPrice  = 0;
  CartCubit() : super(InitialCartStates());

  void initState() {
    cardNumberController.addListener(
          () {
        getCardTypeFrmNumber();
        emit(AddListenerCardState());
      },
    );
  }

  void dispose() {
    cardNumberController.dispose();
    emit(CardDisposeState());
  }

  static CartCubit get(context) => BlocProvider.of(context);

  // generate random data
  // List<Map<String, dynamic>> books = [];
  List<bool> isExpanded = [];

  void calculatePrice() {
    for(Book book in MainApp.cartBooks) {
      double p = book.price ;
      int q = book.quantity ;
      totalPrice = totalPrice + p*q;
    }
    emit(CalculateTotalPriceState());
  }
  void generateData(int total) {
    for (int i = 0; i < total; i++) {
      isExpanded.add(false);
    }
    emit(GenerateRandomDataState());
  }

  void deleteBook(int index) {
    isExpanded[index] = !isExpanded[index];
    totalPrice =totalPrice- MainApp.cartBooks[index].price*MainApp.cartBooks[index].quantity;
    MainApp.cartBooks[index].quantity=0;
    MainApp.cartBooks.removeAt(index);
    MainApp.update();
    emit(RemoveBookState());
  }

  void toggleExpansion
      ({
    required int index,
    required bool isExpa
  }) {
    isExpanded[index] = !isExpa;
    emit(ChangeExpansionState());
  }
  CardType cardType = CardType.Invalid;
  void getCardTypeFrmNumber() {
    if (cardNumberController.text.length <= 6) {
      String input = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType) {
        cardType = type;
        emit(ChangeCardTypeState());
      }
    }
  }

  void increaseOrders
  ({
    required int index
  })
  {
    int ava = MainApp.cartBooks[index].stock ;
    int req = MainApp.cartBooks[index].quantity ;
    if(req >= ava)
      return;
    MainApp.cartBooks[index].quantity = req+1;
    double price = MainApp.cartBooks[index].price;
    totalPrice = totalPrice + price;
    emit(IncreaseOrdersState());
  }

  void decreaseOrders
      ({
    required int index
  })
  {
    int req = MainApp.cartBooks[index].quantity;
    if(req <= 1) {
      deleteBook(index);
      return;
    }
    MainApp.cartBooks[index].quantity = req-1;
    double price = MainApp.cartBooks[index].price;
    totalPrice = totalPrice - price;
    emit(DecreaseOrdersState());
  }

}