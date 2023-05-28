import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kau_sports_village_project/models/period.dart';
import 'package:kau_sports_village_project/models/reservation.dart';
import 'package:kau_sports_village_project/models/sport_venue.dart';
import 'package:kau_sports_village_project/screens/venue_booking_screen.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';
import 'package:kau_sports_village_project/app_data.dart';
import 'package:rxdart/rxdart.dart';
class PeroidButtons extends StatefulWidget {
  DateTime selectedDate;
  VenueItem chosenVenue;
  static String chosenPeroid = '';
  List <Period> slots;
  Function refreshBookingScreen;

  PeroidButtons({
    required this.refreshBookingScreen,
    required this.selectedDate,
    required this.chosenVenue,
    required this.slots
  });

  @override
  State<PeroidButtons> createState() => _PeroidButtonsState();

}

class _PeroidButtonsState extends State<PeroidButtons> {
  Stream<List<Reservation>>
  readPendingReservations() {
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

  Stream<List<Reservation>>
  readAcceptedReservations() {
    return
      FirebaseFirestore.instance
          .collection('acceptedReservations')
          .snapshots().map((snapshot) =>
          snapshot.docs.map((doc) {
            print('printing rezzz');
            print(doc.data());
            return
              Reservation.fromJson(doc.data());
          }).toList());
  }

  Stream<List<Reservation>>
  combineReservations() {
    Stream<List<Reservation>> reservations = readPendingReservations();
    Stream<List<Reservation>> acceptedReservations = readAcceptedReservations();

    Stream<List<Reservation>> combinedStream = CombineLatestStream.combine2(
      reservations,
      acceptedReservations,
          (list1, list2) => [...list1, ...list2,],
    );
    return combinedStream;
  }


   String formatDate(DateTime dt){
    var format = DateFormat('yyyy-MM-dd');
    return format.format(dt);
  }

  bool checkIfReserved(List<Reservation> list, String selectedDate, VenueItem chosenVenue, String peroid,) {
    String d = '';
    for(var i=0;i<list.length;i++){
      // print('selected date is $selectedDate');
      // print('rezz date is ${list[i].formattedDate}]');
      if(
      //list[i].reservationDate.year == selectedDate.year
      //&& list[i].reservationDate.month == selectedDate.month
      //&& list[i].reservationDate.day == selectedDate.day
      list[i].formattedDate == selectedDate
      &&list[i].reservedVenueName == chosenVenue.title
      && list[i].reservedVenueNumber == chosenVenue.number
      && list[i].reservationTime == peroid) {
        return true;
      }
    }
    return false;
  }

  void turnOffAllButOne(List<Period> periods, Period selectedPeriod) {

    for (Period period in periods) {
      if (period == selectedPeriod) {
        period.isClicked = true;
      }
      else {
        period.isClicked = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: combineReservations(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final reteivedReservations = snapshot.data!;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children:
          this.widget.slots.map((slot){
                return ElevatedButton(
                  style: slot.isClicked == true? ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent) : ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal),

                  onPressed: checkIfReserved(reteivedReservations,
                          formatDate(widget.selectedDate), widget.chosenVenue,
                          slot.timePeriod) ? null : () {
                    // PeroidButtons.chosenPeroid = '4:00PM to 6:00PM';
                    setState(() {
                      turnOffAllButOne(this.widget.slots, slot);
                      widget.refreshBookingScreen();
                      PeroidButtons.chosenPeroid = slot.timePeriod;
                      VenueBookingScreen.chosenTime = slot.timePeriod;
                      print('chose izz ${PeroidButtons.chosenPeroid}');
                    });
                  },
                  child: Text(slot.timePeriod),
                  );
              }).toList()
            );
        }
        return Text('Loading...');
      }
    );
  }
}
