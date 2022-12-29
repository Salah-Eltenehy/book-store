


import 'package:flutter/material.dart';


Widget defaultTextFormField({
  required TextEditingController controller,
  required String labelText ,
  required Function validatorFunction,
  required TextInputType textInputType,
  Icon? prefixIcon ,
  Function? onChangedFunc
}) =>
    SizedBox( // email address
      height: 50.0,
      child: TextFormField(
        onChanged: (value) {
          onChangedFunc!(value);
        },
        validator: (value) {
          return validatorFunction(value);
        },
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
            prefix: Padding(
              padding: const EdgeInsets.all(8.0),
              child: prefixIcon,
            ),
        ),
      ),
    );