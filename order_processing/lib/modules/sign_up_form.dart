import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:order_processing/modules/constants.dart';
class SignUpForm extends StatelessWidget{
  const SignUpForm({
    Key? key
}): super (key: key);
  static var Locationaddress;
  static var X_axis;
  static var Y_axis;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(padding:EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width* 0.13
    ),
      child: Form(
        child: Column(
          children: [
            Spacer(flex: 3,),
            Padding(padding: const EdgeInsets.symmetric(
                vertical: defaultPadding
            ),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Email Address",
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(
             vertical: defaultPadding
            ),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(
                vertical: defaultPadding
            ),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "User Name",
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(
                vertical: defaultPadding
            ),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "First Name",
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(
                vertical: defaultPadding
            ),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Last Name",
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(
                vertical: defaultPadding
            ),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                ),
              ),
            ),
            Container(
              height: 450,
              width: size.width * 0.8,
              child: Padding(padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding
              ),
                child: OpenStreetMapSearchAndPick(
                    center: LatLong(31.2160786, 29.9469253),
                    buttonColor: signup_bg,
                    buttonText: "Choose Shipping address",
                    onPicked: (pickedData) {
                      Locationaddress = pickedData.address;
                      X_axis = pickedData.latLong.latitude;
                      Y_axis = pickedData.latLong.longitude;
                    }),
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}