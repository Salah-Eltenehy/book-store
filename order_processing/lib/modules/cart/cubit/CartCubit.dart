import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_validator/credit_card_validator.dart';

import '../CartScreen.dart';
import 'CartStates.dart';
class CartCubit extends Cubit<CartStates> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController ccvController = TextEditingController();
  TextEditingController expDateController = TextEditingController();

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

  void generateData(int total) {
    for (int i = 0; i < total; i++) {
      Map<String, dynamic> temp = {
        "reqQuantity": i + 5,
        "bookName": "Book Name",
        "author": "Salah  Ahmed",
        "avaQuantity": i * 10 + 3,
        "date": DateTime.now(),
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

}