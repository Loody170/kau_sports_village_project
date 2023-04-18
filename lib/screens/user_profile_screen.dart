import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/widgets/main_drawer.dart';
import 'package:kau_sports_village_project/widgets/user_profile_form.dart';

class UserProfileScreen extends StatefulWidget {
  static String routeName = '/user_profile';

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}


class _UserProfileScreenState extends State<UserProfileScreen> {
  void updateScreen(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile'),),
      drawer: MainDrawer(),
      body: UserProfileForm(updateScreen)
    );
  }
}
