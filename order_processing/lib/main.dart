import 'package:flutter/material.dart';
import 'package:order_processing/modules/orders/Orders.dart';
import 'package:order_processing/modules/cart/CartScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_processing/screen/MainApp.dart';
import 'package:order_processing/screen/login.dart';
import 'package:order_processing/shared/DioHelper.dart';
import 'package:order_processing/shared/network/local/Cachhelper.dart';

import 'Constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await DioHelper.init();
  runApp(MainApp());
}
