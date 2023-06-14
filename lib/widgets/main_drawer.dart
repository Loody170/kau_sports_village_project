import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/models/app_user.dart';
import 'package:kau_sports_village_project/screens/tabs_screen.dart';
import 'package:kau_sports_village_project/screens/user_reservations_screen.dart';

import '../screens/user_profile_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTiles(String title, IconData icon, VoidCallback tapHandler){
    return ListTile(leading: Icon(icon, size: 26,), title: Text(title, style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 24, fontWeight: FontWeight.bold),),
      onTap: tapHandler ,);
  }

  Stream<AppUser>
  getUser() {
    return
      FirebaseFirestore.instance
          .collection('users').doc(FirebaseAuth.instance.currentUser?.uid).snapshots().map((event) {
            return
            AppUser.fromJson(event.data()!);
      });
  }

  bool checkIfGuestUser(){
    return (FirebaseAuth.instance.currentUser == null);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(children: [
      Container(color: Theme.of(context).accentColor, height: 120, width: double.infinity, padding: EdgeInsets.all(20), alignment: Alignment.centerLeft,
        child:StreamBuilder(
          stream: getUser(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              AppUser user =snapshot.data!;
              return
              Text('Welcome! \n ${user.fName} ${user.lName}', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: Theme.of(context).primaryColor),);
            }
            return Text('Welcome! \n Guest User', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: Theme.of(context).primaryColor),);
          },
        )
        ,),
      SizedBox(height: 20,),
      buildListTiles('Sports Categories', Icons.sports_handball, (){Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);}),
      Visibility(
        visible: !checkIfGuestUser(),
        child: buildListTiles('My Reservations', Icons.menu_book_outlined, (){Navigator.of(context).pushReplacementNamed(UserReservationsScreen.routeName);}),
      ),
      Visibility(
        visible: !checkIfGuestUser(),
        child: buildListTiles('My Profile', Icons.supervised_user_circle_sharp, (){Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName);}),
      ),
        !checkIfGuestUser()?
           buildListTiles('Sign out', Icons.exit_to_app, (){
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed('/');
          })
        :
          buildListTiles('Sign In', Icons.assignment_ind_rounded, (){
          Navigator.of(context).pushReplacementNamed('/');
        }),

    ],),
    );
  }
}
