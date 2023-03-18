import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/screens/auth_screen.dart';
import 'package:kau_sports_village_project/screens/sign_in_screen.dart';
import 'package:kau_sports_village_project/screens/tabs_screen.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // //for testing-------------
          // if(snapshot.hasData)
          //   FirebaseAuth.instance.signOut();
          // //------------------------

          if(snapshot.hasData){
            print(snapshot.toString());
            return TabsScreen();
          }
          else{
            return AuthScreen();
          }
        }
      ),
    );
  }
}
