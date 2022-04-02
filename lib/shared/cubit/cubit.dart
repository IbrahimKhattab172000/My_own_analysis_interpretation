// ignore_for_file: prefer_const_constructors, avoid_print, curly_braces_in_flow_control_structures

import 'package:abdullah_mansour/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:abdullah_mansour/modules/done_tasks/done_tasks_screen.dart';
import 'package:abdullah_mansour/modules/new_tasks/new_tasks_screen.dart';
import 'package:abdullah_mansour/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  int currentIndex = 0;

  //*To be more easy when use this cubit in many places

  //* {static AppCubit get(context)} is like a method returning an instant of our Cubit
  //* and it can be accessed therefore all the other components inside the same Cubit here can be access
  //* & {BlocProvider.of(context);} is just the way we can access our Cubit
  //* So instead of writing everytime {BlocProvider.of(context);}
  //* ... we will use .get() and access what's inside of it from methods or variables

  static AppCubit get(context) => BlocProvider.of(context);

  ////*Toggling the bottomNavBar stuff

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  ////* Database stuff

  Database? database;
  List<Map>? newTasks = [];
  List<Map>? doneTasks = [];
  List<Map>? archivedTasks = [];

//* create

  void createDatabase() {
    //*{var database} != {database} yasta, they kinda have the same data yet they are different
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database, version) {
        print("database created");
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print("Table created");
        }).catchError((error) {
          print("Error when creating table : ${error.toString()}");
        });
      },
      onOpen: (database) {
        print("database opened");
        getDataFromDatabase(database);
      },
    ).then((value) {
      //*After we finish we will place it in datebase
      //*After that we will emit the state of creating database
      database = value;
      emit(AppCreateDatabaseState());
    });
  }
  //*The End of void createDatabase() {} ///

  //*insert

  //*You may wonder why we didn't leave it "void" method
  //* and that because I want to be able to use .then((value) {}); up there where I call it
  //* and then make whatever I want afterwards
  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks (title, date, time, status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        //*We'll insert our data
        //*After that we will emit the state of Inserting our data
        print("$value inserted successfully");
        emit(AppInsertDatabaseState());
//? why using getDataFromDatabase here again?
//*The answer is simple = Just to refresh the tasks "In other words" our data again
//* after the user enters a new task
        getDataFromDatabase(database);
      }).catchError((error) {
        print("Error when inserting table : ${error.toString()}");
      });
    });
  }

//*Get data

  void getDataFromDatabase(database) async {
//!So important=> when we start out method we should eliminate everything from our lists
//!.. cuz we use ".add" and it will add on the previous values | check vid 87 | min 18
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    //*Before we get our data we will emit this state AppGetDatabaseLoadingState(),
    emit(AppGetDatabaseLoadingState());

    database!.rawQuery('SELECT * FROM tasks').then((value) {
      //***After we get our data we will place it in our lists according to its status
      //*After that we will emit the state of getting our database

//! This forEach is so important cuz it analizes "value" which is our data...
//!... then we add it to a specifc map according to its 'status'
      value.forEach((element) {
        print(element['status']);

        if (element['status'] == 'new')
          newTasks!.add(element);
        else if (element['status'] == 'done')
          doneTasks!.add(element);
        else
          archivedTasks!.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  //*update data

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      //? why using get here => video #87 | min 18
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

//*Bottom sheet stuff /////////////////////////
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
