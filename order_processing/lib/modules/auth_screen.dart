import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_processing/modules/constants.dart';
import 'package:order_processing/modules/sign_up_form.dart';

import 'login_form.dart';
class AuthScreen extends StatefulWidget
{
  const AuthScreen({Key ? key}) : super (key : key);
  @override
   _AuthScreenState createState() => _AuthScreenState();

}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin
{
  bool isShowSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;
  void setupAnimation()
  {
    _animationController = AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate = Tween<double> (begin: 0,end: 90 ).animate(_animationController);
  }
  void updateview()
  {
    setState(() {
      isShowSignUp = ! isShowSignUp;
    });
    isShowSignUp?_animationController.forward(): _animationController.reverse();
  }
  @override
  void initState()
  {
    setupAnimation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: [
              AnimatedPositioned(
                duration: defaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height ,
                  left: isShowSignUp? -_size.width *0.76 :0 ,
                  child: Container(
                    color: login_bg,
                    child: LoginForm(),
                  ),
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                  height: _size.height,
                  width: _size.width* 0.88 ,
                  left: isShowSignUp?  _size.width * 0.12 :_size.width*0.88,
                  child: Container(
                    color: signup_bg,
                    child: SignUpForm(),
              )),
              Positioned(
                  top: _size.height* 0.1,
                  left: 0,
                  right: isShowSignUp? -_size.width * 0.06 : _size.width * 0.06,
                  child: CircleAvatar(
                    radius: 25,
                    child: AnimatedSwitcher(
                      duration: defaultDuration,
                      child: isShowSignUp? Image.asset(
                       "assets/bookLogo2.PNG",
                        // color: login_bg,
                      ): Image.asset(
                        "assets/booklogo.PNG",
                        // color: login_bg,
                      ) ,
                    ),
                  )
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                  bottom: isShowSignUp?_size.height/2 -80 : _size.height * 0.3,
                  left: isShowSignUp?0:  _size.width * 0.44 - 80,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isShowSignUp? 20:32,
                      fontWeight: FontWeight.bold,
                      color: isShowSignUp? Colors.white: Colors.white70,
                    ),
                    child: Transform.rotate(
                      angle: -_animationTextRotate.value * pi /180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap:(){
                          if(isShowSignUp)
                            {
                              updateview();
                            }
                          else
                            {
                              //login
                            }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding * 0.75
                          ),
                          width: 160,
                          child: isShowSignUp?Text(
                            "Log In".toUpperCase(),
                          ) :Text(
                            "".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  )),
              AnimatedPositioned(
                  duration: defaultDuration,
                  bottom: !isShowSignUp?_size.height/2 - 80 : _size.height * 0.3,
                  right: isShowSignUp?  _size.width * 0.44 - 80 :0,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: !isShowSignUp? 20:32,
                      fontWeight: FontWeight.bold,
                      color: isShowSignUp? Colors.white: Colors.white70,
                    ),
                    child: Transform.rotate(
                      angle:( 90 -_animationTextRotate.value) * pi /180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap:(){
                          if(isShowSignUp)
                          {
                            // Signup
                          }
                          else
                          {
                            updateview();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75
                          ),
                          width: 160,
                          child:isShowSignUp? Text(
                            "".toUpperCase(),
                          ) :Text(
                            "Sign Up".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          );
        }
      ),
    );
  }}

