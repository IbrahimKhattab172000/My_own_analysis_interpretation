// ignore_for_file: prefer_const_constructors

import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/cubit/cubit.dart';
import 'package:abdullah_mansour/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //*Getting our newTasks here
          var tasks = AppCubit.get(context).archivedTasks;
          return taskBuilder(tasks: tasks);
        });
  }
}
