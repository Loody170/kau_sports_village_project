import 'dart:ffi';

import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {

  Widget buildFormField(String hintText, bool obscureVar, Function validator, String target){
    return TextFormField(decoration: InputDecoration(
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
    ),
      obscureText: obscureVar,
      validator: (value){validator();},
      onSaved: (value){
      print('entered');
      target = value as String;},
    );
  }

  List<String> catagories = ['Student', 'Faculty Member', 'Employee'];
  late String chosenValue;

  late String firstName ='';
  late String lastName ='';
  late String role='';
  late String department='';
  late String universityId='';
  late String phoneNumber='';
  late String email='';

  final _form = GlobalKey<FormState>();

  void saveForm(){
    _form.currentState?.save();
  }
  bool validateForm(){
    bool? v =_form.currentState?.validate();
    if(!v!)
      return false;
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(child: SingleChildScrollView(
      child: Column(children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: Row(children: [
            Expanded(
                child: buildFormField('First Name', false, (value){}, firstName),
            ),
            SizedBox(width: 10,),
            Expanded(
                child: buildFormField('Last Name', false, (value){}, lastName),
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
                  hint: Text('Who are you?'),
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
                )
            ),
            SizedBox(width: 10,),
            Expanded(
              child: buildFormField('Faculty\\Department', false, (value){}, department),
            ),
          ],),
        ),
        SizedBox(height: 10,),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: buildFormField('KAU ID', false, (value){}, universityId)
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: buildFormField('Phone Number', false, (value){}, phoneNumber)
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: buildFormField('Email', false, (value){}, email)
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: buildFormField('Password', true, (value){}, '')
        ),

        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: buildFormField('Confirm password', true, (value){}, ''),
        ),
        SizedBox(height: 10,),

        Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: (){
                _form.currentState?.save();
                print(firstName + lastName + phoneNumber + universityId + department + email);
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text('Sign up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                ),
              ),
            )
        ),



      ],),
    ));
  }
}
