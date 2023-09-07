import '../models/adhd_planner_model.dart';

class ADHDPlannerEvent {}

class SaveTaskEvent extends ADHDPlannerEvent {
  final ADHDPlannerModel task;

  SaveTaskEvent(this.task);
}

class DeleteTaskEvent extends ADHDPlannerEvent {
  final ADHDPlannerModel task;

  DeleteTaskEvent(this.task);
}

class DeleteAllTasksEvent extends ADHDPlannerEvent {
  DeleteAllTasksEvent();
}

class EmptyListEvent extends ADHDPlannerEvent {}

class ChangeTaskEvent extends ADHDPlannerEvent {
  final ADHDPlannerModel task;

  ChangeTaskEvent(this.task);
}

class IsCheckedEvent extends ADHDPlannerEvent {
  final ADHDPlannerModel task;

  IsCheckedEvent(this.task);
}

class UpdateTaskEvent extends ADHDPlannerEvent {
  final List<ADHDPlannerModel> taskList;

  UpdateTaskEvent(this.taskList);
}
