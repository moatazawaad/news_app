import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_news_app/shared/cubit/cubit.dart';
import 'package:flutter_udemy_news_app/shared/cubit/states.dart';

import '../../modules/search/search.dart';
import '../../shared/component/todo_components.dart';
import '../../shared/todo_app_cubit/todo_cubit.dart';
// import 'package:flutter_udemy_news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_2_outlined),
              ),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     DioHelper.getData(
          //       url: 'v2/top-headlines',
          //       query: {
          //         'country': 'eg',
          //         'category': 'business',
          //         'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
          //       },
          //     )
          //         .then((value) => {
          //               print(value.data.toString()),
          //             })
          //         .catchError((error) {
          //       print(error.toString());
          //     });
          //   },
          //   child: Icon(Icons.add),
          // ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
