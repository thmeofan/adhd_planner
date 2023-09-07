import 'package:adhd_planner/bLoc/adhd_planner_event.dart';
import 'package:adhd_planner/models/adhd_planner_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bLoc/adhd_planner_bloc.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TextEditingController myController;

  @override
  void initState() {
    myController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ADHDPlannerModel toDoNote =
        ModalRoute.of(context)?.settings.arguments! as ADHDPlannerModel;
    myController.text = toDoNote.taskText;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextField(
            controller: myController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: "btn4",
                onPressed: () {
                  ADHDPlannerModel newNote = ADHDPlannerModel(
                      myController.text,
                      toDoNote.id,
                      false,
                      toDoNote.creationDate,
                      toDoNote.deadlineDate,
                      toDoNote.taskStatus,
                      toDoNote.taskType);
                  context.read<ADHDPlannerBloc>().add(ChangeTaskEvent(newNote));
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                },
                backgroundColor: Color.fromRGBO(137, 152, 120, 1),
                child: const Icon(Icons.confirmation_num_outlined),
              ),
            ],
          )
        ], // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
