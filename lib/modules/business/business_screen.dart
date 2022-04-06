// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:abdullah_mansour/layout/news_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/news_app/cubit/states.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return list.length > 0
            ? articleBuilder(list: list)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
