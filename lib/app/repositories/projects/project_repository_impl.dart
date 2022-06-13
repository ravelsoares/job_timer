import 'dart:developer';
import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/entities/project_task.dart';
import '../../core/exceptions/failure.dart';
import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _databse;
  ProjectRepositoryImpl({required Database database}) : _databse = database;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _databse.openConnection();
      await connection.writeTxn((isar) {
        return isar.projects.put(project);
      });
    } on IsarError catch (e, s) {
      log('Erro ao cadastrar projeto', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao cadastrar projeto');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final connection = await _databse.openConnection();
    final projects =
        await connection.projects.filter().statusEqualTo(status).findAll();
    return projects;
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _databse.openConnection();
    final project = await connection.projects.get(projectId);
    if (project == null) {
      throw Failure(message: 'Projeto não encontrado');
    }
    return project;
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask projectTask) async {
    final connection = await _databse.openConnection();
    final project = await findById(projectId);
    project.tasks.add(projectTask);

    await connection.writeTxn((isar) => project.tasks.save());
    return project;
  }

  @override
  Future<void> finishProject(int projectId) async {
    try {
      final connection = await _databse.openConnection();
      final project = await findById(projectId);
      project.status = ProjectStatus.finalizado;
      await connection.writeTxn(
        (isar) => connection.projects.put(project, saveLinks: true),
      );
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw Failure(message: 'Erro ao finalizar projeto');
    }
  }
}
