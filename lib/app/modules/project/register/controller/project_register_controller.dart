import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';
part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectResgisterStatus> {
  final ProjectService _projectService;

  ProjectRegisterController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectResgisterStatus.initial);

  Future<void> register(String name, int estimate) async {
    try {
      emit(ProjectResgisterStatus.loading);
      final projectModel = ProjectModel(
        name: name,
        estimate: estimate,
        status: ProjectStatus.emAndamento,
        tasks: [],
      );
      await _projectService.register(projectModel);
      emit(ProjectResgisterStatus.sucess);
    } catch (e, s) {
      log('Erro ao salvar projeto', error: e, stackTrace: s);
      emit(ProjectResgisterStatus.failure);
    }
  }
}
