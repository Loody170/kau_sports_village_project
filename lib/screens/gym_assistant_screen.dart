import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:kau_sports_village_project/screens/equipment_history_screen.dart';
import 'package:kau_sports_village_project/screens/equipment_information_screen.dart';

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
            Text('Scan the QR Code put on any gym equipment in KAU Sports Village gym hall,'
                ' and we will give you help and tips about it! ', style: GoogleFonts.kanit(fontSize: 20),
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

            // ElevatedButton(onPressed: (){
            //   getResult = 'Precor Prone Leg Curl';
            //   EquipmentHistoryScreen.addEquipmentName(getResult);
            //   Navigator.of(context).pushNamed(EquipmentInformationScreen.routeName, arguments: getResult);
            // }, child: Text('test qr code')),

            // SizedBox(height: 20,),

          // ElevatedButton(onPressed: (){
          //   GymEquipment equipment1 =
          //   GymEquipment(
          //       name: 'Matrix Performance Climb Mill',
          //       description: 'A machine that works with your body weight and activates the major muscle groups in your lower body — including your glutes, quadriceps, hamstrings, and calves.',
          //       workoutTips: [
          //         'Maintain Your Posture: To put strain on the right parts of your body—the glutes and hamstrings instead of your back—slow down and get your posture right. "When youre hunched over, youre putting strain on your back and turning down your glutes" ',
          //        ' Dont Hold On:  If youre feeling off-balance, lightly grasping the sides will help you get steady. But dont rely on them to hold you up. That reduces the load of your body on the stairs and reduces the effectiveness of your StairMaster workout.',
          //       'Switch It Up: Going forward targets your glutes and hamstrings, but if youre looking to work your quads, turn around and complete part of your StairMaster workout backward.',
          //       ]);
          //   insertEquipment.addEquipment(equipment1);
          // }, child: Text('Insert equipment (dev tool dont press)')),
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
        print(getResult);
        print('inavlid barcode');
        return;
      }
      else {
        print("QRCode_Result:--");
        EquipmentHistoryScreen.addEquipmentName(getResult);
        Navigator.of(context).pushNamed(
            EquipmentInformationScreen.routeName, arguments: getResult);
      }
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }
}
