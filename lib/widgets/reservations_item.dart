import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ReservationItem extends StatelessWidget {
  late String venueName;
  late String venueImage;
  late DateTime reservedDate;
  var format = DateFormat('yyyy-MM-dd');
  late String peroid;
  late String reservationStatus;

  String formatDate(){
    return format.format(reservedDate);
  }

  ReservationItem({required this.venueName, required this.venueImage, required this.reservedDate,
    required this.peroid, required this.reservationStatus});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(15)
                        ),
                         child: Image.network(venueImage, height: 100, width: 100, fit: BoxFit.cover,)),
              title: Text(venueName),
              subtitle: Row(children: [
                Icon(Icons.timelapse), Text(formatDate()), Text(peroid),
              ],),
               //TODO: complete this widget :)
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     TextButton(
            //       child: const Text('BUY TICKETS'),
            //       onPressed: () {/* ... */},
            //     ),
            //     const SizedBox(width: 8),
            //     TextButton(
            //       child: const Text('LISTEN'),
            //       onPressed: () {/* ... */},
            //     ),
            //     const SizedBox(width: 30),
            //   ],
            // ),

          ],
        ),
      ),
    );







    //   Container(decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(15)
    // ),
    //   child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black) ),
    //     child: Row(children: [
    //       ClipRRect(
    //          borderRadius: BorderRadius.all(Radius.circular(15)
    //            ),
    //             child: Image.network(venueImage, height: 75, width: 75, fit: BoxFit.cover,))
    //
    //     ],),
    //   ),
    // );


  }
}
