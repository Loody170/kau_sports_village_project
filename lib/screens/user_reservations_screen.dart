import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kau_sports_village_project/dummy_data.dart';
import 'package:kau_sports_village_project/models/reservation.dart';
import 'package:kau_sports_village_project/widgets/reservations_item.dart';

import '../models/sport_venue.dart';
import '../widgets/main_drawer.dart';

class UserReservationsScreen extends StatefulWidget {
  static String routeName = '/user-reservations';

  @override
  State<UserReservationsScreen> createState() => _UserReservationsScreenState();
}

class _UserReservationsScreenState extends State<UserReservationsScreen> {

  void updateScreen(){
    setState(() {
    });
  }

  // String readVenues(String type, String title, int number) {
  //   String img = '';
  //
  //     var snapshots = FirebaseFirestore.instance
  //         .collection(type+'_sport_venues')
  //         .where('title', isEqualTo: title)
  //         .where('number', isEqualTo: number)
  //         .snapshots();
  //
  //     snapshots.map((snapshot) =>
  //         snapshot.docs.map((doc) {
  //           img = doc.data()['imageUrl'];
  //         })
  //     );
  //     return img;
  // }

  Stream<List<Reservation>>
  readReservations() {
    return
      FirebaseFirestore.instance
          .collection('reservations')
          .where('user', isEqualTo:FirebaseAuth.instance.currentUser!.uid )
          .snapshots().map((snapshot) =>
          snapshot.docs.map((doc) {
            print('printing rezzz');
            print(doc.data());
            return
              Reservation.fromJson(doc.data());
          }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: MainDrawer(),
      appBar: AppBar(title: Text('My Reservations'),),
      body: StreamBuilder(
        stream: readReservations(),
        builder: (context, snapshot) {
          final reteivedReservations = snapshot.data!;
          return
          Column(
            children:
            reteivedReservations.map((reservation) {

              // String pic = readVenues(reservation.reservedVenueType,
              //     reservation.reservedVenueName,
              //     reservation.reservedVenueNumber);

              return
                ReservationItem(
                  venueName: reservation.reservedVenueName,
                  //testttt TODO
                  venueImage: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/The_Santiago_Bernabeu_Stadium_-_U-g-g-B-o-y.jpg/640px-The_Santiago_Bernabeu_Stadium_-_U-g-g-B-o-y.jpg',
                  reservedDate: reservation.formattedDate,
                  peroid: reservation.reservationTime,
                  reservationStatus: reservation.reservationStatus,
                  reservationNumber: reservation.reservationNumber,
                  setState: updateScreen,);}).toList(),

          );

        }
      )
      ,);
  }
}
