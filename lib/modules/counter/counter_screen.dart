// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:abdullah_mansour/modules/counter/cubit/cubit.dart';
import 'package:abdullah_mansour/modules/counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  CounterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          // if (state is CounterInitialState){
          //print("Initial state");
          //}
          if (state is CounterMinusState) {
            print("Minus state ${state.counter}");
          }
          if (state is CounterPlusState) {
            print("Plus state ${state.counter}");
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      ///press on .get() and see the explainations
                      CounterCubit.get(context).minus();
                    },
                    child: Text("Minus"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "${CounterCubit.get(context).counter}",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ///press on .get() and see the explainations
                      CounterCubit.get(context).plus();
                    },
                    child: Text("Plus"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
