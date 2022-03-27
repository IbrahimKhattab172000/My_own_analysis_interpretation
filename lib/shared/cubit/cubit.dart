// ignore_for_file: prefer_const_constructors

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
  List<Map>? tasks = [];

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

        //*This place number one where we get our data but we will use it there also
        //Go and check //? why
        getDataFromDatabase(database).then((value) {
          //*After we get our data we will place it in tasks
          //*After that we will emit the state of getting our database
          tasks = value;
          print(tasks);
          emit(AppGetDatabaseState());
        });
      },

      //!Notice that .then() here belongs to openDatabase() method //focus
    ).then((value) {
      //*After we finish we will place it in datebase
      //*After that we will emit the state of creating database
      database = value;
      emit(AppCreateDatabaseState());
    });
  }
  //*The End of void createDatabase() {} ///

  //*Other helping methods down there=>

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
//?Hey you came from there right?
//*I will tell u know why we used getDataFromDatabase() here again
//? why using getDataFromDatabase here again?
//*The answer is simple = Just to refresh the tasks "In other words" our data again
//* after the user enters a new task
        getDataFromDatabase(database).then((value) {
          //*After we get our data we will place it in tasks
          //*After that we will emit the state of getting our database
          tasks = value;
          print(tasks);
          emit(AppGetDatabaseState());
        });
      }).catchError((error) {
        print("Error when inserting table : ${error.toString()}");
      });
    });
  }

  //!You're wondering why we put (database) inside => getDataFromDatabase(database) async {...
  //*Okay go to Abduallh_mansour course  episode 82 'get data from database' min 7
  //*first way
  //getDataFromDatabase(database) async {
  //   List<Map> tasks = await database!.rawQuery('SELECT * FROM tasks');
  //   print(tasks);
  // }
  //*Second way , which there is no big difference between the two btw
  Future<List<Map>> getDataFromDatabase(database) async {
    return await database!.rawQuery('SELECT * FROM tasks');
  }

//*Bottom sheet stuff
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
