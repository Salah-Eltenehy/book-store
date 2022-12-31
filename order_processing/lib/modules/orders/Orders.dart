import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_processing/modules/orders/cubit/OrdersCubit.dart';
import 'package:order_processing/modules/orders/cubit/OrdersStates.dart';
import 'package:order_processing/screen/MainApp.dart';

import '../../Book.dart';

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
                              book: MainApp.orderBooks[index],
                              decline: () {
                                print("Decline function");
                              },
                              accept: () {
                                print("Accept function");
                              }
                          );
                        },
                        separatorBuilder: (context, index) => Container(height: 4, width: double.infinity,),
                        itemCount: MainApp.orderBooks.length
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
    required Book book,
    required Function decline,
    required Function accept
  }
      )
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: const Color.fromRGBO(225, 93, 250, 0.14901960784313725)
      ),
      child: Container(
        // padding: const EdgeInsets.all(16),
        height: 100,
        decoration: BoxDecoration(
          color :const Color.fromRGBO(193, 0, 243, 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        // color: const Color.fromRGBO(199, 27, 234, 0.14901960784313725),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image(
                // image: NetworkImage("https://th.bing.com/th/id/R.2436bfd57f8da9d3352be6d9c69f7d0d?rik=Meg7Z25SYT8yaA&pid=ImgRaw&r=0"),
                image: NetworkImage(book.photoUrl),
                fit: BoxFit.cover,
                width: 70,
                height: double.infinity,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // book name
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 6),
                    child: Text(
                      book.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ),
                  Text(
                    "Publisher: ${book.publisher}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Quantity: ${book.orderedquantity}",
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            /*
             Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.red,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.report,),
                          color: Colors.white,
                          onPressed: () =>
                              PenaltyHTTPsHandler.report(
                                  KickoffApplication.playerId,
                                  showPartyPlayers.partyPlayers[index].pid,
                                  true),),
            */
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Ink(
                width: 40,
                height: 40,
                decoration: const ShapeDecoration(
                  color: Colors.red,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.clear,),
                  color: Colors.white,
                  onPressed: () =>decline(),
                ),
              ),
            ),
            // delete order
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Ink(
                width: 40,
                height: 40,
                decoration: const ShapeDecoration(
                  color: Colors.green,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.check,),
                  color: Colors.white,
                  onPressed: () =>accept(),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   padding: const EdgeInsets.all(20),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     color:  Color.fromRGBO(210, 55, 210, 0.14901960784313725)
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         "${book['bookName']}",
    //         style: const TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 30,
    //           color: Colors.black
    //         ),
    //       ),
    //       const SizedBox(height: 6,),
    //       Text(
    //         "${book['publisher']}",
    //         style: const TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 25,
    //             color: Colors.black54
    //         ),
    //       ),
    //       const SizedBox(height: 6,),
    //       Text(
    //         "Quantity: ${book['quantity']}",
    //         style: const TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 25,
    //             color: Colors.black54
    //         ),
    //       ),
    //       const SizedBox(height: 6,),
    //       Row(
    //         children: [
    //           Expanded(
    //             child: Container(
    //               decoration:  BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 color: const Color.fromRGBO(250, 24, 24, 0.8),
    //
    //               ),
    //               child: TextButton(
    //                   onPressed: () {
    //                     decline();
    //                   },
    //                   child:
    //                   const Text(
    //                     "Decline",
    //                     style: TextStyle(
    //                       color: Colors.white
    //                     ),
    //                   ),
    //               ),
    //             ),
    //           ),
    //           const SizedBox(width: 6,),
    //           Expanded(
    //             child: Container(
    //               decoration:  BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 // color: const Color.fromRGBO(21, 17, 17, 0.5019607843137255),
    //                 color: Colors.green
    //               ),
    //               child: TextButton(
    //                 onPressed: () {
    //                   accept();
    //                 },
    //                 child:
    //                 const Text(
    //                   "Accept",
    //                   style: TextStyle(
    //                       color: Colors.white
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
