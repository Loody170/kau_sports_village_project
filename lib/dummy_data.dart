import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/models/reservation.dart';
import 'package:kau_sports_village_project/models/sport_venue.dart';
import 'models/category.dart';

const DUMMY_CATEGORIES = const [
  SportsCategory(type: 'FB', title: 'Football', color: Colors.green),
  SportsCategory(type: 'BB', title: 'Basketball', color: Colors.deepOrange),
  SportsCategory(type: 'VB', title: 'Volleyball', color: Colors.yellow),
  SportsCategory(type: 'ST', title: 'Squash Tennis', color: Colors.red),
  SportsCategory(type: 'SW', title: 'Swimming', color: Colors.blue),
];

const DUMMY_SPORTVENUES = const [
  SportVenue(typeOfSport: 'FB', title: 'Outdoor Football Field',
      number: 1, capacity: 16,
      availablePeroids: '5:00PM to 9:00PM ', state: 'Open',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/The_Santiago_Bernabeu_Stadium_-_U-g-g-B-o-y.jpg/640px-The_Santiago_Bernabeu_Stadium_-_U-g-g-B-o-y.jpg'),

  SportVenue(typeOfSport: 'FB', title: 'Outdoor Football Field',
      number: 2, capacity: 16,
      availablePeroids: '5:00PM to 9:00PM ', state: 'Open',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/The_Santiago_Bernabeu_Stadium_-_U-g-g-B-o-y.jpg/640px-The_Santiago_Bernabeu_Stadium_-_U-g-g-B-o-y.jpg'),

  SportVenue(typeOfSport: 'FB', title: 'Indoor Football Field',
      number: 1, capacity: 10,
      availablePeroids: '5:00PM to 9:00PM ', state: 'Open',
      imageUrl: 'https://media.istockphoto.com/id/520999573/nl/foto/indoor-soccer-football-field.jpg?s=612x612&w=0&k=20&c=kyMcnFo-gX_-vE1750Cdl3NJZS0o7uALyzrFPDGULe4='),

  SportVenue(
      imageUrl: 'https://cdn.versacourt.com/cmss_files/imagelibrary/general-use/thb-court-size.jpg',
      typeOfSport: 'BB', title: 'Outdoor Basketball Field',
      number: 1, capacity: 10,
      availablePeroids: '5:00PM to 9:00PM ', state: 'Open',),

  SportVenue(
    imageUrl: 'https://static.giggster.com/images/location/4e67c26f-307a-456d-af76-c87f8e2dd7bd/d41ee185-8cf0-4b90-b589-03fae3413cdd/full_hd_retina.jpeg',
    typeOfSport: 'BB', title: 'Indoor Basketball Field',
    number: 1, capacity: 10,
    availablePeroids: '5:00PM to 9:00PM ', state: 'Open',),

];

//reservations
  List<SportVenue> getReservedVenue(List<SportVenue> allVenues){
    return allVenues.where((venue) => venue.typeOfSport == 'FB' && venue.title == 'Outdoor Football Field').toList();
  }

   List<Reservation> getReservations(){
    return [
      Reservation(reservationNumber: 1,
          reservationDate: DateTime.now(),
          reservationStatus: 'pending',
          reservationTime: '8-10',
          reservedVenue: getReservedVenue(DUMMY_SPORTVENUES)[0],
          listOfAttendants: [{'name': 'ahmed ahemd', 'id':'121'}]),

      Reservation(reservationNumber: 1,
          reservationDate: DateTime.parse('2023-07-02'),
          reservationStatus: 'pending',
          reservationTime: '4-6',
          reservedVenue: getReservedVenue(DUMMY_SPORTVENUES)[0],
          listOfAttendants: [{'name': 'ahmed ahemd', 'id':'121'}]),

      Reservation(reservationNumber: 1,
          reservationDate: DateTime.parse('2023-04-13'),
          reservationStatus: 'pending',
          reservationTime: '8-10',
          reservedVenue: getReservedVenue(DUMMY_SPORTVENUES)[0],
          listOfAttendants: [{'name': 'ahmed ahemd', 'id':'121'}]),






    ];
  }