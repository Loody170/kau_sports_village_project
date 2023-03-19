import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/screens/sign_in_screen.dart';
import 'package:kau_sports_village_project/screens/user_reservations_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTiles(String title, IconData icon, VoidCallback tapHandler){
    return ListTile(leading: Icon(icon, size: 26,), title: Text(title, style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 24, fontWeight: FontWeight.bold),),
      onTap: tapHandler ,);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(children: [
      Container(color: Theme.of(context).accentColor, height: 120, width: double.infinity, padding: EdgeInsets.all(20), alignment: Alignment.centerLeft,
        child: Text('Side Bar!' , style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: Theme.of(context).primaryColor),)
        ,),
      SizedBox(height: 20,),
      buildListTiles('Sports Categories', Icons.sports_handball, (){Navigator.of(context).pushReplacementNamed('/');}),
      buildListTiles('My Reservations', Icons.menu_book_outlined, (){Navigator.of(context).pushReplacementNamed(UserReservationsScreen.routeName);}),
      buildListTiles('Sign out', Icons.supervised_user_circle_rounded, (){
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
      }),

    ],),
    );
  }
}
