
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kau_sports_village_project/models/reservation.dart';
import 'package:kau_sports_village_project/models/sport_venue.dart';
import 'package:kau_sports_village_project/screens/venue_booking_screen.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';
import 'package:kau_sports_village_project/app_data.dart';

class PeroidButtons extends StatefulWidget {
  DateTime selectedDate;
  VenueItem chosenVenue;
  static String chosenPeroid = '';
  static bool button1 = false;
  static bool button2 = false;
  static bool button3 = false;
  Function refreshBookingScreen;

  //late final listofR;


  PeroidButtons({
    required this.refreshBookingScreen,
    required this.selectedDate,
    required this.chosenVenue
  });

  @override
  State<PeroidButtons> createState() => _PeroidButtonsState();

}

class _PeroidButtonsState extends State<PeroidButtons> {
  // bool get isReserved {
  //   return checkIfReserved(widget.listofR, formatDate(widget.selectedDate), widget.chosenVenue, '4-6');
  // }
  Stream<List<Reservation>>
  readReservations() {
    return
      FirebaseFirestore.instance
          .collection('reservations')
          .snapshots().map((snapshot) =>
          snapshot.docs.map((doc) {
            print('printing rezzz');
            print(doc.data());
            return
              Reservation.fromJson(doc.data());
          }).toList());
  }

   String formatDate(DateTime dt){
    var format = DateFormat('yyyy-MM-dd');
    return format.format(dt);
  }

  bool checkIfReserved(List<Reservation> list, String selectedDate, VenueItem chosenVenue, String peroid,) {

    String d = '';
    for(var i=0;i<list.length;i++){
      print('selected date is $selectedDate');
      print('rezz date is ${list[i].formattedDate}]');
      if(
      //list[i].reservationDate.year == selectedDate.year
      //&& list[i].reservationDate.month == selectedDate.month
      //&& list[i].reservationDate.day == selectedDate.day
      list[i].formattedDate == selectedDate
      &&list[i].reservedVenueName == chosenVenue.title
      && list[i].reservedVenueNumber == chosenVenue.number
      && list[i].reservationTime == peroid) {

        // print('this is date from reservation after success');
        // print(list[i].reservationDate.toString());
        //  d = list[i].reservationDate.toString();
        // print('this is date from chosen calender after success');
        // print(selectedDate.toString());
        // print(list[i].reservationTime);
        return true;
      }
    }

    // print('this is date from chosen calender after failure');
    // print(selectedDate.toString());
    // print('this is date from reservation after failure');
    // print(d);
    return false;

  }

  //checkIfReserved(bool)? null:
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: readReservations(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final reteivedReservations = snapshot.data!;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(style: PeroidButtons.button1 ? ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent) : ElevatedButton.styleFrom(
                backgroundColor: Colors.teal),
                onPressed: checkIfReserved(reteivedReservations,
                    formatDate(widget.selectedDate), widget.chosenVenue,
                    '4:00PM to 6:00PM') ? null : () {
                 // PeroidButtons.chosenPeroid = '4:00PM to 6:00PM';
                  setState(() {
                    PeroidButtons.button1 = true;
                    PeroidButtons.button2 = false;
                    PeroidButtons.button3 = false;
                    print(PeroidButtons.button1);

                    print(PeroidButtons.button2);
                    print(PeroidButtons.button3);
                    widget.refreshBookingScreen();
                    PeroidButtons.chosenPeroid = '4:00PM to 6:00PM';
                    VenueBookingScreen.chosenTime = '4:00PM to 6:00PM';
                  });
                }, child: Text('4:00PM -\n6:00PM')),

            ElevatedButton(style: PeroidButtons.button2 ? ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent) : ElevatedButton.styleFrom(
                backgroundColor: Colors.teal),
                onPressed:  checkIfReserved(reteivedReservations,
                    formatDate(widget.selectedDate), widget.chosenVenue,
                    '6:00PM to 8:00PM') ? null : () {
                  // PeroidButtons.chosenPeroid = '6:00PM to 8:00PM';
                  setState(() {
                    PeroidButtons.button1 = false;
                    PeroidButtons.button2 = true;
                    PeroidButtons.button3 = false;
                    print(PeroidButtons.button1);

                    print(PeroidButtons.button2);
                    print(PeroidButtons.button3);
                    widget.refreshBookingScreen();
                    PeroidButtons.chosenPeroid = '6:00PM to 8:00PM';
                    VenueBookingScreen.chosenTime = '6:00PM to 8:00PM';
                  });
                },
                child: Text('6:00PM -\n8:00PM')),

            ElevatedButton(style: PeroidButtons.button3 ? ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent) : ElevatedButton.styleFrom(
                backgroundColor: Colors.teal),
                onPressed: checkIfReserved(reteivedReservations,
                    formatDate(widget.selectedDate), widget.chosenVenue,
                    '8:00PM to 10:00PM') ? null : () {
                  // PeroidButtons.chosenPeroid = '8:00PM to 10:00PM';
                  setState(() {
                    PeroidButtons.button1 = false;
                    PeroidButtons.button2 = false;
                    PeroidButtons.button3 = true;
                    print(PeroidButtons.button1);

                    print(PeroidButtons.button2);
                    print(PeroidButtons.button3);
                    widget.refreshBookingScreen();
                    PeroidButtons.chosenPeroid = '8:00PM to 10:00PM';
                    VenueBookingScreen.chosenTime = '8:00PM to 10:00PM';

                  });
                },
                child: Text('8:00PM -\n10:00PM'))
          ],);
        }
        return Text('Loading...');
      }
    );
  }
}
