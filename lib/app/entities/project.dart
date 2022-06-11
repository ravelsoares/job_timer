import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'converters/project_status_converter.dart';
part 'project.g.dart';

@Collection()
class Project {
  @Id()
  int? id;

  late int estimate;

  late String name;
  @ProjectStatusConverter()
  late ProjectStatus status;
  final tasks = IsarLinks<ProjectTask>();
}
