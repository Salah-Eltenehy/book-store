import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_processing/modules/orders/cubit/OrdersStates.dart';
import 'package:order_processing/screen/MainApp.dart';
import 'package:order_processing/shared/DioHelper.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit(): super(InitialOrdersState());

  static OrdersCubit get(context) => BlocProvider.of(context);

  void getOrdersFromBackEnd() {
    DioHelper.getData(
      url: '/bookstore/manager/allOrders'
    ).then((value) {
      // TODO: confilct between front end and back end
    });
  }


}