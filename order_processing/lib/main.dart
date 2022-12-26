import 'package:flutter/material.dart';
import 'package:order_processing/modules/orders/Orders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Processing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrdersScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
