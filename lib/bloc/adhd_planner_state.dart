import '../models/adhd_planner_model.dart';

class ADHDPlannerState {}

class TaskDataState extends ADHDPlannerState {
  final List<ADHDPlannerModel> tasks;

  TaskDataState(this.tasks);
}

class EmptyState extends ADHDPlannerState {}

class LoadingState extends ADHDPlannerState {}

class IsCheckedState extends ADHDPlannerState {}
