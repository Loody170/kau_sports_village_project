import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kau_sports_village_project/main_screen.dart';
import 'package:kau_sports_village_project/models/period.dart';
import 'package:kau_sports_village_project/models/sport_venue.dart';
import 'package:kau_sports_village_project/screens/reservation_form_screen.dart';
import 'package:kau_sports_village_project/screens/sign_in_screen.dart';
import 'package:kau_sports_village_project/widgets/period_buttons.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';

import '../app_data.dart';

class VenueBookingScreen extends StatefulWidget {
  static final String routeName = '/venue-booking';
  // static late Widget buttons = Row();
  static String chosenTime = '';

  @override
  State<VenueBookingScreen> createState() => _VenueBookingScreenState();
}

class _VenueBookingScreenState extends State<VenueBookingScreen> {
  DateTime _dateTime = DateTime.now();
  late List<Period> times;

  String formatDate(DateTime dt) {
    var format = DateFormat('yyyy-MM-dd');
    return format.format(dt);
  }

  @override
  void initState() {
    super.initState();
    List<Period> initialTimes = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, VenueItem>;
      initialTimes = divideTimePeriod(
          routeArgs['venueObject']!.startingTime,
          routeArgs['venueObject']!.endingTime);
      for (Period period in initialTimes) {
        period.isClicked = false;
      }

      setState(() {
        times = initialTimes;
      });
    });
  }

  void refreshScreen() {
    setState(() {});
  }

  List<Period> divideTimePeriod(int startHour, int endHour) {
    List<Period> slots = [];
    // Convert the hours to a 24-hour format (0-23)
    int start = startHour % 24;
    int end = endHour % 24;
    // Calculate the total number of hours between the start and end times
    int totalHours = (end - start + 24) % 24;
    // Divide the total number of hours by the duration of each slot
    int numSlots = (totalHours / 2).floor();
    // Calculate the start time and end time of each slot
    int slotStartHour = start;
    for (int i = 0; i < numSlots; i++) {
      int slotEndHour = (slotStartHour + 2) % 24;
      slots.add(new Period(timePeriod: '${_formatHour(slotStartHour)} to ${_formatHour(slotEndHour)}',));
      slotStartHour = slotEndHour;
    }
    // Add the last slot, if needed
    if (slotStartHour != end) {
      slots.add(new Period(timePeriod: '${_formatHour(slotStartHour)} to ${_formatHour(end)}',));
    }
    return slots;
  }
// Helper function to format an hour as a 12-hour time string
  String _formatHour(int hour) {
    String period = 'PM';
    // = hour < 12 ? 'AM' : 'PM';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    //return '$hour:00 $period';
    return '$hour:00';
  }

  bool onlyOneSelected(List<Period> list) {
    return list.any((item){
      print('checking for confirm >> ${item.isClicked}');
      return (item.isClicked == true);
    });
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

  Widget signInDialog(BuildContext context){
    Widget signInButton = TextButton(
      child: Text("Sign in"),
      onPressed:  () {
        
        Navigator.of(context).pushNamed('/');
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("You need to sign in to be able to reserve a venue"),
      actions: [
        signInButton,
        cancelButton,
      ],
    );
    return alert;
  }

  @override
  Widget build(BuildContext context) {
    for (Period period in times) {
      print('checking list');
      print(period.isClicked);
    }
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, VenueItem>;
    String barTitle = routeArgs['venueObject']!.title;
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
                    child: Image.asset('assets/sport_venues_images/${
                        routeArgs['venueObject']?.imagesNames[0] as String}.jpg',
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
                slots: this.times,
              ),

              Container(
                  padding: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                      onPressed: !onlyOneSelected(this.times)
                          ? null
                          : () async{
                              if(FirebaseAuth.instance.currentUser == null){
                                print('GO SIGN IN');
                                showDialog(context: context,
                                    builder: (BuildContext context){
                                      return signInDialog(context);
                                    });
                              }
                              else {
                                print(PeroidButtons.chosenPeroid);
                                Navigator.of(context).pushNamed(
                                    ReservationFormScreen.routeName,
                                    arguments: [
                                      routeArgs['venueObject'],
                                      _dateTime,
                                      PeroidButtons.chosenPeroid
                                    ]);
                              }//else
                            },
                      child: Text('Confirm')))
            ],
          ),
        ));
  }
}
