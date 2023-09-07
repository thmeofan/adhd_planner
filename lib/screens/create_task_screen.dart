import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bLoc/adhd_planner_bloc.dart';
import '../bLoc/adhd_planner_event.dart';
import '../models/adhd_planner_model.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create task"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            width: double.maxFinite,
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              controller: myController,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: "btn3",
                onPressed: () {
                  ADHDPlannerModel task = ADHDPlannerModel(
                      myController.text,
                      random.nextInt(1 << 32).toString(),
                      false,
                      DateTime.now(),
                      DateTime.now(),
                      'task',
                      'imo');
                  context.read<ADHDPlannerBloc>().add(SaveTaskEvent(task));
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                  myController.clear();
                },
                child: const Icon(Icons.ac_unit_rounded),
              ),
            ],
          )
        ], // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
