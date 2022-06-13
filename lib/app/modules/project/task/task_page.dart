import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  final TaskController controller;
  const TaskPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _durationEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.sucess) {
          Navigator.pop(context);
        } else if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Erro ao cadastrar task').show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Criar nova task',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome da task'),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome Obrigatório'),
                    Validatorless.min(3, 'No mínimo 3 caracteres'),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _durationEC,
                  decoration: const InputDecoration(
                    label: Text('Duração da task'),
                  ),
                  validator: Validatorless.multiple(
                    [
                      Validatorless.required('Duração Obrigatória'),
                      Validatorless.number('Somente números'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 49,
                  child: ButtonWithLoader<TaskController, TaskStatus>(
                    selector: (state) => state == TaskStatus.loading,
                    bloc: widget.controller,
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        widget.controller
                            .register(_nameEC.text, int.parse(_durationEC.text));
                      }
                    },
                    label: 'Salvar',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
