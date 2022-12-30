import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_processing/modules/orders/cubit/OrdersStates.dart';
class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit(): super(InitialOrdersState());

  static OrdersCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic> book = {
    "bookName": "Salah Ahmed",
    "publisher": "Bla Bla Bla",
    "quantity": 20
  };

}