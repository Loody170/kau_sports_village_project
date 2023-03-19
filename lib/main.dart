import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/main_screen.dart';
import 'package:kau_sports_village_project/screens/auth_screen.dart';
import 'package:kau_sports_village_project/screens/reservation_successful_screen.dart';
import 'package:kau_sports_village_project/screens/gym_assistant_screen.dart';
import 'package:kau_sports_village_project/screens/reservation_confirmation_screen.dart';
import 'package:kau_sports_village_project/screens/reservation_form_screen.dart';
import 'package:kau_sports_village_project/screens/sport_venues_screen.dart';
import 'package:kau_sports_village_project/screens/sport_categories_screen.dart';
import 'package:kau_sports_village_project/screens/tabs_screen.dart';
import 'package:kau_sports_village_project/screens/user_reservations_screen.dart';
import 'package:kau_sports_village_project/screens/venue_booking_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'KAU Sports Village',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.deepOrange[800],
      ),
      //home: TabsScreen(),
      //initialRoute: '/',
      routes: {
        '/': (ctx) => MainScreen(),
        SportVenuesScreen.routeName: (ctx) => SportVenuesScreen(),
        GymAssistantScreen.routeName: (ctx) => GymAssistantScreen(),
        VenueBookingScreen.routeName: (ctx) => VenueBookingScreen(),
        ReservationFormScreen.routeName: (ctx) => ReservationFormScreen(),
        ReservationConfirmationScreen.routeName: (ctx) => ReservationConfirmationScreen(),
        ReservationSuccessfulScreen.routeName: (ctx) => ReservationSuccessfulScreen(),
        UserReservationsScreen.routeName: (ctx) => UserReservationsScreen(),

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kau Sports Village'),
      ),
      body: Center(
        child: Text('Content here'),
      ),
    );
  }
}
