import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';

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
    keyboardType: TextInputType.number,
    validator: (input) =>
    (input!.isEmpty) ? 'لا يمكنك ترك هذا الحقل فارغاً.' : null,
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
          // Validate name and money constraints
          print("han7ot elrequestat hina");//TODO : han7ot elrequest hina
          Navigator.pop(context);
        }),
  );


}
