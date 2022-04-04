// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:abdullah_mansour/layout/news_app/cubit/states.dart';
import 'package:abdullah_mansour/modules/business/business_screen.dart';
import 'package:abdullah_mansour/modules/science/science_screen.dart';
import 'package:abdullah_mansour/modules/settings_Screen/settings_screen.dart';
import 'package:abdullah_mansour/modules/sports/sports_screen.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewSInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewSBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewSGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '569a637cdf0b4880be27dbd2b2fc2a01',
      },
    ).then((value) {
      // print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewSGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(NewSGetBusinessErrorState(error.toString()));
    });
  }
}
