import 'package:abdullah_mansour/modules/counter_app/counter/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialState());

  //*To be more easy when use this cubit in many places

  //* {static CounterCubit get(context)} is like a method returning an instant of our Cubit
  //* and it can be accessed therefore all the other components inside the same Cubit here can be access
  //* & {BlocProvider.of(context);} is just the way we can access our Cubit
  //* So instead of writing everytime {BlocProvider.of(context);}
  //* ... we will use .get() and access what's inside of it from methods or variables
  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void minus() {
    counter--;
    emit(CounterMinusState(counter: counter));
  }

  void plus() {
    counter++;
    emit(CounterPlusState(counter: counter));
  }
}
