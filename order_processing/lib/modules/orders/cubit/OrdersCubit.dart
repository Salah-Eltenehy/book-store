import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_processing/modules/orders/cubit/OrdersStates.dart';
import 'package:order_processing/screen/MainApp.dart';
import 'package:order_processing/shared/DioHelper.dart';
import 'package:order_processing/modules/orders/cubit/OrdersCubit.dart';
import 'package:http/http.dart' as http;
import 'package:order_processing/Constants.dart';
import 'dart:convert';

import '../../../Book.dart';

class OrdersCubit extends Cubit<OrdersStates> {



  OrdersCubit(): super(InitialOrdersState());

  static OrdersCubit get(context) => BlocProvider.of(context);


  void deleteOrder(int index) {
    MainApp.orderBooks.removeAt(index);
    MainApp.update();
    emit(DeleteOrderSuccessState());
  }
}