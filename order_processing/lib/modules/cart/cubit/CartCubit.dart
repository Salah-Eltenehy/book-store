import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_validator/credit_card_validator.dart';

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
  List<Map<String, dynamic>> books = [];
  List<bool> isExpanded = [];

  void calculatePrice() {
    for(Map<String, dynamic> book in books) {
      double p = book['unitPrice'] as double;
      int q = book['reqQuantity'] as int;
      totalPrice = totalPrice + p*q;
    }
    emit(CalculateTotalPriceState());
  }
  void generateData(int total) {
    for (int i = 0; i < total; i++) {
      Map<String, dynamic> temp = {
        "reqQuantity": i + 5,
        "bookName": "Book Name",
        "author": "Salah  Ahmed",
        "avaQuantity": i * 10 + 3,
        "date": DateTime.now(),
        "unitPrice": i*5+20.0
      };
      books.add(temp);
      isExpanded.add(false);
    }
    emit(GenerateRandomDataState());
  }

  void deleteBook(int index) {
    isExpanded[index] = !isExpanded[index];
    books.removeAt(index);
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
    int ava = books[index]['avaQuantity'] as int;
    int req = books[index]['reqQuantity'] as int;
    if(req >= ava)
      return;
    books[index]['reqQuantity'] = req+1;
    double price = books[index]['unitPrice'] as double;
    totalPrice = totalPrice + price;
    emit(IncreaseOrdersState());
  }

  void decreaseOrders
      ({
    required int index
  })
  {
    int req = books[index]['reqQuantity'] as int;
    if(req <= 1) {
      deleteBook(index);
      return;
    }
    books[index]['reqQuantity'] = req-1;
    double price = books[index]['unitPrice'] as double;
    totalPrice = totalPrice - price;
    emit(DecreaseOrdersState());
  }

}