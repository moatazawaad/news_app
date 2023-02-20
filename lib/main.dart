import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_news_app/shared/bloc_observer.dart';
import 'package:flutter_udemy_news_app/shared/cubit/cubit.dart';
import 'package:flutter_udemy_news_app/shared/network/local/cache_helper.dart';
import 'package:flutter_udemy_news_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_udemy_news_app/shared/todo_app_cubit/todo_cubit.dart';
import 'package:flutter_udemy_news_app/shared/todo_app_cubit/todo_states.dart';
import 'package:hexcolor/hexcolor.dart';
import 'layout/new_app_package/news_app.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  if (Platform.isWindows)
    await DesktopWindow.setMinWindowSize(
      const Size(600, 300),
    );

  // bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // late final bool isDark;
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMode(
              fromShared: null,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            // دى بانر كلمه ديباج الى ع يمين من فوق
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // primary color or primary swatch ht8er color f ae widget
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.white,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.green,
              ),
              //app bar theme التعديل فيه ينطبق ع ابلكيشن كله
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: Colors.white,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.green,
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.green,
                elevation: 10.0,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              // primary color or primary swatch ht8er color f ae widget
              primarySwatch: Colors.green,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.green,
              ),
              //app bar theme التعديل فيه ينطبق ع ابلكيشن كله
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.green,
                elevation: 10.0,
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey,
              ),
              scaffoldBackgroundColor: HexColor('333739'),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            // home: ScreenTypeLayout(
            //   mobile: NewsLayout(),
            //   desktop: Text(
            //     'DESKTOP IS HERE',
            //   ),
            //   breakpoints: ScreenBreakpoints(
            //     desktop: 600,
            //     tablet: 300,
            //     watch: 300,
            //   ),
            // ),
            home: const NewsLayout(),
          );
        },
      ),
    );
  }

// for arabic and english
// home: const Directionality(
// textDirection: TextDirection.rtl,
// child: NewsLayout(),
}
