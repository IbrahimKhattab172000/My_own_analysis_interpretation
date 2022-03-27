// ignore_for_file: prefer_const_constructors

import 'package:abdullah_mansour/layout/home_layout.dart';
import 'package:abdullah_mansour/shared/bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'modules/counter/counter_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeLayout(),
    );
  }
}
