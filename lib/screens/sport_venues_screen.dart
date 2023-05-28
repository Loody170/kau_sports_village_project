import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/app_data.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';

import '../models/reservation.dart';
import '../models/sport_venue.dart';


class SportVenuesScreen extends StatefulWidget {
  static const routeName = '/sport-venues';

  @override
  State<SportVenuesScreen> createState() => _SportVenuesScreenState();
}

class _SportVenuesScreenState extends State<SportVenuesScreen> {
  List<SportVenue> venuesList =[];
  int _currentImageIndex = 0;


  late List<Map<String, dynamic>> listMap;

  Stream<List<SportVenue>> readVenues(String type) {
    return
      FirebaseFirestore.instance
          .collection(type+'_sport_venues')
          .snapshots().map((snapshot) {
        print('Number of documents: ${snapshot.size}');
        return snapshot.docs.map((doc) {
          print('printing doc');
          print(doc.data());
          return SportVenue.fromJson(doc.data());
        }).toList();
      });
  }

  void _handleImageChange(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String type = routeArgs['type'] as String;
    final String title = routeArgs['title'] as String;
    return Scaffold(appBar: AppBar(title: Text(title + ' Venues'),),
        body:
    StreamBuilder(
      stream: readVenues(type),
      builder: (context, snapshot){

        if(snapshot.hasData) {
          final venues = snapshot.data!;
          print('inside snapshot!');
          return
            ListView(children:
            venues.map((venue) {
              return VenueItem(
                  typeOfSport: venue.typeOfSport,
                  availablePeroids: venue.availablePeroids,
                  title: venue.title,
                  capacity: venue.capacity,
                  imagesNames: venue.imagesNames,
                  number: venue.number,
                  state: venue.state,
                  startingTime: venue.startingTime,
                  endingTime: venue.endingTime,);
            }).toList()
              ,);
        }
        print('no snapshot why?');
        return Text('Loading...');
      },)

    );
  }
}
