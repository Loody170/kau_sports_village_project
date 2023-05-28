import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kau_sports_village_project/app_data.dart';
import 'package:kau_sports_village_project/screens/user_reservations_screen.dart';

import '../models/reservation.dart';


class ReservationItem extends StatelessWidget {
  late Reservation reservation;
  late Function setState;

  ReservationItem({
        required this.reservation,
        required this.setState
      });

  Future<void> deleteReservation(int rNumber) async {
    var snapshot = await FirebaseFirestore.instance.collection('reservations')
        .where('number', isEqualTo: rNumber).get();
    // If there are no documents that match the query, return early
    if (snapshot.docs.isEmpty) {
      return;
    }
    // If there is at least one document that matches the query, delete it/them
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future <List<dynamic>> readVenueImage(String type, String title, int number)async  {
    final CollectionReference collectionRef =
    FirebaseFirestore.instance.collection(type+'_sport_venues');

    Query query = collectionRef.where('title', isEqualTo: title).limit(1)
        .where('number', isEqualTo: number).limit(1);

    final QuerySnapshot snapshot = await query.get();
    final List<DocumentSnapshot> documents = snapshot.docs;

      final DocumentSnapshot document = documents.first;
      Map map = (document.data()) as Map;
      return map['imagesNames'];
  }

  Widget confirmDialog(BuildContext context){
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        print('yes is pressed');
        deleteReservation(reservation.reservationNumber);
        setState();
        Navigator.of(context).pop();
      },
    );
    Widget noButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        print('no is pressed');
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure do you want to delete this reservation?"),
      actions: [
        yesButton,
        noButton,
      ],
    );
    return alert;
  }

  @override
  Widget build(BuildContext context) {
    readVenueImage(reservation.reservedVenueType,
              reservation.reservedVenueName,
            reservation.reservedVenueNumber
          );
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(visualDensity: VisualDensity(vertical: 4),

              leading:
              FutureBuilder(
                future: readVenueImage(reservation.reservedVenueType,
                    reservation.reservedVenueName,
                    reservation.reservedVenueNumber
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var pics = snapshot!;
                    return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)
                        ),
                        child: Image.asset('assets/sport_venues_images/${
                          pics.data![0]}.jpg', height: 100, width: 90, fit: BoxFit.fitHeight,)
                    );
                  }
                  return Text('Loading...');
                }
                ),

              title: Text(reservation.reservedVenueName),
              subtitle: Column(
                children: [
                  Row(children: [
                    Icon(Icons.calendar_month), Text(reservation.formattedDate),
                    Icon(Icons.timer_outlined), Text(reservation.reservationTime),
                  ],),
                  Row(children: [
                    Icon(Icons.find_in_page_sharp), Text('Status: ${reservation.reservationStatus}'),
                  ],),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [TextButton(onPressed: (reservation.reservationStatus == 'pending')?(){
                      print(reservation.reservationNumber);

                      showDialog(context: context,
                          builder: (BuildContext context){
                        return confirmDialog(context);
                          });

                    } : null, child: Text('Delete reservation'))
                  ],)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
