// ignore_for_file: prefer_const_constructors, avoid_print, prefer_is_empty, curly_braces_in_flow_control_structures

import 'package:abdullah_mansour/layout/news_app/cubit/states.dart';
import 'package:abdullah_mansour/modules/business/business_screen.dart';
import 'package:abdullah_mansour/modules/science/science_screen.dart';
import 'package:abdullah_mansour/modules/sports/sports_screen.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

//*Bottom nav bar stuff
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
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: "Settings",
    // ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    //* Getting the data for Sports and Science screens depending changing of the BottonNavBar
    //!Notice (0) We could've avoided all of that by getting all of our data at once..
    //!...in newsLayout screen like we get getBusiness() | go there and see
    if (index == 1)
      getSports();
    else if (index == 2) getScience();

    emit(NewsBottomNavState());
  }

//* Business stuff
  List<dynamic> business = [];
//! Associated with => Notice(0)
//? Why I didn't make a if-else here as well like I did to the other funcs down there?
//* Cuz we call this method once "in the newsLayout screen" but the others we call then everytime..
//*... we press on the BottomNavBar.
//*getBusines method
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    if (business.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '569a637cdf0b4880be27dbd2b2fc2a01',
        },
      ).then((value) {
        business = value.data['articles'];

        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  //* Sports stuff
  List<dynamic> sports = [];
//*getSports method
  void getSports() {
    emit(NewsGetSportsLoadingState());
//*To avoid redo it all again
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '569a637cdf0b4880be27dbd2b2fc2a01',
        },
      ).then((value) {
        sports = value.data['articles'];

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  //*Science stuff
  List<dynamic> science = [];
//*getScience method
  void getScience() {
    emit(NewsGetScienceLoadingState());
//*To avoid redo it all again
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '569a637cdf0b4880be27dbd2b2fc2a01',
        },
      ).then((value) {
        science = value.data['articles'];

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  //*Sercah stuff
  List<dynamic> search = [];
//*getSearch method
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    //*Making sure to delete everything everytime
//? Why I commented it? => cuz we are not -adding- data to the list everytime rather we -put- data
    // search = [];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '569a637cdf0b4880be27dbd2b2fc2a01',
      },
    ).then((value) {
      //?=> we -put- here
      search = value.data['articles'];

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
