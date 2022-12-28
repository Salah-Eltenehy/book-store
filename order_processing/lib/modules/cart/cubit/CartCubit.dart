import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'CartStates.dart';
class CartCubit extends Cubit<CartStates> {

  CartCubit(): super(InitialCartStates());

  static CartCubit get(context) => BlocProvider.of(context);
  // generate random data
  List<Map<String, dynamic>> books = [];
  List<bool> isExpanded = [];
  void generateData(int total) {
    for (int i=0; i < total; i++) {
     Map<String, dynamic> temp = {
       "reqQuantity": i+5,
       "bookName": "Book Name",
       "author": "Salah  Ahmed",
       "avaQuantity": i*10+3,
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
  (
    {
      required int index,
      required bool isExpa
    }
  )
  {
    isExpanded[index] = !isExpa;
    emit(ChangeExpansionState());
  }


}