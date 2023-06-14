import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kau_sports_village_project/app_data.dart';
import 'package:kau_sports_village_project/models/reservation.dart';
import 'package:kau_sports_village_project/screens/reservation_successful_screen.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';

class ReservationConfirmationScreen extends StatelessWidget {
  static String routeName = '/confirmation-screen';
  late List receivedArgs;

  String formatDate(DateTime dt) {
    var format = DateFormat('yyyy-MM-dd');
    return format.format(dt);
  }

  Future createReservation(
      DateTime date, String peroid, VenueItem venue, Map list) async {
    Reservation reservation = Reservation(
        reservationNumber: 100 + Random().nextInt(900),
        formattedDate: formatDate(date),
        reservationStatus: 'pending',
        reservationTime: peroid,
        reservedVenueName: venue.title,
        reservedVenueNumber: venue.number,
        reservedVenueType: venue.typeOfSport,
        listOfAttendants: list as Map<dynamic, dynamic>);

    print('object is done');
    print(reservation);
    final docUser = FirebaseFirestore.instance.collection('reservations').doc();
    await docUser.set(Reservation.toJson(reservation,
        FirebaseAuth.instance.currentUser!.uid, venue.typeOfSport));
    print('sent the json done');

    //updateList(reservation);
  }
//style 2
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/sport_venues_images/${venue.imagesNames[0]}.jpg',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          venue.title,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reservation Date and Time:',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              dt.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Chosen Period:',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              chosenPeriod,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Players Information:',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          height: 180,
                          decoration: BoxDecoration(border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: m.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key = m.keys.elementAt(index);

                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                       "    $key",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "    ${m[key].toString()}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        createReservation(dt, chosenPeriod, venue, m);
                        Navigator.of(context)
                            .pushNamed(ReservationSuccessfulScreen.routeName);
                      },
                      child: Text('Submit Reservation Request'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
