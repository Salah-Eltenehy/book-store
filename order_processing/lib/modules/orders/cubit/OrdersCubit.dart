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

  void getOrdersFromBackEnd() {
    String _url =
        "http://${ip}:8080/bookstore/manager/allOrders";
    var res = await http.post(Uri.parse(_url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({})
    );
    if (res.statusCode!=200) {
      print("Error ya sa7by fe el credit card");
      print(res.body);
    } else {
      // TODO: confilct between front end and back end
      print("Response from backend when add card credit");
      print(res.body);
    }
    // DioHelper.getData(
    //   url: '/bookstore/manager/allOrders'
    // ).then((value) {
    //
    // });
  }


}