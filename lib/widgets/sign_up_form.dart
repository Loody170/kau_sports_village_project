import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpForm extends StatelessWidget {

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

  List<String> catagories = ['Student', 'Faculty Member', 'Employee'];
  late String chosenValue;

  late String firstName;
  late String lastName;
  late String role;
  late String department;
  late String universityId;
  late String phoneNumber;
  late String email;
  late String _password;
  late String _password2;

  final _form = GlobalKey<FormState>();

  void saveForm(){
    _form.currentState?.save();
    print('fname $firstName lname $lastName roel $role department $department kau id $universityId phone number $phoneNumber email $email');
  }
  bool validateForm(){
    bool? v =_form.currentState?.validate();
    if(!v!)
      return false;
    else
      return true;
  }

  Future signUp() async{
    var authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
    password: _password);
    FirebaseFirestore.instance.collection('users').doc(authResult.user?.uid).set({
      'First Name': firstName,
      'Last Name': lastName,
      'Role': role,
      'Department': department,
      'KAU ID': universityId,
      'Phone Number': phoneNumber,
      'Email': email
    });


  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
        child: SingleChildScrollView(
      child: Column(children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: Row(children: [
            Expanded(
                child: TextFormField(
                  decoration: getInputDecoration('First Name'),
                  onSaved: (value) {
                    firstName = value as String;
                    },
                ),
            ),
            SizedBox(width: 10,),
            Expanded(
                child: TextFormField(
                  decoration: getInputDecoration('Last Name'),
                  onSaved: (value) {
                    lastName = value as String;
                  },
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
                  onSaved: (value){role = value as String;},
                )
            ),
            SizedBox(width: 10,),
            Expanded(
              child: TextFormField(
                decoration: getInputDecoration('Faculty\\Department'),
                onSaved: (value) => department = value as String,
              ),
            ),
          ],),
        ),
        SizedBox(height: 10,),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: TextFormField(
           decoration: getInputDecoration('KAU ID'),
            onSaved: (value) => universityId = value as String,
          ),
        ),
        SizedBox(height: 10,),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: TextFormField(
            decoration: getInputDecoration('Phone Number'),
            onSaved: (value) => phoneNumber = value as String,
          ),
        ),

        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: TextFormField(
            decoration: getInputDecoration('Email'),
            onSaved: (value) => email = value as String,
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: TextFormField(
            decoration: getInputDecoration('Password'),
            onSaved: (value) => _password = value as String,
            obscureText: true,
          ),
        ),

        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: TextFormField(
            decoration: getInputDecoration('Confirm Password'),
            obscureText: true,
            onSaved: (value) => _password2 = value as String,
          ),
        ),
        SizedBox(height: 10,),

        Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: (){
                saveForm();
                signUp();
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
