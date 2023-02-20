abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBotNavBarState extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsSelectBusinessItemSuccessState extends NewsStates {}

class NewsSetDesktopState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsAppChangeModeState extends NewsStates {}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}

class NewsGetSearchBusLoadingState extends NewsStates {}

class NewsGetSearchBusSuccessState extends NewsStates {}

class NewsGetSearchBusErrorState extends NewsStates {
  final String error;

  NewsGetSearchBusErrorState(this.error);
}

class CheckConnection extends NewsStates {}

class ConnectionSuccess extends NewsStates {}

class ConnectionLost extends NewsStates {}
