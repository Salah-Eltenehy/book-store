import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:order_processing/Constants.dart';

class FindLocation extends StatelessWidget {
  FindLocation({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);
  static var Locationaddress;
  final double x;
  final double y;
  static var X_axis;
  static var Y_axis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: OpenStreetMapSearchAndPick(
            center: LatLong(x,y),
            buttonColor: kPrimaryColor,
            buttonText: "Choose Shipping Address",
            onPicked: (pickedData) {
              Locationaddress = pickedData.address;
              X_axis = pickedData.latLong.latitude;
              Y_axis = pickedData.latLong.longitude;
            }),
      ),
    );
  }
}
