// ignore_for_file: prefer_const_constructors, unused_import

import 'package:abdullah_mansour/layout/news_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/news_app/news_layout.dart';
import 'package:abdullah_mansour/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:abdullah_mansour/shared/bloc_observer.dart';
import 'package:abdullah_mansour/shared/cubit/cubit.dart';
import 'package:abdullah_mansour/shared/cubit/states.dart';
import 'package:abdullah_mansour/shared/network/local/cache_helper.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:abdullah_mansour/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      //*That one makes sure that everything is done before opening the app
      WidgetsFlutterBinding.ensureInitialized();
      //*Initiating our helpers
      DioHelper.init();
      await CacheHelper.init();

      //*Getting our data from the cache "sharedPreferance" and save it in isDark to utilize it luego
      bool? isDrak = CacheHelper.getBoolean(key: "isDark");

      runApp(MyApp(
        //* passing isDark from cache to isDark to use it inside MyApp()
        isDark: isDrak,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({Key? key, required this.isDark}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          //*Calling getBusiness
//! Associated with Notice(0)..we could have do the following to get it all at once
// create: (context) => NewsCubit()..getBusiness()..getSports()..getScience(),
          create: (context) => NewsCubit()..getBusiness(),
        ),
        BlocProvider(
          //*Passing isDrak(which is from cache) value to fromShared to get the...
          //*...last value once opening the app again
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            //*Normal theme
            theme: lightTheme,

            //*Dark theme
            darkTheme: darkTheme,

            //*For choosing the default theme
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
