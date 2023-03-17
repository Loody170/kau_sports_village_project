import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kau_sports_village_project/dummy_data.dart';
import 'package:kau_sports_village_project/screens/user_reservations_screen.dart';

import '../models/reservation.dart';


class ReservationItem extends StatelessWidget {
  late String venueName;
  late String venueImage;
  late DateTime reservedDate;
  late String peroid;
  late String reservationStatus;
  late int reservationNumber;
  late Function setState;

  ReservationItem({required this.venueName, required this.venueImage, required this.reservedDate,
    required this.peroid, required this.reservationStatus,
  required this.reservationNumber, required this.setState});

  var format = DateFormat('yyyy-MM-dd');

  String formatDate(){
    return format.format(reservedDate);
  }

  void deleteReservation(int reservationNumber){
    List<Reservation> listOfReservations = l as List<Reservation>;
    int index = listOfReservations.indexWhere((element) => element.reservationNumber == reservationNumber);
    listOfReservations.removeAt(index);
  }

  Widget confirmDialog(BuildContext context){
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        print('yes is pressed');
        deleteReservation(reservationNumber);
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
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(visualDensity: VisualDensity(vertical: 4),
              leading: ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(15)
                        ),
                         child: Image.network(venueImage, height: 100, width: 100, fit: BoxFit.fill,)),
              title: Text(venueName),
              subtitle: Column(
                children: [
                  Row(children: [
                    Icon(Icons.calendar_month), Text(formatDate()),
                    Padding(padding: EdgeInsets.all(10)),
                    Icon(Icons.timer_outlined), Text(peroid),
                  ],),
                  Row(children: [
                    Icon(Icons.find_in_page_sharp), Text('Status: $reservationStatus'),
                  ],),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [TextButton(onPressed: (){
                      print(reservationNumber);

                      showDialog(context: context,
                          builder: (BuildContext context){
                        return confirmDialog(context);
                          });

                      //deleteReservation(reservationNumber);
                      //setState();
                      //TODO: METHOD TO CANCEL RESERVATION
                    }, child: Text('Delete reservation'))

                  ],)
                ],
              ),
            ),



          ],
        ),
      ),
    );







    //   Container(decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(15)
    // ),
    //   child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black) ),
    //     child: Row(children: [
    //       ClipRRect(
    //          borderRadius: BorderRadius.all(Radius.circular(15)
    //            ),
    //             child: Image.network(venueImage, height: 75, width: 75, fit: BoxFit.cover,))
    //
    //     ],),
    //   ),
    // );


  }
}
