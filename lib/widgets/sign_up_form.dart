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
  final _passwordController = TextEditingController();
  final _secondPasswordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  void saveForm(){
    _form.currentState?.save();
    print('fname $firstName lname $lastName roel $role department $department kau id $universityId phone number $phoneNumber email $email');
  }
  bool validateForm(){
    bool? isValid =_form.currentState?.validate();
    if(isValid!)
      return true;
    else
      return false;
  }

  Future signUp() async{
    var authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
    password: _passwordController.text.trim());
    FirebaseFirestore.instance.collection('users').doc(authResult.user?.uid).set({
      'First Name': firstName,
      'Last Name': lastName,
      'Role': role,
      'Department': department,
      'KAU ID': universityId,
      'Phone Number': phoneNumber,
      'Email': email,
      'Height': '',
      'Weight': '',
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
                  validator: (value){
                    RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                    if(!nameRegex.hasMatch(value as String)){
                      return 'Name is Invalid';
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
            ),
            SizedBox(width: 10,),
            Expanded(
                child: TextFormField(
                  decoration: getInputDecoration('Last Name'),
                  onSaved: (value) {
                    lastName = value as String;
                  },
                  validator: (value){
                    RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                    if(!nameRegex.hasMatch(value as String)){
                      return 'Name is Invalid';
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  validator: (value){
                    if(value == null){
                      return 'Please choose an answer';
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value){role = value as String;},
                )
            ),
            SizedBox(width: 10,),
            Expanded(
              child: TextFormField(
                decoration: getInputDecoration('Faculty\\Department'),
                onSaved: (value) => department = value as String,
                validator: (value){
                  RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                  if(!nameRegex.hasMatch(value as String)){
                    return 'Department is Invalid';
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
            validator: (value){
              if((value as String)=='') {
                print('No KAU ID provided');
                print(value);
                return 'University ID can\'t be empty';
              }
              RegExp numberRegex = RegExp(r'^[1-2]\d{6}$');
              if(!numberRegex.hasMatch(value as String)){
                return 'Entered University ID is invalid';
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        SizedBox(height: 10,),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: TextFormField(
            decoration: getInputDecoration('Phone Number'),
            onSaved: (value) => phoneNumber = value as String,
            validator: (value){
              if((value as String)=='') {
                print('No phone number provided');
                print(value);
                return 'Phone number can\'t be empty';
              }
              RegExp phoneRegex = RegExp(r'^0(5)[^123][0-9]{7}$');
              if(!phoneRegex.hasMatch(value as String)){
                return 'Phone number is invalid';
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),

        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: TextFormField(
            decoration: getInputDecoration('Email'),
            onSaved: (value) => email = value as String,
            validator: (value){
              RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
              if(!emailRegex.hasMatch(value as String)){
                return 'Entered Email is Invalid';
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: TextFormField(
            decoration: getInputDecoration('Password'),
            //onSaved: (value) => _passwordController = value,
            obscureText: true,
            controller: _passwordController,
            validator: (value){
              if((value as String).isEmpty){
                return 'Password Can\'t be empty';
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),

        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,),
          child: TextFormField(
            decoration: getInputDecoration('Confirm Password'),
            obscureText: true,
            //onSaved: (value) => _password2 = value as String,
            controller: _secondPasswordController,
            validator: (value){
              if(_passwordController.text != _secondPasswordController.text){
                return 'Passwords don\'t match';
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        SizedBox(height: 10,),

        Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: (){
                if(validateForm()) {
                  saveForm();
                  signUp();
                }
                else
                  return;
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
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
