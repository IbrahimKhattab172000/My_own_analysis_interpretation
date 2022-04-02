// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/components/constants.dart';
import 'package:abdullah_mansour/shared/cubit/cubit.dart';
import 'package:abdullah_mansour/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatefulWidget {
  NewTasksScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    ///*Using BlocConsumer to rebuild the UI and show our data which are tasks
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //*Getting our newTasks here
          var tasks = AppCubit.get(context).newTasks;
          return taskBuilder(tasks: tasks);
        });
  }
}
