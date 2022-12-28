import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_processing/modules/cart/cubit/CartCubit.dart';
import 'package:order_processing/modules/cart/cubit/CartStates.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:order_processing/shared/components/Components.dart';
class CartScreen extends StatelessWidget {
  int total = 30;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var kPrimaryColor = Color(0XFFBA68C8);
  var kBackgroundColor = Color(0XFFE5E5E5);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CartCubit()..generateData(total)..initState()..calculatePrice(),
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
                        child: Text(
                          "Total: ${cartCubit.totalPrice}"
                        ),
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

                                       validator: (value){
                                         return  CardUtils.validateCardNum(cartCubit.cardNumberController.text);
                                       },
                                       controller: cartCubit.cardNumberController,
                                       keyboardType: TextInputType.number,
                                       inputFormatters: [
                                         FilteringTextInputFormatter.digitsOnly,
                                         LengthLimitingTextInputFormatter(16),
                                         CardNumberInputFormatter(),
                                       ],
                                       decoration: InputDecoration(
                                           focusedBorder: const UnderlineInputBorder(
                                             borderSide: BorderSide(color: Color(0XFFBA68C8)),
                                           ),
                                           suffix: CardUtils.getCardIcon(cartCubit.cardType),
                                           hintText: "Card number"
                                       ),
                                       style: const TextStyle(
                                         color: Colors.black
                                       ),
                                        cursorColor: const Color(0XFFBA68C8),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.symmetric(vertical: 16),
                                       child: TextFormField(
                                         style: const TextStyle(
                                             color: Colors.black
                                         ),
                                         cursorColor: const Color(0XFFBA68C8),
                                         validator: (value) {
                                           if(value!.isEmpty) {
                                             return "This field is required";
                                           }
                                         },
                                         decoration: const InputDecoration(
                                             hintText: "Full name",
                                             focusedBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(color: Color(0XFFBA68C8)),
                                             ),
                                         ),
                                       ),
                                     ),
                                     Row(
                                       children: [
                                         Expanded(
                                           child: TextFormField(
                                             style: const TextStyle(
                                                 color: Colors.black
                                             ),
                                             cursorColor: const Color(0XFFBA68C8),
                                             controller: cartCubit.ccvController,
                                             validator: (value) {
                                               return CardUtils.validateCVV(cartCubit.ccvController.text);
                                             },
                                             keyboardType: TextInputType.number,
                                             inputFormatters: [
                                               FilteringTextInputFormatter.digitsOnly,
                                               // Limit the input
                                               LengthLimitingTextInputFormatter(4),
                                             ],
                                             decoration: const InputDecoration(
                                                 hintText: "CVV",
                                                 focusedBorder: UnderlineInputBorder(
                                                   borderSide: BorderSide(color: Color(0XFFBA68C8)),
                                                 ),
                                             ),
                                           ),
                                         ),
                                         const SizedBox(width: 16),
                                         Expanded(
                                           child: TextFormField(
                                             style: const TextStyle(
                                                 color: Colors.black
                                             ),
                                             cursorColor: const Color(0XFFBA68C8),
                                             keyboardType: TextInputType.number,
                                             controller: cartCubit.expDateController,
                                             validator: (value) {
                                               return CardUtils.validateDate(cartCubit.expDateController.text);
                                             },
                                             inputFormatters: [
                                               FilteringTextInputFormatter.digitsOnly,
                                               LengthLimitingTextInputFormatter(4),
                                               CardMonthInputFormatter(),
                                             ],
                                             decoration:
                                             const InputDecoration(
                                                 focusedBorder: UnderlineInputBorder(
                                                   borderSide: BorderSide(color: Color(0XFFBA68C8)),
                                                 ),
                                                 hintText: "MM/YY"
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                     // const Spacer(flex: 2),
                                     Padding(
                                       padding: const EdgeInsets.only(top: 16),
                                       child: ElevatedButton(
                                         style: ElevatedButton.styleFrom(
                                             backgroundColor: const Color(0XFFBA68C8), foregroundColor: Colors.black),
                                         child: const Text("Add card"),
                                         onPressed: () {
                                           if (formKey.currentState!.validate()) {
                                             Navigator.pop(context);
                                           }
                                         },
                                       ),
                                     ),
                                     // const Spacer(),
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
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                         ),
                       ),
                     ),
                  ],
                ),
              ),
            ],
            appBar: AppBar(
              backgroundColor: Color(0XFFBA68C8),
            ),
            body: ListView.separated(
                itemBuilder: (context, index) {
                  return buildCart(
                      increaseFunction: (index) {
                        cartCubit.increaseOrders(index: index);
                      },
                      decreaseFunction: (index) {
                        cartCubit.decreaseOrders(index: index);
                      },
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
    required int expansionIndex,
    required Function increaseFunction,
    required Function decreaseFunction,
  }
      )
  {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: const Color.fromRGBO(225, 93, 250, 0.14901960784313725)
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
              backgroundColor: const Color.fromRGBO(
                  193, 0, 243, 0.1),
              headerBuilder: (context, index) => Container(
                // padding: const EdgeInsets.all(16),
                height: 60,
                decoration: BoxDecoration(
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
                        image: AssetImage('assets/images/2.png'),
                        fit: BoxFit.cover,
                        width: 100,
                        height: double.infinity,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // book name
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 6),
                          child: Text(
                            "${book['bookName']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20
                            ),
                          ),
                        ),
                        // required quantity from customer
                        Text(
                          "Required quantity: ${book['reqQuantity']}",
                          style: const TextStyle(
                              color: Colors.black
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              body:  Container(
                padding: const EdgeInsets.all(16),
                // color: const Color.fromRGBO(199, 27, 234, 0.14901960784313725),
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
                        Column(
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
                                          255, 122, 249, 0.8)
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white,),
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
                                    color: const Color.fromRGBO(
                                        255, 122, 249, 0.8)
                                ),
                                child: const Icon(Icons.remove, color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                        // delete order
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              delete();
                            },
                            child: Container(
                              height: 50,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(173, 0, 158, 0.8)
                              ),
                              child: const Icon(Icons.restore_from_trash_sharp, color: Colors.white,),
                            ),
                          ),
                        ),
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
enum CardType {
  Master,
  Visa,
  Verve,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid
}
class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
class CardUtils {
  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.Master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.Verve;
    } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
      cardType = CardType.AmericanExpress;
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardType = CardType.Discover;
    } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CardType.DinersClub;
    } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CardType.Jcb;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }
  static Widget? getCardIcon(CardType? cardType) {
    String img = "";
    Icon? icon;
    switch (cardType) {
      case CardType.Master:
        img = 'mastercard.png';
        break;
      default:
        icon = const Icon(
          Icons.credit_card,
          size: 24.0,
          color: Color(0XFFBA68C8),
        );
        break;
    }
    Widget? widget;
    if (img.isNotEmpty) {
      widget = Image.asset(
        'assets/images/$img',
        width: 40.0,
      );
    } else {
      widget = icon;
    }
    return widget;
  }
  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }
  static String? validateCardNum(String? input) {
    if (input == null || input.isEmpty) {
      return "This field is required";
    }
    input = getCleanedNumber(input);
    if (input.length < 8) {
      return "Card is invalid";
    }
    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);
      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }
    if (sum % 10 == 0) {
      return null;
    }
    return "Card is invalid";
  }
  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    int year;
    int month;
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {

      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }
    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }
    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }
    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }
  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }
  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }
  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }
  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }
  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }
}