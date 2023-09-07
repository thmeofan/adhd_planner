import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bLoc/adhd_planner_bloc.dart';
import '../bLoc/adhd_planner_event.dart';
import '../constants/screens.dart';
import '../models/adhd_planner_model.dart';

Icon checkMark = Icon(Icons.square_outlined);

class TaskWidget extends StatelessWidget {
  final ADHDPlannerModel task;

  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Screens.editTaskScreen,
                    arguments: task);
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: task.isChecked,
                      onChanged: (bool? value) {
                        task.isChecked = !task.isChecked;
                        context
                            .read<ADHDPlannerBloc>()
                            .add(ChangeTaskEvent(task));
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    Expanded(
                      child: Text(
                        task.taskText,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        context
                            .read<ADHDPlannerBloc>()
                            .add(DeleteTaskEvent(task));
                        FocusScope.of(context).unfocus();
                      },
                      iconSize: 35,
                      tooltip: 'Increment',
                      icon: const Icon(Icons.dangerous_outlined),
                    ),
                    Text(task.taskStatus),
                    Text(task.taskType),
                  ],
                ),
              ),
            ),
          )
        ],
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
