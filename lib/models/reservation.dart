import 'package:kau_sports_village_project/models/sport_venue.dart';

import '../widgets/venue_item.dart';

class Reservation{
  final int reservationNumber;
  final DateTime reservationDate;
  final String reservationStatus;
  final String reservationTime;
  //final user booker
  final VenueItem reservedVenue;
  final Map listOfAttendants;

   Reservation({
    required this.reservationNumber,
  required this.reservationDate,
  required this.reservationStatus,
  required this.reservationTime,
  required this.reservedVenue,
  required this.listOfAttendants});
}