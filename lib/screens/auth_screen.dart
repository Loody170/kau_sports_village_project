import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/screens/sign_in_screen.dart';
import 'package:kau_sports_village_project/screens/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool showSignInScreen = true;

  void toggleScreens(){
    setState(() {
      showSignInScreen = !showSignInScreen;
    });

  }
  @override
  Widget build(BuildContext context) {
    if(showSignInScreen){
      return SignInScreen(showSignUpScreen: toggleScreens,);
    }
    else{
      return SignUpScreen(showSignInScreen: toggleScreens);
    }
  }
}
