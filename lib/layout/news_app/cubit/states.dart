abstract class NewsStates {}

class NewSInitialState extends NewsStates {}

class NewSBottomNavState extends NewsStates {}

class NewSGetBusinessLoadingState extends NewsStates {}

class NewSGetBusinessSuccessState extends NewsStates {}

class NewSGetBusinessErrorState extends NewsStates {
  final String error;

  NewSGetBusinessErrorState(this.error);
}
