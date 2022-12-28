import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_processing/modules/cart/cubit/CartCubit.dart';
import 'package:order_processing/modules/cart/cubit/CartStates.dart';

class CartScreen extends StatelessWidget {
  int total = 30;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CartCubit()..generateData(total),
      child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cartCubit = CartCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: ListView.separated(
                itemBuilder: (context, index) {
                  return buildCart(
                      book: cartCubit.books[index],
                      delete: () {
                        cartCubit.deleteBook(index);
                      },
                    expansion: (index, isExpanded) {
                        cartCubit.toggleExpansion(index: index, isExpa: isExpanded);
                    },
                    isExpanded: cartCubit.isExpanded[index],
                    expansionIndex: index
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 6, width: double.infinity,),
                itemCount: cartCubit.books.length
            ),
          );
        },
      ),
    );
  }
  Widget buildCart
      (
  {
    required Map<String, dynamic> book,
    required Function delete,
    required Function expansion,
    required bool isExpanded,
    required int expansionIndex
  }
      )
  {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(197, 195, 195, 0.15)
      ),
      child: ExpansionPanelList(
        animationDuration: const Duration(milliseconds: 600),
        expansionCallback: (index, isExpanded) {
          print(expansionIndex);
          expansion(expansionIndex, isExpanded);
        },
        children: [
          ExpansionPanel(
              isExpanded: isExpanded,
              headerBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // required quantity from customer
                    Expanded(
                      flex: 1,
                      child: Text(
                          "${book['reqQuantity']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                      ),
                    ),
                    // book name
                    Expanded(
                      flex: 3,
                      child: Text(
                        "${book['bookName']}",
                        style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body:  Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // author name
                    Text(
                      "Author: ${book['author']}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 6,),
                    // available quantity on the store
                    Text(
                      "Ava Quantity: ${book['avaQuantity']}",
                      style: const TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold
                      ),
                    ),
                    // const SizedBox(height: 6,),
                    const SizedBox(height: 6,),
                    Row(
                      children: [
                        Text(
                          "Date: ${book['date']}",
                          style: const TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            delete();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(248, 31, 31, 0.8)
                            ),
                            child: const Icon(Icons.restore_from_trash_sharp, color: Colors.white,),
                          ),
                        ),
                        const SizedBox(width: 20,),
                      ],
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
