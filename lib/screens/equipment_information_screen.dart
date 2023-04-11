import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kau_sports_village_project/models/gym_equipment.dart';
import 'package:firebase_storage/firebase_storage.dart';


class EquipmentInformationScreen extends StatelessWidget {
  static const routeName = '/equipment-info';
  late String receivedArgs;
  final FirebaseStorage storage = FirebaseStorage.instance;
  late String imageUrl1 = ' ';
  late String imageUrl2;
  int counter = 0;


  Future<String> getImageUrl(String path) async {
    final ref = FirebaseStorage.instance.ref()
        .child(path);
    final url = await ref.getDownloadURL();
     return url.toString();
  }

  Future<GymEquipment>
  readGymEquipment(String equipmentName) async {
    String pathSuffix = 'Workout';

  getImageUrl('$equipmentName/$equipmentName.jpg').then((value) => imageUrl1 = value);


    final DocumentSnapshot ref = await FirebaseFirestore.instance
        .collection('gym_equipment_tips')
        .doc('$equipmentName')
        .get();
    print('printing treadmillll...');
    print(ref.data());
    GymEquipment equipment = GymEquipment.fromJson(ref.data() as Map<String, dynamic>);
    print('printing obj');
    print(equipment);
    return equipment;

    // .then((value){
            // if(value.exists){
            //   Map<String, dynamic>? data = value.data();
            //   GymEquipment equipment = GymEquipment.fromJson(data!, 'imageUrl1', 'imageUrl2');
            //   print('isnide value and printing obj');
            //   print(equipment);
            //   return equipment;
            // }
            // else{
            //   print('nooooo');
             //}
      //})

  }

  List<Widget> makeTips(GymEquipment equipment){
    List<Widget> myWidgets = [];

    for (int i = 0; i < equipment.workoutTips.length; i++) {
      myWidgets.add(
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('${i + 1}. ${equipment.workoutTips[i]}', style: GoogleFonts.kanit(fontSize: 20),))
      );

      myWidgets.add(SizedBox(height: 20,));
    }
    return myWidgets;

  }


  @override
  Widget build(BuildContext context) {
    receivedArgs = ModalRoute.of(context)?.settings.arguments as String;
    // readGymEquipment();

    return Scaffold(
      appBar: AppBar(title: Text('The $receivedArgs')),
      body: FutureBuilder(
        future: readGymEquipment(receivedArgs),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            GymEquipment equipment = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [

                 FutureBuilder(
                   future: getImageUrl('$receivedArgs/$receivedArgs.jpg'),
                    builder: (context, snapshot) {
                    if(snapshot.hasData){
                        return Container(
                          height: 350,
                          width: 420,
                         child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              child: Image.network(
                                snapshot.data!,
                                fit: BoxFit.fill,
                        )),
                  );
                }
                     else
                       return Text('loading...');
              },
              ),

                  Container(padding: EdgeInsets.all(5), margin: EdgeInsets.all(5),
                    child: Text(equipment.name, style: GoogleFonts.lora(fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                  Container(padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(equipment.description, textAlign: TextAlign.center,
                        style: GoogleFonts.notoSans(fontSize: 15),)),
                  Container(margin: EdgeInsets.symmetric(vertical: 18),
                      child: Text('Tips For Exercising', style: GoogleFonts.kanit(fontSize: 25),)),

                  FutureBuilder(
                    future: getImageUrl('$receivedArgs/${receivedArgs}Workout.jpg'),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return Container(
                          height: 350,
                          width: 420,
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              child: Image.network(
                                snapshot.data!,
                                fit: BoxFit.fill,
                              )),
                        );
                      }
                      else
                        return Text('loading...');
                    },
                  ),



                  Column(children: 

                  makeTips(equipment)
                  // equipment.workoutTips.map((e){
                  //   return Text(equipment.workoutTips[]);
                  // }).toList()

                  ,)

                ],
                
              ),);

          }
          return Text('loading...');
        })

    );
  }
}


// return FutureBuilder(
// future: getImageUrl('treadmill/treadmillWorkout.jpg'),
// builder: (context, snapshot) {
// if(snapshot.hasData){
// return Image.network(snapshot.data!);
// }
// else
// return Placeholder();
// },
// );