// ignore_for_file: prefer_const_constructors

import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/cubit/cubit.dart';
import 'package:abdullah_mansour/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //*Getting our doneTasks here
          var tasks = AppCubit.get(context).doneTasks;
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
