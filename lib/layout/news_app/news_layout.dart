// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:abdullah_mansour/layout/news_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/news_app/cubit/states.dart';
import 'package:abdullah_mansour/modules/news_app/search/search_screen.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("News app"),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context: context, widget: SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  //!Yastaaaa This method that we call here is from
                  //! AppCubit not our NewCubit
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
