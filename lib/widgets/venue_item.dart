import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/screens/venue_booking_screen.dart';

class VenueItem extends StatelessWidget {
  final String typeOfSport;
  final String title;
  final int number;
  final int capacity;
  final String availablePeroids;
  final String state;
  final String imageUrl;

  VenueItem({
    required this.typeOfSport,
    required this.title,
    required this.number,
    required this.capacity,
    required this.availablePeroids,
    required this.state,
    required this.imageUrl
  });


  void selectVenue(BuildContext context){
    Navigator.of(context).pushNamed(VenueBookingScreen.routeName,
        arguments: {'venueObject': this
    });

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: ()=> selectVenue(context),
    child: Card(shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),),
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(children: [
        Stack(children: [
          ClipRRect(borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),),
            child: Image.network(imageUrl, height: 300, width: double.infinity, fit: BoxFit.cover,),),
          Positioned(bottom:20, right: 10, child: Container(
            width: 220, color: Colors.black54,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20), child: Text(
            title + '#' + number.toString(), style: TextStyle(fontSize: 26, color: Colors.white,), softWrap: true, overflow: TextOverflow.fade,),))
        ],),
        Padding(padding: EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(children: [
              Icon(Icons.numbers),  SizedBox(width: 6,), Text(capacity.toString())],),
            Row(children: [
              Icon(Icons.timelapse),  SizedBox(width: 6,), Text(availablePeroids)],),
          ],

        ),)
      ],),
    ),);
  }
}
