import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/models/reservation.dart';
import 'package:kau_sports_village_project/models/sport_venue.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';
import 'models/category.dart';

 List l =[];
 //getReservations();

const CATEGORIES = const [
  SportsCategory(type: 'FB', title: 'Football', color: Colors.green, icon: 'https://i.imgur.com/7G75q9z.png'),
  SportsCategory(type: 'BB', title: 'Basketball', color: Colors.deepOrange, icon: 'https://i.imgur.com/J5Bh1GF.png'),
  SportsCategory(type: 'VB', title: 'Volleyball', color: Color.fromRGBO(255, 175, 0, 1), icon: 'https://i.imgur.com/ca3y9nJ.png'),
  SportsCategory(type: 'ST', title: 'Squash Tennis', color: Colors.red, icon: 'https://i.imgur.com/qIUH8Wb.png'),
  // SportsCategory(type: 'SW', title: 'Swimming', color: Colors.blue),
];
//
//  final DUMMY_SPORTVENUES = [
//   VenueItem(typeOfSport: 'FB', title: 'Outdoor Football Field',
//       number: 1, capacity: 3,//TESTING REASONS
//       availablePeroids: '5:00PM to 9:00PM ', state: 'Open',
//       imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/The_Santiago_Bernabeu_Stadium_-_U-g-g-B-o-y.jpg/640px-The_Santiago_Bernabeu_Stadium_-_U-g-g-B-o-y.jpg'),
//
//   VenueItem(typeOfSport: 'FB', title: 'Outdoor Football Field',
//       number: 2, capacity: 16,
//       availablePeroids: '5:00PM to 9:00PM ', state: 'Open',
//       imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/The_Santiago_Bernabeu_Stadium_-_U-g-g-B-o-y.jpg/640px-The_Santiago_Bernabeu_Stadium_-_U-g-g-B-o-y.jpg'),
//
//   VenueItem(typeOfSport: 'FB', title: 'Indoor Football Field',
//       number: 1, capacity: 10,
//       availablePeroids: '5:00PM to 9:00PM ', state: 'Open',
//       imageUrl: 'https://media.istockphoto.com/id/520999573/nl/foto/indoor-soccer-football-field.jpg?s=612x612&w=0&k=20&c=kyMcnFo-gX_-vE1750Cdl3NJZS0o7uALyzrFPDGULe4='),
//
//    VenueItem(
//       imageUrl: 'https://cdn.versacourt.com/cmss_files/imagelibrary/general-use/thb-court-size.jpg',
//       typeOfSport: 'BB', title: 'Outdoor Basketball Field',
//       number: 1, capacity: 10,
//       availablePeroids: '5:00PM to 9:00PM ', state: 'Open',),
//
//    VenueItem(
//     imageUrl: 'https://static.giggster.com/images/location/4e67c26f-307a-456d-af76-c87f8e2dd7bd/d41ee185-8cf0-4b90-b589-03fae3413cdd/full_hd_retina.jpeg',
//     typeOfSport: 'BB', title: 'Indoor Basketball Field',
//     number: 1, capacity: 10,
//     availablePeroids: '5:00PM to 9:00PM ', state: 'Open',),
//
// ];
//
// //reservations
//   List<VenueItem> getReservedVenue(List<VenueItem> allVenues){
//     return allVenues.where((venue) => venue.typeOfSport == 'FB' && venue.title == 'Outdoor Football Field').toList();
//   }

  //  List<Reservation> getReservations(){
  //   return [
  //     Reservation(reservationNumber: 223,
  //         reservationDate: DateTime.parse('2023-03-20'),
  //         reservationStatus: 'pending',
  //         reservationTime: '6-8',
  //         reservedVenue: getReservedVenue(DUMMY_SPORTVENUES)[0],
  //         listOfAttendants: {'name': 'ahmed ahemd', 'id':'121'}),
  //     //
  //     // Reservation(reservationNumber: 1,
  //     //     reservationDate: DateTime.parse('2023-07-02'),
  //     //     reservationStatus: 'pending',
  //     //     reservationTime: '4-6',
  //     //     reservedVenue: getReservedVenue(DUMMY_SPORTVENUES)[0],
  //     //     listOfAttendants: {'name': 'ahmed ahemd', 'id':'121'}),
  //     //
  //     // Reservation(reservationNumber: 1,
  //     //     reservationDate: DateTime.parse('2023-04-13'),
  //     //     reservationStatus: 'pending',
  //     //     reservationTime: '8-10',
  //     //     reservedVenue: getReservedVenue(DUMMY_SPORTVENUES)[0],
  //     //     listOfAttendants: {'name': 'ahmed ahemd', 'id':'121'}),
  //
  //   ];
  // }

  // updateList(Reservation r){
  //   l = getReservations();
  //   l.add(r);
  //   l = l;
  // }