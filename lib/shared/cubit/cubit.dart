import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_news_app/modules/business/business.dart';
import 'package:flutter_udemy_news_app/modules/lost_connection_screen.dart';
import 'package:flutter_udemy_news_app/modules/science/science.dart';
import 'package:flutter_udemy_news_app/modules/sports/sports.dart';
import 'package:flutter_udemy_news_app/shared/cubit/states.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_soccer),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    // SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    // // لو مش هتحمل داتا عن طريق دوسه زرار شاشه دى يبقى شيل اف كونديشن هنا
    if (index == 1) getSports();
    //if (index == 0) getBusiness();
    if (index == 2) getScience();
    emit(NewsBotNavBarState());
  }

  List<dynamic> business = [];
  // List<bool> businessSelectedItem = [];
  int selectedBusinessItem = 1;
  bool isDektop = false;

  void setDesktop(bool value) {
    isDektop = value;

    emit(NewsSetDesktopState());
  }

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '0eb61629c5d24b7dae2a29b204068ed9',
      },
    )
        .then((value) => {
              // print(value.data.toString()),
              business = value.data['articles'],
              // business.forEach((element) {
              //   businessSelectedItem.add(false);
              // }),
              // print(business[0]['title']),
              emit(NewsGetBusinessSuccessState()),
            })
        .catchError((error) {
      // print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
      return LostConnectionScreen();
    });
  }

  void selectBusinessItem(index) {
    // for (int i = 0; i < businessSelectedItem.length; i++) {
    //   if (i == index)
    //     businessSelectedItem[i] = true;
    //   else {
    //     businessSelectedItem[i] = false;
    //   }
    // }
    selectedBusinessItem = index;
    emit(NewsSelectBusinessItemSuccessState());
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    // لو مش هتحمل داتا عن طريق دوسه زرار شاشه دى يبقى شيل اف كونديشن هنا
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '0eb61629c5d24b7dae2a29b204068ed9',
        },
      )
          .then((value) => {
                // print(value.data.toString()),
                sports = value.data['articles'],
                // print(sports[0]['title']),
                emit(NewsGetSportsSuccessState()),
              })
          .catchError((error) {
        // print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    // لو مش هتحمل داتا عن طريق دوسه زرار شاشه دى يبقى شيل اف كونديشن هنا
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '0eb61629c5d24b7dae2a29b204068ed9',
        },
      )
          .then((value) => {
                // print(value.data.toString()),
                science = value.data['articles'],
                //  print(science[0]['title']),
                emit(NewsGetScienceSuccessState()),
              })
          .catchError((error) {
        // print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;
  // ThemeMode appMode = ThemeMode.dark;

  void changeAppMode() {
    isDark = !isDark;
    emit(NewsAppChangeModeState());
  }

  List<dynamic> search = [];

  void getSearch(value) {
    emit(NewsGetSearchLoadingState());
    // search = [];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        // 'from': '2022-07-24',
        // 'sortBy': 'publishedAt',
        'apiKey': '0eb61629c5d24b7dae2a29b204068ed9',
      },
    )
        .then((value) => {
              // print(value.data.toString()),
              search = value.data['articles'],
              //   print(search[0]['title']),
              emit(NewsGetSearchSuccessState()),
            })
        .catchError((error) {
      //  print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  // void getSearch(value) {
  //   emit(NewsGetSearchLoadingState());
  //   // search = [];
  //
  //   DioHelper.getData(
  //     url: 'v2/everything',
  //     query: {
  //       'q': '$value',
  //       'apiKey': '0eb61629c5d24b7dae2a29b204068ed9',
  //     },
  //   )
  //       .then((value) => {
  //     // print(value.data.toString()),
  //     search = value.data['articles'],
  //     print(search[0]['title']),
  //     emit(NewsGetSearchSuccessState()),
  //   })
  //       .catchError((error) {
  //     print(error.toString());
  //     emit(NewsGetSearchErrorState(error.toString()));
  //   });
  // }

  // List<dynamic> searchBus = [];
  //
  // void getSearchBus(String? value) {
  //   emit(NewsGetSearchBusLoadingState());
  //   // search = [];
  //
  //   DioHelper.getData(
  //     url: 'v2/top-headlines',
  //     query: {
  //       'country': 'eg',
  //       'category': 'business',
  //       'apiKey': '0eb61629c5d24b7dae2a29b204068ed9',
  //     },
  //   )
  //       .then((value) => {
  //             // print(value.data.toString()),
  //             searchBus = value.data['articles'],
  //             print(searchBus[0]['title']),
  //             emit(NewsGetSearchBusSuccessState()),
  //           })
  //       .catchError((error) {
  //     print(error.toString());
  //     emit(NewsGetSearchBusErrorState(error.toString()));
  //   });
  // }

  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    emit(CheckConnection());
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        ActiveConnection = true;
        T = "Turn off the data and repress again";
        emit(ConnectionSuccess());
      }
    } on SocketException catch (_) {
      ActiveConnection = false;
      T = "Turn On the data and repress again";
      emit(ConnectionLost());
    }
  }
  // void initState() {
  //   CheckUserConnection();
  //   super.initState();
  // }
}
