import 'package:kau_sports_village_project/models/sport_venue.dart';

import '../widgets/venue_item.dart';

class Reservation{
  final int reservationNumber;
  late DateTime reservationDate;
  final String formattedDate;
  final String reservationStatus;
  final String reservationTime;
  final String reservedVenueName;
  final int reservedVenueNumber;
  final String reservedVenueType;
  final Map listOfAttendants;

   Reservation({
    required this.reservationNumber,
  required this.formattedDate,
  required this.reservationStatus,
  required this.reservationTime,
     required this.reservedVenueName,
     required this.reservedVenueNumber,
     required this.listOfAttendants,
     required this.reservedVenueType
   });

  static Reservation fromJson(Map<String, dynamic> map){
    return Reservation(
        reservationNumber: map['number'],
        reservationStatus: map['status'],
        formattedDate: map['date'],
        reservedVenueName: map['venueName'],
        reservedVenueNumber: map['venueNumber'],
        reservationTime: map['time'],
        listOfAttendants: map['listOfAttendants'],
        reservedVenueType: map['venueType']
    );
  }

  static Map<String, dynamic> toJson(Reservation reservation, String uid, String venueType){
    return{
          'number': reservation.reservationNumber,
          'status': reservation.reservationStatus,
          'date': reservation.formattedDate,
          'venueName': reservation.reservedVenueName,
          'venueNumber': reservation.reservedVenueNumber,
          'time': reservation.reservationTime,
          'listOfAttendants': reservation.listOfAttendants,
          'user': uid,
          'venueType': reservation.reservedVenueType
        };
  }


}