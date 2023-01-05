import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Account.dart';
class makeManagerButton extends StatefulWidget {
  static TextEditingController Text1 = TextEditingController();
  makeManagerButton( {super.key}){
}
@override
State<StatefulWidget> createState() => _makeManagerButtonState();
}

class _makeManagerButtonState extends State<makeManagerButton> {
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
                  Text("Promotion",
                      style: TextStyle(
                        color: kPrimaryColor , fontSize: 32 , fontWeight: FontWeight.bold,)),
                  _formField('Username of the new manager', Icons.person_outlined),
                  _submitButton()
                ],
              ),
            ),
          )
      ),
    );

  }
  _formField(label, icon) => TextFormField(
    // maxLength: (label == 'وصف الإعلان') ? 150 : 32,
    // maxLines: (label == 'وصف الإعلان') ? 3 : 1,
    controller: makeManagerButton.Text1,
    decoration: InputDecoration(
      focusColor: kPrimaryColor,
      floatingLabelAlignment: FloatingLabelAlignment.center,
      labelText: label,
      suffixIcon: Icon(icon, color: kPrimaryColor),
      labelStyle: TextStyle(color: kPrimaryColor),
      border: const UnderlineInputBorder(),
    ),
    validator: (input) =>
    (input!.isEmpty) ? "You can't leave this field empty" : null,
    onSaved: (value) => textFields.add(value!),
  );

  _submitButton() => Container(
    alignment: Alignment.bottomCenter,
    margin: const EdgeInsets.only(top: 15),
    child: ElevatedButton.icon(
        label: const Text('Promote'),
        icon: const Icon(Icons.schedule_send),
        style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            padding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 15)),
        onPressed: () async {
          String _url =
              "http://${ip}:8080/bookstore/manager/promote/${makeManagerButton.Text1.text}";
          var res = await http.put(Uri.parse(_url),);
          if (res.statusCode!=200) {
            print("Error ya sa7by fe el promote manager\n MakeManager.dart\nline:75");
            print(res.body);
            makeManagerButton.Text1.clear();
            showAlertDialog( context,"Check your inputs" );
          } else {
            print("Response from backend when promote manager");
            print(res.body);
          }
          // print(textFields[0]);
          //TODO : han7ot elrequest hina elattributes el username hatib2a textFields[0];
          ///_url DONE ya MENTO
          print(makeManagerButton.Text1.text);
          Navigator.pop(context);
        }),
  );


}
showAlertDialog(BuildContext context, text3) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Alert"),
        content: Text(text3),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ));
}
