import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:kau_sports_village_project/dummy_data.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:io';
//import 'package:image_picker/image_picker.dart';
//import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class GymAssistantScreen extends StatefulWidget {
  static const routeName = '/gym-assistant';

  @override
  State<GymAssistantScreen> createState() => GymAssistantScreenState();
}

class GymAssistantScreenState extends State<GymAssistantScreen> {
  String getResult = 'equipment info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KAU Gym assistant'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              scanQRCode();
              print('dd');
            },
            child: Text('Scan QR'),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      )),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
      print("QRCode_Result:--");
      getiinfo(getResult);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }

  getiinfo(String key) async {
    final DocumentSnapshot info = await FirebaseFirestore.instance
        .collection('equipment_info')
        .doc(key)
        .get();

    String _name = info.get('name');
    String _des = info.get('description');
    String _info = info.get('info');
    print("name $_name");
    print("description $_des");
    print("information $_info");
    infocard(_name, _des, _info);
  }

  Widget infocard(String name, String des, String info) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            title: const Text('name'),
            subtitle: const Text('des'),
          ),
        ],
      ),
    );
  }
}
