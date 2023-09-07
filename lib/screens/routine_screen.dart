import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bLoc/adhd_planner_bloc.dart';
import '../bLoc/adhd_planner_event.dart';
import '../bLoc/adhd_planner_state.dart';
import '../constants/screens.dart';
import '../widgets/task_widget.dart';

class RoutineScreen extends StatefulWidget {
  RoutineScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

enum Menu { delete }

class _RoutineScreenState extends State<RoutineScreen> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () {
          Navigator.pushNamed(context, Screens.createTaskScreen);
        },
        child: const Icon(Icons.create_outlined),
      ),
      appBar: AppBar(
        title: const Text("To Do List"),
        actions: [
          PopupMenuButton(
              onSelected: (Menu item) {
                setState(() {
                  _selectedMenu = item.name;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    PopupMenuItem(
                        value: Menu.delete,
                        child: Text('Delete all'),
                        onTap: () {
                          context
                              .read<ADHDPlannerBloc>()
                              .add(DeleteAllTasksEvent());
                        }),
                  ]),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<ADHDPlannerBloc, ADHDPlannerState>(
                  builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EmptyState) {
                  return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.fromLTRB(50, 55, 50, 70),
                      child: const Center(child: Text('Empty')));
                } else if (state is TaskDataState) {
                  List<Widget> taskWidgets = [];

                  for (int index = 0; index < state.tasks.length; index++) {
                    taskWidgets.add(TaskWidget(
                      task: state.tasks[index],
                    ));
                  }
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: taskWidgets,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ),
          ),
          // FloatingActionButton(
          //   heroTag: "btn2",
          //   onPressed: () {
          //     context.read<ADHDPlannerBloc>().add(DeleteAllTasksEvent());
          //     deleteAlltasks();
          //   },
          //   backgroundColor: const Color.fromRGBO(137, 152, 120, 1),
          //   //foregroundColor: Colors.black87,
          //   child: const Icon(Icons.delete_forever),
          // ),
        ],
      ),
    );
  }
}
