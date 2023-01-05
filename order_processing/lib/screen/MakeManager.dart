import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';

class makeManagerButton extends StatefulWidget {
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
              "http://${ip}:8080/bookstore/manager/promote";
          var res = await http.put(Uri.parse(_url),
              headers: {"Content-Type": "application/json"},
              body: json.encode({
                "username": Account.Oldusername
              }));
          if (res.statusCode!=200) {
            print("Error ya sa7by fe el promote manager\n MakeManager.dart\nline:75");
            print(res.body);
          } else {
            print("Response from backend when promote manager");
            print(res.body);
          }
          //TODO : han7ot elrequest hina elattributes el username hatib2a textFields[0];
          ///_url DONE ya MENTO
          Navigator.pop(context);
        }),
  );


}
