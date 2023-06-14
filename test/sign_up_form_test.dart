import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../lib/widgets/sign_up_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';}
              return null;},),
          ElevatedButton(onPressed: () {},
            child: Text('Submit'),),],),);}
}

void main() {
  testWidgets('SignUpForm validation', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SignUpForm(),
        ),
      ),
    );

    // Enter valid form data and perform other interactions

    // Verify expected behavior

    // Add other test scenarios

  });
}
