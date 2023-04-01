import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kau_sports_village_project/models/sport_venue.dart';
import 'package:kau_sports_village_project/screens/reservation_form_screen.dart';
import 'package:kau_sports_village_project/widgets/period_buttons.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';

import '../dummy_data.dart';

class VenueBookingScreen extends StatefulWidget {
  static final String routeName = '/venue-booking';
  static late Widget buttons = Row();
  static String chosenTime = '';

  @override
  State<VenueBookingScreen> createState() => _VenueBookingScreenState();
}

class _VenueBookingScreenState extends State<VenueBookingScreen> {
  DateTime _dateTime = DateTime.now();

  String formatDate(DateTime dt) {
    var format = DateFormat('yyyy-MM-dd');
    return format.format(dt);
  }

  @override
  void initState() {
    super.initState();
    PeroidButtons.button1 = false;
    PeroidButtons.button2 = false;
    PeroidButtons.button3 = false;
  }

  void refreshScreen() {
    setState(() {});
  }

  bool isButtonPressed() {
    return PeroidButtons.button1 ||
        PeroidButtons.button2 ||
        PeroidButtons.button3;
  }

  Widget buildCard(DateTime dt, String chosenPeriod) {
    String date = formatDate(dt);
    return Card(
      elevation: 4, // add a shadow effect to the card
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // add rounded corners to the card
        side: BorderSide(
            color: Colors.grey, width: 1), // add a border to the card
      ),
      child: ListTile(
        leading: Icon(Icons.calendar_month),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date),
            Container(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: _selectDate,
                    child: Text('Change Date'))),
          ],
        ),
      ),
    );
  }

  void _selectDate() {
    showDatePicker(
            context: context,
            initialDate: _dateTime,
            firstDate: DateTime(2023),
            lastDate: DateTime(2024))
        .then((value) => {
              setState(() {
                _dateTime = value!;
                var routeArgs = ModalRoute.of(context)?.settings.arguments
                    as Map<String, VenueItem>;
                //VenueBookingScreen.buttons = PeroidButtons(selectedDate: _dateTime, chosenVenue: routeArgs['venueObject'] as VenueItem,);
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, VenueItem>;
    String barTitle = routeArgs['venueObject']!.title;
    print(PeroidButtons.button1);

    print(PeroidButtons.button2);
    print(PeroidButtons.button3);
    return Scaffold(
        appBar: AppBar(
          title: Text(barTitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 350,
                width: 400,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: Image.network(
                      routeArgs['venueObject']?.imageUrl as String,
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: 35,
              ),

              Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    'Select a Date',
                    style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )),

              Container(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 40),
                  child: buildCard(_dateTime, VenueBookingScreen.chosenTime)),

              // Container(padding: EdgeInsets.symmetric(vertical: 30), child: Center(child: Text('first, pick a date'),)),

              // Container(padding: EdgeInsets.symmetric(vertical: 0), child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).accentColor),
              //     onPressed: _selectDate, child: Text(
              //     'press for date'))),
              // Text(_dateTime.toString()),
              //VenueBookingScreen.buttons,
              Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    'Select a Time',
                    style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )),

              PeroidButtons(
                refreshBookingScreen: this.refreshScreen,
                selectedDate: _dateTime,
                chosenVenue: routeArgs['venueObject'] as VenueItem,
              ),

              Container(
                  padding: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                      onPressed: !isButtonPressed()
                          ? null
                          : () {
                              print(PeroidButtons.chosenPeroid);
                              Navigator.of(context).pushNamed(
                                  ReservationFormScreen.routeName,
                                  arguments: [
                                    routeArgs['venueObject'],
                                    _dateTime,
                                    PeroidButtons.chosenPeroid
                                  ]);
                            },
                      child: Text('Confirm')))
            ],
          ),
        ));
  }
}
