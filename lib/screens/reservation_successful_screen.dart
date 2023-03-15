import 'package:flutter/material.dart';

class ReservationSuccessfulScreen extends StatelessWidget {
  static String routeName = '/booking-successful';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(automaticallyImplyLeading: false,
      title: (Text('booking succesful')),),
      body: Column(
        children: [
          Center(child: Text('Your booking request has been submitted sucesfuly!'),),
          ElevatedButton(onPressed: ()=> Navigator.of(context).pushReplacementNamed('/'), child: Text('go to home'))
        ],
      ),);
  }
}
