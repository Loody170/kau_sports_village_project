import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/dummy_data.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';
import '../models/sport_venue.dart';

class SportVenuesScreen extends StatelessWidget {
  static const routeName = '/sport-venues';


  // List<SportVenue> displayedVenues = DUMMY_SPORTVENUES.where((venue){
  //   return venue.typeOfSport.contains('');
  // }).toList();

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String type = routeArgs['type'] as String;
    final String title = routeArgs['title'] as String;

    List<VenueItem> displayedVenues = DUMMY_SPORTVENUES.where((venue){
      return venue.typeOfSport.contains(type);
    }).toList();

    return Scaffold(appBar: AppBar(title: Text(title),),
      body: ListView(children:
        displayedVenues.map((venue){
          return VenueItem(typeOfSport: venue.typeOfSport,
          availablePeroids: venue.availablePeroids,
          title: venue.title,
          capacity: venue.capacity,
          imageUrl: venue.imageUrl,
          number: venue.number,
          state: venue.state);
        }).toList()
      ,) );
  }
}
