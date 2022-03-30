// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_typing_uninitialized_variables

import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/components/constants.dart';
import 'package:abdullah_mansour/shared/cubit/cubit.dart';
import 'package:abdullah_mansour/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  //*just to use it down there in createDatabase() & to see it in insertToDatabase() and generally

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  TextEditingController textController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

//*We will use bloc "cubit" we don't need it
  // @override
  // void initState() {
  //   createDatabase();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      //*I want to call createDatabase() here once we create the AppCubit
      //* AppCubit()..createDatabase() is like saving AppCubit() in a variable like appCubit then ...
      //*... calling createDatabase() from it, like "appCubit.createDatabase()"
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
        //*Insted of using Navigator.of(context).pop(); in the cubit page
        //?why not using it here and we are already having an access to listen to any state
        if (state is AppInsertDatabaseState) {
          Navigator.of(context).pop();
        }
      }, builder: (context, state) {
        //*!Just to avoid the redundant code we made  AppCubit.get(context) = cubit
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: state is AppGetDatabaseLoadingState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            //*Here we toggle by {isBottomSheetShown}
            onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  //*here we're calling insertToDatabase method and pass the values from the controller to it
                  //*..therefore it will take and transform and insert it
                  //*then we will use .then((value) {} . which will be triggered after insertToDatabase()
                  //*.. finished it's functionality
                  cubit.insertToDatabase(
                    title: textController.text,
                    date: dateController.text,
                    time: timeController.text,
                  );
                }
              } else {
                //*therefore... we for sure should return the state of ture & the icon to add
                //*why? .. changing the Icon is abvious, but why isBottomSheetShown = true;
                //*... just so that when the user press the button again
                //*.. the other if state will be implemented cuz the value now is true
                //*...and unsurprisingly you will find the contrary on the other part of if
                cubit.changeBottomSheetState(isShow: true, icon: Icons.add);

                //*showing showBottomSheet
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultTextFormField(
                                  controller: textController,
                                  type: TextInputType.text,
                                  validator: (value) {
                                    //*listen yasta "isEmpty" here seems like it's not activated
                                    //*but guess what? it's activated
                                    //*[and u know why it sounds like that]
                                    //*don't open a can of corns please, lol.
                                    if (value.isEmpty) {
                                      return "title must not be empty";
                                    }
                                    return null;
                                  },
                                  lable: "Task title",
                                  prefix: Icons.title,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultTextFormField(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      timeController.text =
                                          value!.format(context);
                                      print("Time: ${value.format(context)}");
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "time must not be empty";
                                    }
                                    return null;
                                  },
                                  lable: "Task time",
                                  prefix: Icons.watch_later_outlined,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultTextFormField(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-04-08'),
                                    ).then((value) {
                                      dateController.text =

                                          ///Gracias intl package!
                                          DateFormat.yMMMd().format(value!);
                                      print(DateFormat.yMMMd().format(value));
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "date must not be empty";
                                    }
                                    return null;
                                  },
                                  lable: "Task date",
                                  prefix: Icons.calendar_today,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      elevation: 20.0,

                      //*What if the user closes the showBottomSheet widget by dragging it down
                      //*..without using the floatingActionButton?
                      //*hence... we need to duplicate the same functionalities here using ...
                      //*... ..closed.then((value){our closing functionalities};
                    )
                    .closed
                    .then((value) {
                  //*we don't need it cuz the user will drag down the bottomSheet
                  // Navigator.of(context).pop();
                  //*((<Because he will drag it down with his hand, therefore we reset everything to its default>))
                  cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                });
              }
            },
            child: Icon(cubit.fabIcon),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            //*We took currentIndex and put it in our cubit but luckily we have ...
            //*...access to it so chill out yasta!
            //*!Noootice I made cubit =  AppCubit.get(context); to just avoid redundant
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              //*Using the state that we created for changing the index & using changeIndex() method
              cubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Task"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline), label: "done"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: "Archived"),
            ],
          ),
        );
      }),
    );
  }
}
