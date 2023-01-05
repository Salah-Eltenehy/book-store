import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_processing/modules/orders/cubit/OrdersStates.dart';
import 'package:order_processing/screen/MainApp.dart';
import 'package:order_processing/shared/DioHelper.dart';
import 'package:http/http.dart' as http;
import 'package:order_processing/Constants.dart';
import 'dart:convert';
class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit(): super(InitialOrdersState());

  static OrdersCubit get(context) => BlocProvider.of(context);

  Future<void> getOrdersFromBackEnd() async {
    String _url = "http://${ip}:8080/bookstore/manager/allOrders";
    var res = await http.get(Uri.parse(_url),
        headers: {"Content-Type": "application/json"},
    );
    if (res.statusCode!=200) {
      print("Error ya sa7by fe el all orders");
      print(res.body);
    } else {
      // TODO: conflict between front end and back end
      print("Response from backend when get all orders");
      print(res.body);
    }
  }
  void deleteOrder(int index) {
    MainApp.orderBooks.removeAt(index);
    emit(DeleteOrderSuccessState());
  }
}