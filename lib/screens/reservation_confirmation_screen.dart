import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/dummy_data.dart';
import 'package:kau_sports_village_project/models/reservation.dart';
import 'package:kau_sports_village_project/screens/reservation_successful_screen.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';

class ReservationConfirmationScreen extends StatelessWidget {
  static String routeName = '/confirmation-screen';
  late List receivedArgs;

  void createReservation(
      DateTime date, String peroid, VenueItem venue, Map list) {
    Reservation reservation = Reservation(
        reservationNumber: 100 + Random().nextInt(900),
        reservationDate: date,
        reservationStatus: 'pending',
        reservationTime: peroid,
        reservedVenue: venue,
        listOfAttendants: list);

    updateList(reservation);
  }

  //orginal style
  // @override
//   Widget build(BuildContext context) {
//     receivedArgs = ModalRoute.of(context)?.settings.arguments as List;
//     VenueItem venue = (receivedArgs[0] as List)[0];
//     DateTime dt = (receivedArgs[0] as List)[1];
//     String chosenPeriod = (receivedArgs[0] as List)[2];
//     Map m = receivedArgs[1];
//     return Scaffold(appBar: AppBar(title: Text('confirm'),),
//       body: Column(children: [
//         Text(venue.title),
//         Text(venue.capacity.toString()),
//         Text(dt.toString()),
//         Text(chosenPeriod),
//         Text(m.toString()),
//         ElevatedButton(onPressed: (){
//           createReservation(dt,chosenPeriod,venue, m);
//           //TODO MAKE BOOKING SUCCESS PAGE ISNTEAD OF DIRECTLY GOING HOME
//           Navigator.of(context).pushNamed(ReservationSuccessfulScreen.routeName);
//         }, child: Text('submit reservation request'),)

//       ],)
//       ,);
//   }
// }

//new style
// new style
  @override
  Widget build(BuildContext context) {
    receivedArgs = ModalRoute.of(context)?.settings.arguments as List;
    VenueItem venue = (receivedArgs[0] as List)[0];
    DateTime dt = (receivedArgs[0] as List)[1];
    String chosenPeriod = (receivedArgs[0] as List)[2];
    Map m = receivedArgs[1];
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Reservation'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              venue.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Capacity: ${venue.capacity}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Reservation Date and Time: ${dt.toString()}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Chosen Period: $chosenPeriod',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'players Information: ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              m.toString(),
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                createReservation(dt, chosenPeriod, venue, m);
                Navigator.of(context)
                    .pushNamed(ReservationSuccessfulScreen.routeName);
              },
              child: Text('Submit Reservation Request'),
            ),
          ],
        ),
      ),
    );
  }
}
