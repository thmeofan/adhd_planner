import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../class_repository/adhd_planner_repository.dart';
import '../class_repository/notification_service.dart';
import '../models/adhd_planner_model.dart';
import 'adhd_planner_event.dart';
import 'adhd_planner_state.dart';

class ADHDPlannerBloc extends Bloc<ADHDPlannerEvent, ADHDPlannerState> {
  ADHDPlannerBloc() : super(LoadingState()) {
    on<SaveTaskEvent>(_onSaveTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<DeleteAllTasksEvent>(_onDeleteAllTasks);
    on<EmptyListEvent>(_onEmptyList);
    on<ChangeTaskEvent>(_onChangeTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    ADHDPlannerRepository().collection.snapshots().listen((event) {
      List<ADHDPlannerModel> tasks = [];
      for (var doc in event.docs) {
        ADHDPlannerModel toDo =
            ADHDPlannerModel.fromJson(doc.data() as Map<String, dynamic>);
        tasks.add(toDo);
      }
      add(UpdateTaskEvent(tasks));
      ADHDPlannerRepository().saveToHive(tasks);
    });
  }

  void _onSaveTask(SaveTaskEvent event, Emitter<ADHDPlannerState> emit) {
    ADHDPlannerRepository().saveToFirebase(event.task);
    // FirebaseMessaging.onBackgroundMessage(backgroundMassageHandler);
    // NotificationService().sendPush();
    // NotificationService().foregroundMessage();
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<ADHDPlannerState> emit) {
    ADHDPlannerRepository().deleteFromFirebase(event.task);
    ADHDPlannerRepository().deleteFromHive(event.task);
    //  }
  }

  void _onDeleteAllTasks(
      DeleteAllTasksEvent event, Emitter<ADHDPlannerState> emit) {
    //  _tasks.clear();
    ADHDPlannerRepository().deleteAllFromHive();
    ADHDPlannerRepository().deleteAllFromFirebase();
    emit(EmptyState());
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<ADHDPlannerState> emit) {
    if (event.taskList.isEmpty) {
      emit(EmptyState());
    } else {
      emit(TaskDataState(event.taskList));
    }
  }

  void _onEmptyList(EmptyListEvent event, Emitter<ADHDPlannerState> emit) {
    emit(EmptyState());
  }

  void _onChangeTask(ChangeTaskEvent event, Emitter<ADHDPlannerState> emit) {
    // _tasks[_tasks.indexOf(event.task)]= event.task;

    ADHDPlannerRepository().editInFirebase(event.task);
    ADHDPlannerRepository().editInHive(event.task);
  }
}
