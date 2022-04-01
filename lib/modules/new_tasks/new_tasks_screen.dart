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
          //*Getting our tasks here
          var tasks = AppCubit.get(context).tasks;
          return ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(tasks![index], context),
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              );
            },
            itemCount: tasks!.length,
          );
        });
  }
}
