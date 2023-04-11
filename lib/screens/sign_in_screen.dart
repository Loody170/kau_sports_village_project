import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SignInScreen extends StatefulWidget {
  static String routeName = '/sign-in';
  late final VoidCallback showSignUpScreen;

  SignInScreen({required this.showSignUpScreen});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {


  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()
    );

  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                // Icon(Icons.android,
                // size: 100,),
                // SizedBox(height: 75,)
              Image.asset('assets/App logo.png', scale: 0.8,)
                ,
                
                Text('Hello Again', style: GoogleFonts.publicSans(fontSize: 45),),

                SizedBox(height: 10,),
                Text('Welcome back!', style: GoogleFonts.publicSans(fontSize: 15),),
                SizedBox(height: 25,),

                Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:  Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Email',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
                ),
                SizedBox(height: 10,),

                Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _passwordController,
                    //obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:  Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    obscureText: true,
                  ),
                ),

                SizedBox(height: 10,),

                Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('Sign in', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                      ),
                    ),
                  )
                ),
                
                SizedBox(height: 25,),
                
                Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?   ', style: TextStyle(fontWeight: FontWeight.bold),),
                  GestureDetector(onTap: widget.showSignUpScreen,
                      child: Text('Register Now', style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.blue),))
                ],)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
