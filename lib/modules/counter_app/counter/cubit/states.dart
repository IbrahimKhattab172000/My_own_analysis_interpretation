abstract class CounterStates {}

class CounterInitialState extends CounterStates {}

class CounterPlusState extends CounterStates {
  final int counter;

  CounterPlusState({
    required this.counter,
  });
}

class CounterMinusState extends CounterStates {
  final int counter;

  CounterMinusState({
    required this.counter,
  });
}
