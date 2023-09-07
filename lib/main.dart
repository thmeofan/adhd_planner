import 'package:adhd_planner/screens/create_task_screen.dart';
import 'package:adhd_planner/screens/edit_task_screen.dart';
import 'package:adhd_planner/screens/routine_screen.dart';
import 'package:adhd_planner/widgets/widget_tree.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'bLoc/adhd_planner_bloc.dart';
import 'bLoc/adhd_planner_event.dart';
import 'bLoc/adhd_planner_state.dart';
import 'class_repository/notification_service.dart';
import 'constants/screens.dart';
import 'firebase_options.dart';
import 'models/adhd_planner_model.dart';

const String tasksKeeperKey = 'tasks_keeper';
const String tasksListKey = 'task_List_key';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseStorage storage = FirebaseStorage.instance;

  // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  // final fcmToken = await firebaseMessaging.getToken();
  // final settings = await firebaseMessaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // FirebaseMessaging.onBackgroundMessage(
  //     NotificationService().backgroundMassageHandler);

  // if (kDebugMode) {
  //   print('Permission granted: ${settings.authorizationStatus}');
  // }
  // print(
  //     '=================================================================================');
  // print(fcmToken);
  // print(
  //     '=================================================================================');
  // FirebaseMessaging.instance.onTokenRefresh
  //     .listen((fcmToken) {})
  //     .onError((err) {});
  // await FirebaseMessaging.instance.subscribeToTopic("newTaskNotification");
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(ADHDPlannerModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => ADHDPlannerBloc())],
        child: FutureBuilder(
            future: Connectivity().checkConnectivity(),
            builder: (context, connectivityStatus) {
              if (connectivityStatus.hasData) {
                if (connectivityStatus.data != ConnectivityResult.none) {
                  FirebaseFirestore.instance
                      .collection("tasks")
                      .get()
                      .then((event) async {
                    var box = await Hive.openBox(tasksKeeperKey);
                    List<ADHDPlannerModel> taskList = [];
                    for (var doc in event.docs) {
                      ADHDPlannerModel newTask =
                          ADHDPlannerModel.fromJson(doc.data());
                      context
                          .read<ADHDPlannerBloc>()
                          .add(SaveTaskEvent(newTask));
                      taskList.add(newTask);
                    }
                    await box.put(tasksListKey, taskList);
                    await box.close();
                  });
                } else {
                  Hive.openBox(tasksKeeperKey).then((box) {
                    if (box.isNotEmpty) {
                      List<ADHDPlannerModel> tasksList =
                          box.get(tasksListKey).cast<ADHDPlannerModel>();
                      if (tasksList.isEmpty) {
                        context.read<ADHDPlannerBloc>().add(EmptyListEvent());
                      } else {
                        for (int index = 0; index < tasksList.length; index++) {
                          context
                              .read<ADHDPlannerBloc>()
                              .add(SaveTaskEvent(tasksList[index]));
                        }
                      }
                      box.close();
                    } else {
                      context.read<ADHDPlannerBloc>().add(EmptyListEvent());
                    }
                  });
                }
              }
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const WidgetTree(),
                routes: {
                  Screens.routineScreen: (context) => RoutineScreen(),
                  Screens.createTaskScreen: (context) => CreateTaskScreen(),
                  Screens.editTaskScreen: (context) => EditTaskScreen(),
                  //Screens.calendarScreen:(context)=> CalendarScreen(),
                  //Screens.moodTrackingScreen:(context)=>MoodTrackingScreen(),
                },
              );
            }));
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
