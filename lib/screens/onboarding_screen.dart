import 'package:adhd_planner/constants/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adhd_planner/auth.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State {
// Controller for form values
  String? errorMessage ='';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(email:  _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage= e.message;
      });
    }
  }
  Future <void> createUserWithEmailAndPassword() async{
    try {
      await Auth().createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch(e) { setState(() {
      errorMessage= e.message;
    });}
  }

  Widget _entryField(
      String title,
      TextEditingController controller,
      ){
    return TextField( controller: controller, decoration: InputDecoration(labelText: title,),) ;
  }
  Widget _submitButton(){
    return ElevatedButton(onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
    style: ElevatedButton.styleFrom(
      backgroundColor: mainAppBlueColor,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
    ),
        child: Text(isLogin? 'Login' : 'Sign up'),);
  }
  Widget _loginOrSignUpButton(){
    return TextButton(onPressed: (){setState(() {
      isLogin=!isLogin;
    });},
        child:Text(isLogin ? 'Sign Up instead' : 'Login instead' ) );
  }
  
  Widget _errorMessage(){
    return Text(errorMessage== ''?'': 'Are you sure? $errorMessage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
          _entryField('email', _emailController),
          _entryField('password', _passwordController),
          _errorMessage(),
          _submitButton(),
          _loginOrSignUpButton(),
          ],
        ),
      ),
    );
  }
}
