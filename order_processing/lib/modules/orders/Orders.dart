import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_processing/modules/orders/cubit/OrdersCubit.dart';
import 'package:order_processing/modules/orders/cubit/OrdersStates.dart';

class OrdersScreen extends StatelessWidget {
  int total = 50;
  var kPrimaryColor = Color(0XFFBA68C8);
  var kBackgroundColor = Color(0XFFE5E5E5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => OrdersCubit(),
        child: BlocConsumer<OrdersCubit, OrdersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var ordersCubit = OrdersCubit.get(context);
            return  Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return buildBook(
                              book: ordersCubit.book,
                              decline: () {
                                print("Decline function");
                              },
                              accept: () {
                                print("Accept function");
                              }
                          );
                        },
                        separatorBuilder: (context, index) => Container(height: 4, width: double.infinity,),
                        itemCount: total
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
  Widget buildBook(
  {
    required Map<String, dynamic> book,
    required Function decline,
    required Function accept
  }
      )
  {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:  Color.fromRGBO(210, 55, 210, 0.14901960784313725)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${book['bookName']}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black
            ),
          ),
          const SizedBox(height: 6,),
          Text(
            "${book['publisher']}",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black54
            ),
          ),
          const SizedBox(height: 6,),
          Text(
            "Quantity: ${book['quantity']}",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black54
            ),
          ),
          const SizedBox(height: 6,),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(250, 24, 24, 0.8),

                  ),
                  child: TextButton(
                      onPressed: () {
                        decline();
                      },
                      child:
                      const Text(
                        "Decline",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                  ),
                ),
              ),
              const SizedBox(width: 6,),
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: const Color.fromRGBO(21, 17, 17, 0.5019607843137255),
                    color: Colors.green
                  ),
                  child: TextButton(
                    onPressed: () {
                      accept();
                    },
                    child:
                    const Text(
                      "Accept",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
