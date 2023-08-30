import 'package:adhd_planner/screens/onboarding_screen.dart';
import 'package:adhd_planner/screens/routine_screen.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class WidgetTree extends StatefulWidget{
  const WidgetTree ({Key? key}): super(key:key);

  @override
  State <WidgetTree> createState()=> _WidgetTreeState();

}

class _WidgetTreeState extends State <WidgetTree> {
  @override
  Widget build (BuildContext context){
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          return RoutineScreen();
        }else{
          return OnboardingScreen();
        }
      },



    );
  }
}