import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kau_sports_village_project/app_data.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:kau_sports_village_project/insertEquipment.dart';
import 'package:kau_sports_village_project/screens/equipment_history_screen.dart';
import 'dart:io';

import 'package:kau_sports_village_project/screens/equipment_information_screen.dart';

import '../models/gym_equipment.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class GymAssistantScreen extends StatefulWidget {
  static const routeName = '/gym-assistant';

  @override
  State<GymAssistantScreen> createState() => GymAssistantScreenState();
}

class GymAssistantScreenState extends State<GymAssistantScreen> {
  String getResult = 'equipment info';

  Future<bool> checkDocumentExists(String documentId) async {
    final documentSnapshot = await FirebaseFirestore.instance.collection('gym_equipment_tips').doc(documentId).get();
    return documentSnapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: SingleChildScrollView(
            child: Column(
        children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/qr_code.jpg',
                        fit: BoxFit.cover),
              ),
            ),
            Text('Scan the QR Code put on any gym equipment in KAU Sports Village gym hall, and we will give you help and tips about it! ', style: GoogleFonts.kanit(fontSize: 20),
              textAlign: TextAlign.center,),
            SizedBox(height: 50,),

            ElevatedButton(
              onPressed: () {
                scanQRCode();

              },
              child: Container(
                width: 145,
                child: Row(

                  children: [
                  Icon(Icons.camera_alt),
                  Text(' Turn on Camera')
                ],),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),

            ElevatedButton(onPressed: (){
              getResult =
              // 'Precor Prone Leg Curl';
              'Precor Prone Leg Cur';
              EquipmentHistoryScreen.addEquipmentName(getResult);

              //getiinfo(getResult);
              Navigator.of(context).pushNamed(EquipmentInformationScreen.routeName, arguments: getResult);

            }, child: Text('test qr code')),
          SizedBox(height: 20,),

          ElevatedButton(onPressed: (){
            GymEquipment equipment1 =
            GymEquipment(
                name: 'Precor Prone Leg Curl',
                description: 'A machine that targets the hamstrings. Users lie on their stomachs and curl their legs upward against resistance to build strength in the back of the thighs.',
                workoutTips: [
                  'When using the machine, make sure to keep your upper body stable and avoid arching your back. Focus on contracting your hamstring muscles as you lift the weight towards your buttocks,',
                  'Make sure to adjust the seat and leg pads to fit your body size. The leg pad should be placed just above your ankles, and the seat should be adjusted to ensure that your knees are in line with the pivot point of the machine.',
                  'Breathe correctly: Remember to inhale as you lower the weight and exhale as you lift it up. This will help you maintain proper form and prevent any strain on your muscles.'
                ]);

            insertEquipment.addEquipment(equipment1);

          }, child: Text('Insert equipment (dev tool dont press)')),

        ],
      ),
          ));
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) {
        return;
      }
      setState(() {
        getResult = qrCode;
      });
      if(qrCode == '-1'){
        return;
      }
      else if(! await checkDocumentExists(getResult)){
        print('inavlid barcode');
        return;
      }

      else {
        print("QRCode_Result:--");
        EquipmentHistoryScreen.addEquipmentName(getResult);
        Navigator.of(context).pushNamed(
            EquipmentInformationScreen.routeName, arguments: getResult);
        //getiinfo(getResult);
      }
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }

  // getiinfo(String key) async {
  //   final DocumentSnapshot info = await FirebaseFirestore.instance
  //       .collection('equipment_info')
  //       .doc(key)
  //       .get();
  // }
    // String _name = info.get('name');
    // String _des = info.get('description');
    // String _info = info.get('info');
    // print("name $_name");
    // print("description $_des");
    // print("information $_info");
    // infocard(_name, _des, _info);


  // Widget infocard(String name, String des, String info) {
  //   return Card(
  //     margin: const EdgeInsets.all(20),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.max,
  //       children: <Widget>[
  //         ListTile(
  //           title: const Text('name'),
  //           subtitle: const Text('des'),
  //         ),
  //       ],
  //     ),
  //   );
  // }


}
