import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kau_sports_village_project/models/gym_equipment.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kau_sports_village_project/screens/user_profile_screen.dart';
import '../models/app_user.dart';

class EquipmentInformationScreen extends StatelessWidget {
  static const routeName = '/equipment-info';
  late String receivedArgs;
  final FirebaseStorage storage = FirebaseStorage.instance;
  late String imageUrl1 = ' ';
  late String imageUrl2;
  int counter = 0;
  String guestHeight = '';
  String guestWeight = '';


  Future<String> getImageUrl(String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    final url = await ref.getDownloadURL();
    return url.toString();
  }
  Stream<AppUser>
  getUser() {
    return
      FirebaseFirestore.instance
          .collection('users').doc(FirebaseAuth.instance.currentUser?.uid).snapshots().map((event) {
        return
          AppUser.fromJson(event.data()!);
      });
  }

  Future<GymEquipment> readGymEquipment(String equipmentName) async {
    String pathSuffix = 'Workout';

    getImageUrl('$equipmentName/$equipmentName.jpg')
        .then((value) => imageUrl1 = value);

    final DocumentSnapshot ref = await FirebaseFirestore.instance
        .collection('gym_equipment_tips')
        .doc(equipmentName)
        .get();
    print('printing treadmillll...');
    print(ref.data());
    GymEquipment equipment =
        GymEquipment.fromJson(ref.data() as Map<String, dynamic>);
    print('printing obj');
    print(equipment);
    return equipment;

  }

  List<Widget> makeTips(GymEquipment equipment) {
    List<Widget> myWidgets = [];
    for (int i = 0; i < equipment.workoutTips.length; i++) {
      myWidgets.add(Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '${i + 1}. ${equipment.workoutTips[i]}',
            style: GoogleFonts.kanit(fontSize: 20),
          )));
      myWidgets.add(SizedBox(
        height: 20,
      ));
    }
    return myWidgets;
  }

  List<Widget> makeWorkouts(List<String> workouts) {
    List<Widget> myWidgets = [];
    for (int i = 0; i < workouts.length; i++) {
      myWidgets.add(Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '${i + 1}. ${workouts[i]}',
            style: GoogleFonts.kanit(fontSize: 20),
          )));
      myWidgets.add(SizedBox(
        height: 20,
      ));
    }
    return myWidgets;
  }

  Widget userProfileDialog(BuildContext context) {
    Widget yesButton = TextButton(
      child: Text("Go to My Profile"),
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName);
      },
    );
    Widget noButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Information Required"),
      content: Text(
          "Fill your height and weight from your profile to use this feature"),
      actions: [
        yesButton,
        noButton,
      ],
    );
    return alert;
  }
  
  Widget guestUserDialog(BuildContext context, GymEquipment equipment){
    final _formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: Text('Enter your height and weight to calculate your BMI and give you a proper workout',
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,),
      content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  hintText: 'Enter your height in cm',
                  icon: Icon(Icons.height),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  final double? height = double.tryParse(value);
                  if (height == null || height <= 0) {
                    return 'Please enter a valid height';
                  }
                  return null;
                },
                onSaved: (value) => guestHeight = value!,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  hintText: 'Enter your weight in kg',
                  icon: Icon(Icons.line_weight),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  final double? weight = double.tryParse(value);
                  if (weight == null || weight <= 0) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
                onSaved: (value) => guestWeight = value!,
              ),
              SizedBox(height: 16),
            ],
          ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: (){
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              print(guestHeight);
              print(guestWeight);
              if(guestHeight != '' && guestWeight!= ''){
                Navigator.of(context).pop();
                makeBottomSheet(context, equipment, guestHeight, guestWeight);
              }
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  void makeBottomSheet(BuildContext context, GymEquipment equipment, String height, String weight){
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        String bmiClass = '';
        double bmi = 0.0;
        if(height != '' && weight != ''){
         bmiClass = getBMIClass(height, weight);
         bmi = calculateBMI(height, weight);
         print(bmiClass);
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.60,
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Workouts', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),),
                SizedBox(height: 10.0),
                Text('Based on your height and weight, your BMI is ${bmi.toStringAsFixed(2)}.'
                    '\nhere is a workout for a $bmiClass',
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,),
                SizedBox(height: 10.0),
                StreamBuilder(
                    stream: getEquipmentWorkout(equipment, bmiClass),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        var workoutsList = snapshot.data!;
                        print('PRINTING WORKOUT');
                        print(snapshot.data!);
                        return Column(children:
                          makeWorkouts(workoutsList)
                        ,);
                      }
                      else
                        return Text('loading...');
                      },
                )

       ]),
          )
        );
      },
    );
  }

  Stream<List<String>> getEquipmentWorkout(GymEquipment equipment, String chosenWorkOut){
    print('chosen work out for $chosenWorkOut');
    return FirebaseFirestore.instance
        .collection('gym_equipment_workouts')
        .doc(equipment.name)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      List<String> workoutList = [];
      print('DOC CHECKING!!');
      if (documentSnapshot.exists) {
        print('DOC EXIST!!');
        var data = documentSnapshot.data() as Map<String, dynamic>;
        if (data != null && data.containsKey(chosenWorkOut)) {
          print('FIELD EXIST');
          workoutList = List<String>.from(data[chosenWorkOut]);
        }
      }
      return workoutList;
    });
  }

  double calculateBMI(String heightStr, String weightStr){
    double height = double.parse(heightStr);
    double weight = double.parse(weightStr);
    return (weight / ((height / 100) * (height / 100)));
  }

  String getBMIClass(String heightStr, String weightStr){
    double height = double.parse(heightStr);
    double weight = double.parse(weightStr);

    double bmi = weight / ((height / 100) * (height / 100));
    print('bmi is$bmi');

    if (bmi >= 18.5 && bmi <= 24.9) {
      return 'BMI between 18.5-24.9';
    } else if (bmi >= 25 && bmi <= 29.9) {
      return 'BMI between 25-29.9';
    } else {
      return 'BMI above 30';
    }
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
                          if (snapshot.hasData) {
                            return Container(
                              height: 350,
                              width: 420,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  child: Image.network(
                                    snapshot.data!,
                                    fit: BoxFit.fill,
                                  )),
                            );
                          } else
                            return Text('loading...');
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                        child: Text(
                          equipment.name,
                          style: GoogleFonts.lora(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            equipment.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSans(fontSize: 15),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 18),
                          child: Text(
                            'Tips For Exercising',
                            style: GoogleFonts.kanit(fontSize: 25),
                          )),
                      FutureBuilder(
                        future: getImageUrl(
                            '$receivedArgs/${receivedArgs}Workout.jpg'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              height: 350,
                              width: 420,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  child: Image.network(
                                    snapshot.data!,
                                    fit: BoxFit.fill,
                                  )),
                            );
                          } else
                            return Text('loading...');
                        },
                      ),
                      Column(
                        children: makeTips(equipment),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 25.0, top: 1),
                        margin: EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                          child: Text(
                            'Suggest me a workout',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[800]),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orangeAccent,
                          ),
                          onPressed: (FirebaseAuth.instance.currentUser != null )?(){
                            Future<AppUser> appUser = getUser().first;
                            appUser.then((appUser) {
                              if(appUser.height.isEmpty || appUser.weight.isEmpty){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return userProfileDialog(context);
                                    });
                              }

                              else{
                                makeBottomSheet(context, equipment, appUser.height, appUser.weight);
                              }
                            });
                                }
                                : (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return guestUserDialog(context, equipment);
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Text('loading...');
            }));
  }
}

