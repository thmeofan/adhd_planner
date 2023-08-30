import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adhd_planner/auth.dart';


//TODO: not a home screen, it will be settings page, pretty<3
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super ( key: key);

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }
  Widget _userUid(){
    return Text (user?.email ?? 'User email');
  }
  Widget _signOutButton(){
    return ElevatedButton(onPressed: signOut, child: const Text( 'Sign out'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       height: double.infinity,
       width: double.infinity,
       child: Column(
         children: <Widget>[
           _userUid(),
           _signOutButton()
         ],
       ),
     ),
    );

  }
}