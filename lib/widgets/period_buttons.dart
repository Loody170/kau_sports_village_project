import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/models/reservation.dart';
import 'package:kau_sports_village_project/models/sport_venue.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';
import 'package:kau_sports_village_project/dummy_data.dart';

class PeroidButtons extends StatefulWidget {
  DateTime selectedDate;
  VenueItem chosenVenue;
  static late String chosenPeroid;
  bool button1 = false;
  bool button2 = false;
  bool button3 = false;


  PeroidButtons({required this.selectedDate, required this.chosenVenue});

  @override
  State<PeroidButtons> createState() => _PeroidButtonsState();
}

class _PeroidButtonsState extends State<PeroidButtons> {
  bool get isReserved {
    return checkIfReserved(widget.selectedDate, widget.chosenVenue, '4-6');
  }

  bool checkIfReserved(DateTime selectedDate, VenueItem chosenVenue, String peroid,) {
    var list = l;
    String d = '';
    for(var i=0;i<list.length;i++){
      if(list[i].reservationDate.year == selectedDate.year
      && list[i].reservationDate.month == selectedDate.month
      && list[i].reservationDate.day == selectedDate.day
      && list[i].reservedVenue.title == chosenVenue.title
      && list[i].reservedVenue.number == chosenVenue.number
      && list[i].reservationTime == peroid) {

        print('this is date from reservation after success');
        print(list[i].reservationDate.toString());
         d = list[i].reservationDate.toString();
        print('this is date from chosen calender after success');
        print(selectedDate.toString());
        print(list[i].reservationTime);
        return true;
      }
    }

    print('this is date from chosen calender after failure');
    print(selectedDate.toString());
    print('this is date from reservation after failure');
    print(d);
    return false;

  }

  //checkIfReserved(bool)? null:
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(style: widget.button1? ElevatedButton.styleFrom(backgroundColor: Colors.purple): ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          onPressed:checkIfReserved(widget.selectedDate, widget.chosenVenue, '4-6')? null: (){
        PeroidButtons.chosenPeroid = '4-6';
        setState(() {
          widget.button1 = true;
          widget.button2 = false;
          widget.button3 = false;
        });
        }, child: Text('4-6')),


      ElevatedButton(style: widget.button2? ElevatedButton.styleFrom(backgroundColor: Colors.purple): ElevatedButton.styleFrom(backgroundColor: Colors.teal),
    onPressed:checkIfReserved(widget.selectedDate, widget.chosenVenue, '6-8')? null: (){
        PeroidButtons.chosenPeroid = '6-8';
        setState(() {
          widget.button1 = false;
          widget.button2 = true;
          widget.button3 = false;
        });
        },
          child: Text('6-8')),

      ElevatedButton(style: widget.button3? ElevatedButton.styleFrom(backgroundColor: Colors.purple): ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          onPressed: checkIfReserved(widget.selectedDate, widget.chosenVenue, '8-10')? null: (){
        PeroidButtons.chosenPeroid = '8-10';
        setState(() {
          widget.button1 = false;
          widget.button2 = false;
          widget.button3 = true;
        });
        },
          child: Text('8-10'))
    ],);
  }
}
