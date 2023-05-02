import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/app_data.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';

import '../models/reservation.dart';
import '../models/sport_venue.dart';


class SportVenuesScreen extends StatelessWidget {
  static const routeName = '/sport-venues';
  List<SportVenue> venuesList =[];
  late List<Map<String, dynamic>> listMap;

  Stream<List<SportVenue>> readVenues(String type) {
    return
      FirebaseFirestore.instance
          .collection(type+'_sport_venues')
          .snapshots().map((snapshot) =>
          snapshot.docs.map((doc) {
            print('printing venuess');
            print(doc.data());
            return
            SportVenue.fromJson(doc.data());
          }).toList());
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String type = routeArgs['type'] as String;
    final String title = routeArgs['title'] as String;


    // List<VenueItem> displayedVenues = DUMMY_SPORTVENUES.where((venue){
    //   return venue.typeOfSport.contains(type);
    // }).toList();
    // venuesList.forEach((element) {
    //   print(element.typeOfSport);
    // });

    return Scaffold(appBar: AppBar(title: Text(title + ' Venues'),),
        body:
        //
        // ListView(children:
        // displayedVenues.map((venue){
        //   return VenueItem(typeOfSport: venue.typeOfSport,
        //       availablePeroids: venue.availablePeroids,
        //       title: venue.title,
        //       capacity: venue.capacity,
        //       imageUrl: venue.imageUrl,
        //       number: venue.number,
        //       state: venue.state);
        // }).toList()
        //   ,) );

    StreamBuilder(
      stream: readVenues(type),
      builder: (context, snapshot){

        if(snapshot.hasData) {
          final venues = snapshot.data!;
          print('inside snapshot!');
          return
            ListView(children:
            venues.map((venue) {
              return VenueItem(typeOfSport: venue.typeOfSport,
                  availablePeroids: venue.availablePeroids,
                  title: venue.title,
                  capacity: venue.capacity,
                  imageUrl: venue.imageUrl,
                  number: venue.number,
                  state: venue.state);
            }).toList()
              ,);
        }
        print('no snapshot why?');
        return Text('Loading...');
      },)

    );
  }
}
