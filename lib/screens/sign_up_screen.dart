import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/widgets/custom_text_field.dart';
import 'package:kau_sports_village_project/widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback showSignInScreen;

  SignUpScreen({required this.showSignInScreen});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signUp() async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()
    );
    //TODO svae other user info

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.android,
                  size: 100,),
                SizedBox(height: 75,),

                Text('Hello There',),

                SizedBox(height: 10,),
                Text('Register below with your details!'),
                SizedBox(height: 25,),

                SignUpForm(),

                // Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //     child: GestureDetector(
                //       onTap: signUp,
                //       child: Container(
                //         padding: EdgeInsets.all(20),
                //         decoration: BoxDecoration(
                //           color: Colors.deepPurple,
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         child: Center(
                //           child: Text('Sign up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                //         ),
                //       ),
                //     )
                // ),

                SizedBox(height: 15,),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already a member?   ', style: TextStyle(fontWeight: FontWeight.bold),),
                    GestureDetector(onTap: widget.showSignInScreen,
                        child: Text('Sign in', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),))
                  ],)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
