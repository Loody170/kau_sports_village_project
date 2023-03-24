import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/models/sport_venue.dart';
import 'package:kau_sports_village_project/screens/reservation_form_screen.dart';
import 'package:kau_sports_village_project/widgets/period_buttons.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';

import '../dummy_data.dart';

class VenueBookingScreen extends StatefulWidget {
  static final String routeName = '/venue-booking';
  static late Widget buttons = Row();

  @override
  State<VenueBookingScreen> createState() => _VenueBookingScreenState();
}

class _VenueBookingScreenState extends State<VenueBookingScreen> {
  DateTime _dateTime = DateTime.now();



  void _selectDate(){
    showDatePicker(context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2023),
        lastDate: DateTime(2024)).then((value) => {
          setState((){
            _dateTime = value!;
            var routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, VenueItem>;
            //VenueBookingScreen.buttons = PeroidButtons(selectedDate: _dateTime, chosenVenue: routeArgs['venueObject'] as VenueItem,);

          })
    });
  }





  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, VenueItem>;
    String barTitle = routeArgs['venueObject']!.title;

    return Scaffold(appBar: AppBar(title: Text(barTitle),),
    body: SingleChildScrollView(child: Column(
      children: [
        Container(height: 350, width: double.infinity,
        child: Image.network(routeArgs['venueObject']?.imageUrl as String, fit: BoxFit.cover,),),
       // Container(padding: EdgeInsets.symmetric(vertical: 30), child: Center(child: Text('first, pick a date'),)),
        Container(padding: EdgeInsets.symmetric(vertical: 20), child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).accentColor),
            onPressed: _selectDate, child: Text(
            'press for date'))),
        Text(_dateTime.toString()),
        //VenueBookingScreen.buttons,
       PeroidButtons(selectedDate: _dateTime, chosenVenue: routeArgs['venueObject'] as VenueItem,),
        Container(padding: EdgeInsets.all(50),
            child: ElevatedButton(onPressed: (){
              print(PeroidButtons.chosenPeroid);
              Navigator.of(context).pushNamed(ReservationFormScreen.routeName, arguments: [
                routeArgs['venueObject'], _dateTime, PeroidButtons.chosenPeroid
              ] );

          }, child: Text('Book')))

      ],
    ),));
  }
}
