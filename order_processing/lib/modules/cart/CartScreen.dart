import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_processing/modules/cart/cubit/CartCubit.dart';
import 'package:order_processing/modules/cart/cubit/CartStates.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:order_processing/screen/MainApp.dart';
import 'package:order_processing/shared/components/Components.dart';

import '../../Book.dart';
import '../CardUtils/CardMonthInputFormatter.dart';
import '../CardUtils/CardNumberInputFormatter.dart';
import '../CardUtils/CardUtils.dart';
import 'package:order_processing/shared/DioHelper.dart';
import 'package:http/http.dart' as http;
import '../Constants.dart';

class CartScreen extends StatelessWidget {
  int total = 5;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var kPrimaryColor = Color(0XFFBA68C8);
  var kBackgroundColor = Color(0XFFE5E5E5);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CartCubit()
        ..generateData(MainApp.cartBooks.length)
        ..initState()
        ..calculatePrice(),
      child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cartCubit = CartCubit.get(context);
          return Scaffold(
            // backgroundColor: Color(0XFFBA68C8),
            key: scaffoldKey,
            persistentFooterButtons: [
              Container(
                // color: Color(0XFFBA68C8),
                width: double.infinity,
                height: 40,
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0XFFBA68C8),
                      ),
                      padding: const EdgeInsets.only(right: 16, left: 10),
                      child: Center(
                        child: Text("Total: ${cartCubit.totalPrice}"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          scaffoldKey.currentState?.showBottomSheet(
                            (context) => Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(
                                20.0,
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      validator: (value) {
                                        // return CardUtils.validateCardNum(
                                        //     cartCubit
                                        //         .cardNumberController.text);
                                      },
                                      controller:
                                          cartCubit.cardNumberController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(16),
                                        CardNumberInputFormatter(),
                                      ],
                                      decoration: InputDecoration(
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0XFFBA68C8)),
                                          ),
                                          suffix: CardUtils.getCardIcon(
                                              cartCubit.cardType),
                                          hintText: "Card number"),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      cursorColor: const Color(0XFFBA68C8),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: TextFormField(
                                        controller: cartCubit.nameController,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        cursorColor: const Color(0XFFBA68C8),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field is required";
                                          }
                                        },
                                        decoration: const InputDecoration(
                                          hintText: "Full name",
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0XFFBA68C8)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            cursorColor:
                                                const Color(0XFFBA68C8),
                                            controller: cartCubit.ccvController,
                                            validator: (value) {
                                              return CardUtils.validateCVV(
                                                  cartCubit.ccvController.text);
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              // Limit the input
                                              LengthLimitingTextInputFormatter(
                                                  4),
                                            ],
                                            decoration: const InputDecoration(
                                              hintText: "CVV",
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFFBA68C8)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: TextFormField(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            cursorColor:
                                                const Color(0XFFBA68C8),
                                            keyboardType: TextInputType.number,
                                            controller:
                                                cartCubit.expDateController,
                                            validator: (value) {
                                              return CardUtils.validateDate(
                                                  cartCubit
                                                      .expDateController.text);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  4),
                                              CardMonthInputFormatter(),
                                            ],
                                            decoration: const InputDecoration(
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0XFFBA68C8)),
                                                ),
                                                hintText: "MM/YY"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // const Spacer(flex: 2),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0XFFBA68C8),
                                            foregroundColor: Colors.black),
                                        child: const Text("Submit"),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cartCubit.createBooksForBackEnd();
                                            String _url =
                                                "http://${ip}:8080/bookstore/customer/addCart";
                                            var res = await http.post(Uri.parse(_url),
                                                headers: {"Content-Type": "application/json"},
                                                body: json.encode({
                                                  "username": cartCubit.nameController.text,
                                                  "total_cost": cartCubit.totalPrice,
                                                  "credit_cart_number": cartCubit.cardNumberController.text,
                                                  "cvv": cartCubit.ccvController.text,
                                                  "expiry_date": cartCubit.expDateController.text,
                                                  "books": cartCubit.booksForBackEnd
                                                }));
                                            if (res.statusCode!=200) {
                                              print("Error ya sa7by fe el credit card");

                                            } else {
                                              print("Response from backend when add card credit");
                                              print(res.body);
                                            }
                                            // DioHelper.postData(
                                            //   url:'bookstore/customer/addCart',
                                            //   data: {
                                            //
                                            //   }
                                            // ).then((value) {
                                            //   print(value.data);
                                            // }).catchError((error) {
                                            // });
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 20.0,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0XFFBA68C8),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Center(
                            child: Text(
                              "Check Out",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            body: ListView.separated(
                itemBuilder: (context, index) {
                  return buildCart(
                      increaseFunction: (index) {
                        cartCubit.increaseOrders(index: index);
                      },
                      decreaseFunction: (index) {
                        cartCubit.decreaseOrders(index: index);
                      },
                      book: MainApp.cartBooks[index],
                      delete: () {
                        cartCubit.deleteBook(index);
                      },
                      expansion: (index, isExpanded) {
                        cartCubit.toggleExpansion(
                            index: index, isExpa: isExpanded);
                      },
                      isExpanded: cartCubit.isExpanded[index],
                      expansionIndex: index);
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 6,
                      width: double.infinity,
                    ),
                itemCount: MainApp.cartBooks.length),
          );
        },
      ),
    );
  }

  Widget buildCart({
    required Book book,
    required Function delete,
    required Function expansion,
    required bool isExpanded,
    required int expansionIndex,
    required Function increaseFunction,
    required Function decreaseFunction,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 16,top: 10, right: 16),
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
                    // required quantity from customer
                    Text(
                      "Quantity: ${book.quantity}",
                      style: const TextStyle(color: Colors.black),
                    ),
                    Text(
                      "Price: ${book.price} EGP",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: InkWell(
                        onTap: () {
                          increaseFunction(expansionIndex);
                        },
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(
                                  255, 122, 249, 0.8)),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        decreaseFunction(expansionIndex);
                      },
                      child: Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                            const Color.fromRGBO(255, 122, 249, 0.8)),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // delete order
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: InkWell(
                  onTap: () {
                    delete();
                  },
                  child: Container(
                    height: 50,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(173, 0, 158, 0.8)),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
