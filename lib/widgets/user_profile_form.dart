import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kau_sports_village_project/widgets/sign_up_form.dart';

import '../models/app_user.dart';

class UserProfileForm extends StatelessWidget {
   String firstName = '';
   String lastName = '';
   String role = '';
   String department = '';
   String universityId = '';
   String phoneNumber = '';
   String height = '';
   String weight = '';

   late VoidCallback updateScreen;

   UserProfileForm(this.updateScreen);

  InputDecoration getInputDecoration(String hintText){
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(12),
      ),
      hintText: hintText,
      fillColor: Colors.grey[200],
      filled: true,
    );
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

  List<String> catagories = ['Student', 'Faculty Member', 'Employee'];
  late String chosenValue;


  final _form = GlobalKey<FormState>();

  void saveForm(){
    _form.currentState?.save();
    print('fname $firstName lname $lastName roel $role department $department kau id $universityId phone number $phoneNumber height $height weight $weight');
  }

  bool validateForm(){
    bool? isValid =_form.currentState?.validate();
    if(isValid!)
      return true;
    else
      return false;
  }

  Future updateUserInfo() async{
    Map <String, dynamic> data = {};

    if (firstName.isNotEmpty) {
      data['firstName'] = firstName;
    }

    if (lastName.isNotEmpty) {
      data['lastName'] = lastName;
    }

    if (role.isNotEmpty) {
      data['Role'] = role;
    }

    if (department.isNotEmpty) {
      data['Department'] = department;
    }

    if (universityId.isNotEmpty) {
      data['KAU ID'] = universityId;
    }

    if (phoneNumber.isNotEmpty) {
      data['Phone Number'] = phoneNumber;
    }

    if (height.isNotEmpty) {
      data['Height'] = height;
    }

    if (weight.isNotEmpty) {
      data['Weight'] = weight;
    }

    print(data);

    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set(data, SetOptions(merge: true));
    //     {
    //   'First Name': firstName,
    //   'Last Name': lastName,
    //   'Role': role,
    //   'Department': department,
    //   'KAU ID': universityId,
    //   'Phone Number': phoneNumber,
    // }



  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getUser(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          AppUser user = snapshot.data!;
          return
            Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                        child: Text('User Information', style: GoogleFonts.roboto(fontSize: 25, ))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25,),
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(
                            decoration: getInputDecoration(user.fName),
                            onSaved: (value) {
                              firstName = value as String;
                            },
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                                if (!nameRegex.hasMatch(value as String)) {
                                  return 'Name is Invalid';
                                }
                              }

                            },
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextFormField(
                            decoration: getInputDecoration(user.lName),
                            onSaved: (value) {
                              lastName = value as String;
                            },
                            validator: (value){
                              if(value!.isNotEmpty){
                              RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                              if(!nameRegex.hasMatch(value as String)){
                                return 'Name is Invalid';
                              }
                            }},
                          ),
                        ),
                      ],),
                    ),
                    SizedBox(height: 10,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(children: [
                        Expanded(
                            child:
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              hint: Text(user.role),
                              items: catagories.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged:(value){
                                chosenValue = value as String;
                                print('vlauee izzz' + chosenValue);
                              } ,

                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              onSaved: (value) {
                                if (value != null) {
                                  role = value as String;
                                }
                              },
                            )
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextFormField(
                            decoration: getInputDecoration(user.department),
                            onSaved: (value) => department = value as String,
                            validator: (value){
                              if(value!.isNotEmpty){
                              RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                              if(!nameRegex.hasMatch(value as String)){
                                return 'Department is Invalid';
                              }
                            }},
                          ),
                        ),
                      ],),
                    ),
                    SizedBox(height: 10,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25,),
                      child: TextFormField(
                        decoration: getInputDecoration(user.kauID),
                        onSaved: (value) => universityId = value as String,
                        validator: (value){
                          if(value!.isNotEmpty){
                          RegExp numberRegex = RegExp(r'^[1-2]\d{6}$');
                          if(!numberRegex.hasMatch(value as String)){
                            return 'Entered University ID is invalid';
                          }
                        }},
                      ),
                    ),
                    SizedBox(height: 10,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25,),
                      child: TextFormField(
                        decoration: getInputDecoration(user.phoneNum),
                        onSaved: (value) => phoneNumber = value as String,
                        validator: (value){
                          if(value!.isNotEmpty){
                          RegExp phoneRegex = RegExp(r'^0(5)[^123][0-9]{7}$');
                          if(!phoneRegex.hasMatch(value as String)){
                            return 'Phone number is invalid';
                          }
                        }},
                      ),
                    ),


                    SizedBox(height: 10,),

                    Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
                        child: Text('Health Information', style: GoogleFonts.roboto(fontSize: 25, ))),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
                      child: Text('Used when suggesting gym workouts based on your BMI', style: GoogleFonts.roboto(fontSize: 16),textAlign: TextAlign.center,),
                    ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,),
                child: Row(children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Height (Centemeter)', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),),
                        TextFormField(
                          decoration: getInputDecoration(user.height,),
                          onSaved: (value) {
                            height = value as String;
                          },
                          validator: (value){
                            if(value!.isNotEmpty){
                            RegExp nameRegex = RegExp(r'^\d{1,3}$');
                            if(!nameRegex.hasMatch(value as String)){
                              return 'Height is Invalid';
                            }
                          }},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Weight (KG)', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),),
                        TextFormField(
                          decoration: getInputDecoration(user.weight),
                          onSaved: (value) {
                            weight = value as String;
                          },
                          validator: (value){
                            if(value!.isNotEmpty){
                            RegExp nameRegex = RegExp(r'^\d{1,3}$');
                            if(!nameRegex.hasMatch(value as String)){
                              return 'Weight is Invalid';
                            }
                          }},
                        ),
                      ],
                    ),
                  ),
                ],),),

                    SizedBox(height: 15,),

                    Padding(padding: const EdgeInsets.symmetric(horizontal: 150.0,),
                        child: GestureDetector(
                          onTap: (){
                            if(validateForm()) {
                              saveForm();
                             updateUserInfo();
                             updateScreen();
                            }
                            else
                              return;
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                          ),
                        )
                    ),

                  ],),
                ));
        }
        else{
          return Text('Loading...');
        }

      },

    );

  }
}
