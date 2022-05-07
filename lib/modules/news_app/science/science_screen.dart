// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:abdullah_mansour/layout/news_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/news_app/cubit/states.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceScreen extends StatelessWidget {
  ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).science;
        return state is! NewsGetScienceLoadingState
            ? articleBuilder(list: list)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
