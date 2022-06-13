
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/register/detail/project_detail_page.dart';

class ProjectDetailModule extends Module{
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: ((context, args) => ProjectDetailPage())),
  ];
}