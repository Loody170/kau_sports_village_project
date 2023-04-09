import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservationSuccessfulScreen extends StatelessWidget {
  static String routeName = '/booking-successful';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(automaticallyImplyLeading: false,
      title: (Text('Venue Booking')),),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(textAlign: TextAlign.center,'Your booking request has been submitted sucesfuly!',
            style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold,
            fontSize: 20,),),),

          SizedBox(height: 15,),

          ElevatedButton(onPressed: ()=> Navigator.of(context).pushReplacementNamed('/'), child: Text('Return to Main Screen'))
        ],
      ),);
  }
}
