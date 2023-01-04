import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';
import 'package:order_processing/component/Username.dart';
import 'package:order_processing/component/firstname.dart';
import 'package:order_processing/component/secondname.dart';
import 'package:order_processing/httprequests/signuprequest.dart';
import '../../component/findlocation_Map.dart';
import '../../component/rounded_button.dart';
import '../../component/rounded_input.dart';
import '../../component/rounded_password_input.dart';
import '../../component/rounded_phone.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration * 5,
      child: Visibility(
        visible: !isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(height: 10),

                  SizedBox(height: 40),

                  Container(
                      height: 175,
                      width: 175,
                      child: const Image(
                          image: AssetImage('assets/booklogo.PNG'))),

                  SizedBox(height: 40),

                  RoundedInput(icon: Icons.mail, hint: 'Email Address'),
                  Username(icon: Icons.face_rounded, hint: 'User Name'),
                  FirstName(icon: Icons.face_rounded, hint: 'First Name'),
                  SecondName(icon: Icons.face_rounded, hint: 'Last Name'),
                  RoundedPasswordInput(),
                  RoundedPhoneNumber(icon: Icons.phone,color: kPrimaryColor, hint: 'Phone Number'),
                  Container(
                    height: 450,
                    width: size.width * 0.8,
                    child: FindLocation(x: 31.2160786,y:  29.9469253,),
                  ),
                  SizedBox(height: 10),
                  Signup(),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}