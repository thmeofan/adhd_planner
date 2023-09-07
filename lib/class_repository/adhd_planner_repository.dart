import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';

import '../bLoc/adhd_planner_state.dart';
import '../main.dart';
import '../models/adhd_planner_model.dart';

class ADHDPlannerRepository {
  static final ADHDPlannerRepository _aDHDPlannerRepository =
      ADHDPlannerRepository._internal();

  ADHDPlannerRepository._internal();

  factory ADHDPlannerRepository() {
    return _aDHDPlannerRepository;
  }

  CollectionReference collection =
      FirebaseFirestore.instance.collection("tasks");

  Future<void> saveToFirebase(ADHDPlannerModel task) async {
    FirebaseFirestore.instance
        .collection("tasks")
        .doc(task.id)
        .set(task.toJson());
  }

  Future<void> saveToHive(List<ADHDPlannerModel> tasks) async {
    var box = await Hive.openBox(tasksKeeperKey);
    List<ADHDPlannerModel> tasksList =
        box.get(tasksListKey, defaultValue: []).cast<ADHDPlannerModel>();
    tasksList.addAll(tasks);

    await box.put(tasksListKey, tasksList);
    await box.close();
  }

  Future<void> editInFirebase(ADHDPlannerModel task) async {
    FirebaseFirestore.instance
        .collection("tasks")
        .doc(task.id)
        .set(task.toJson());
  }

  Future<void> editInHive(ADHDPlannerModel newTask) async {
    var box = await Hive.openBox(tasksKeeperKey);
    List<ADHDPlannerModel> tasksList =
        box.get(tasksListKey).cast<ADHDPlannerModel>();
    ADHDPlannerModel theTask =
        tasksList.firstWhere((element) => element.id == newTask.id);
    int indexOfTheTask = tasksList.indexOf(theTask);
    tasksList[indexOfTheTask] = newTask;
    await box.put(tasksListKey, tasksList);
    await box.close();
  }

  // Future<void> isCheckedForFirebase(ToDoModel thetask) async {
  //   FirebaseFirestore.instance
  //       .collection("todos")
  //       .doc(thetask.id)
  //       .set(thetask.toJson());
  // }

  // Future<void> isCheckedForHive(ToDoModel task) async {
  //   var box = await Hive.openBox(TaskDataState);
  //   List<ToDoModel> tasksList = box.get(tasksListKey).cast<ToDoModel>();
  //   ToDoModel thetask =
  //       tasksList.firstWhere((element) => element.id == task.id);
  //   int indexOfThetask = tasksList.indexOf(thetask);
  //   tasksList[indexOfThetask].isChecked = !tasksList[indexOfThetask].isChecked;
  //   await box.put(tasksListKey, tasksList);
  //   await box.close();
  // }

  Future<void> deleteFromFirebase(ADHDPlannerModel task) async {
    FirebaseFirestore.instance.collection("tasks").doc(task.id).delete();
  }

  Future<void> deleteFromHive(ADHDPlannerModel task) async {
    var box = await Hive.openBox(tasksKeeperKey);
    List<ADHDPlannerModel> tasksList =
        box.get(tasksListKey).cast<ADHDPlannerModel>();
    tasksList.remove(task);

    await box.put(tasksListKey, tasksList);
    await box.close();
  }

  Future<void> deleteAllFromFirebase() {
    CollectionReference todos = FirebaseFirestore.instance.collection('todos');
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return todos.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      return batch.commit();
    });
  }

  Future<void> deleteAllFromHive() async {
    var box = await Hive.openBox(tasksKeeperKey);
    List<ADHDPlannerModel> taskList =
        box.get(tasksListKey).cast<ADHDPlannerModel>();
    taskList.clear();

    await box.put(tasksListKey, taskList);
    await box.close();
  }
}
