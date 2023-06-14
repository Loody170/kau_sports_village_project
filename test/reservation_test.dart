import 'package:flutter_test/flutter_test.dart';
import 'package:kau_sports_village_project/models/reservation.dart';

void main() {
  test('Reservation.fromJson() test', () {
    final Map<String, dynamic> json = {
      'number': 1,
      'status': 'confirmed',
      'date': '2023-06-08',
      'venueName': 'Football field 1',
      'venueNumber': 123,
      'time': '10:00 AM',
      'listOfAttendants': {'attendant1': 'Khalid', 'attendant2': 'Naif'},
      'venueType': 'FB'
    };

    final Reservation reservation = Reservation.fromJson(json);
    expect(reservation.reservationNumber, 1);
    expect(reservation.reservationStatus, 'confirmed');
    expect(reservation.formattedDate, '2023-06-08');
    expect(reservation.reservedVenueName, 'Football field 1');
    expect(reservation.reservedVenueNumber, 123);
    expect(reservation.reservationTime, '10:00 AM');
    expect(reservation.listOfAttendants, {'attendant1': 'Khalid', 'attendant2': 'Naif'});
    expect(reservation.reservedVenueType, 'FB');
  });
}
