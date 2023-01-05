import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class makeOrderButton extends StatefulWidget {
  makeOrderButton( {required isbn,super.key}){
ISBN = isbn;
}
static String ISBN="";
@override
State<StatefulWidget> createState() => _makeOrderButtonState();
}

class _makeOrderButtonState extends State<makeOrderButton> {
  final GlobalKey<FormState> _key = GlobalKey();
  late List<dynamic> textFields = <String>[];

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 25.0, horizontal: 25.0),
              child: Column(
                children: [
                  Text("Make An Order",
                      style: TextStyle(
                        color: kPrimaryColor , fontSize: 32 , fontWeight: FontWeight.bold,)),
                  _formField('Number of needed books', Icons.menu_book),
                  _submitButton(makeOrderButton.ISBN)
                ],
              ),
            ),
          )
      ),
    );

  }
  _formField(label, icon) => TextFormField(
    decoration: InputDecoration(
      focusColor: kPrimaryColor,
      floatingLabelAlignment: FloatingLabelAlignment.center,
      labelText: label,
      suffixIcon: Icon(icon, color: kPrimaryColor),
      labelStyle: TextStyle(color: kPrimaryColor),
      border: const UnderlineInputBorder(),
    ),
    keyboardType: TextInputType.number,
    validator: (input) =>
    (input!.isEmpty) ? "You can't leave this field empty" : null,
    onSaved: (value) => textFields.add(value!),
  );

  _submitButton(id) => Container(
    alignment: Alignment.bottomCenter,
    margin: const EdgeInsets.only(top: 15),
    child: ElevatedButton.icon(
        label: const Text('Submit'),
        icon: const Icon(Icons.schedule_send),
        style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            padding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 15)),
        onPressed: () async {
          String _url =
              "http://${ip}:8080/bookstore/manager/place/order/book";
          var res = await http.post(Uri.parse(_url),
              headers: {"Content-Type": "application/json"},
              body: json.encode({
                "ISBN": makeOrderButton.ISBN,
                "quantity":  textFields[0],
              }));
          if (res.statusCode!=200) {
            print("Error ya sa7by fe el place order\n MakeOrder.dart\nline:77");
            print(res.body);
          } else {
            print("Response from backend when place order");
            print(res.body);
          }
          //TODO : han7ot elrequest hina elattributes hya el ISPN hyb2a id wel quantity hatib2a textFields[0];
          /// DONE ya MENTO
          Navigator.pop(context);
        }),
  );


}
