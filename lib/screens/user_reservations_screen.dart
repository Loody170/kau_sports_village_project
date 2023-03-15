import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kau_sports_village_project/dummy_data.dart';
import 'package:kau_sports_village_project/models/reservation.dart';
import 'package:kau_sports_village_project/widgets/reservations_item.dart';

import '../widgets/main_drawer.dart';

class UserReservationsScreen extends StatefulWidget {
  static String routeName = '/user-reservations';

  @override
  State<UserReservationsScreen> createState() => _UserReservationsScreenState();
}

class _UserReservationsScreenState extends State<UserReservationsScreen> {
  List<Reservation> rList = l as List<Reservation>;
  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: MainDrawer(),
      appBar: AppBar(title: Text('My Reservations'),),
      body: Column(
        children:
          rList.map((reservation) =>
              ReservationItem(
                  venueName: reservation.reservedVenue.title,
                  venueImage: reservation.reservedVenue.imageUrl,
                  reservedDate: reservation.reservationDate,
                  peroid: reservation.reservationTime,
                  reservationStatus: reservation.reservationStatus)).toList(),

      )
      ,);
  }
}
