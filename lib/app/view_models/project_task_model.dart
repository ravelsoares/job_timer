import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_task.dart';

class ProjectTaskModel {
  final int? id;
  final String name;
  final int duration;

  ProjectTaskModel({this.id, required this.name, required this.duration});

  factory ProjectTaskModel.fromEntity(ProjectTask task) {
    return ProjectTaskModel(
      id: task.id,
      name: task.name,
      duration: task.duration,
    );
  }
}
