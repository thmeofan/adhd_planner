import 'package:adhd_planner/constants/global_colors.dart';
import 'package:adhd_planner/constants/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adhd_planner/auth.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State {
// Controller for form values
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
    IconData icon,
  ) {
    return Container(
      //  color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: mainAppBlueColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: accentGreyAppColor,
              ),
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: mainAppGreenColor,
                    size: 35,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration.collapsed(
                        hintText: title,
                        hintStyle: AppTextStyle.inputTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      style: ElevatedButton.styleFrom(
        backgroundColor: mainAppBlueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
      ),
      child: Text(
        isLogin ? 'Login' : 'Sign up',
        style: AppTextStyle.buttonsStyle,
      ),
    );
  }

  Widget _loginOrSignUpButton() {
    // return Row(
    //   children: [
    //     Draggable<String>(
    //       feedback: Opacity(
    //         opacity: 0.4,
    //       ),
    //       child: Container(
    //         // color: Colors.purple,
    //         // width: 300,
    //         // height: 200,
    //         alignment: Alignment.center,
    //         // child: TextButton(
    //         //   onPressed: () {
    //         //     setState(() {
    //         //       isLogin = !isLogin;
    //         //     });
    //         //   },
    //         child: Text(
    //           isLogin ? 'hello' : 'hello\nagain',
    //           style: AppTextStyle.hintTextStyle,
    //         ),
    //         // ),
    //       ),
    //     ),
    //     DragTarget<String>(
    //       onAccept: (value) {
    //         setState(() {
    //           isLogin = !isLogin;
    //         });
    //       },
    //       builder: (_, candidateData, rejectedData) {
    //         return Container(
    //           // color: Colors.purple,
    //           // width: 300,
    //           // height: 200,
    //           alignment: Alignment.center,
    //
    //           child: Text(
    //             isLogin ? 'hello' : 'hello\nagain',
    //             style: AppTextStyle.hintTextStyle,
    //           ),
    //         );
    //       },
    //     )
    //   ],
    // );
    return Container(
      // height: 180,
      // padding: EdgeInsets.all(25),
      // margin: EdgeInsets.all(1),
      child: Column(children: [
        TextButton(
          onPressed: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(
            isLogin ? 'hello' : 'hello\nagain',
            style: AppTextStyle.hintTextStyle,
            selectionColor: mainAppGreenColor,
            textScaleFactor: 10,
          ),
        ),
        Icon(
          Icons.swap_horiz_rounded,
          color: mainAppGreenColor,
          size: 50.0,
        ),
      ]),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Are you sure? $errorMessage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loginOrSignUpButton(),
            _entryField('email', _emailController, Icons.person),
            _entryField('password', _passwordController, Icons.lock),
            _errorMessage(),
            _submitButton(),
          ],
        ),
      ),
    );
  }
}
