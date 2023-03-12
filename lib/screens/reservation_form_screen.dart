import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/widgets/reservation_form.dart';

class ReservationFormScreen extends StatefulWidget {
  static final String routeName = 'reservation-form';


  @override
  State<ReservationFormScreen> createState() => _ReservationFormScreenState();
}

class _ReservationFormScreenState extends State<ReservationFormScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as List;
    print(routeArgs[2]);

    return Scaffold(appBar: AppBar(title: Text('booking form'),),
      body: ReservationForm(routeArgs[0]?.capacity));
  }
}

