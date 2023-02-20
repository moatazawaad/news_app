import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_news_app/shared/cubit/cubit.dart';
import 'package:flutter_udemy_news_app/shared/cubit/states.dart';

class TestConnectionScreen extends StatelessWidget {
  TestConnectionScreen({Key? key}) : super(key: key);

  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: RefreshIndicator(
            key: keyRefresh,
            onRefresh: () async {
              NewsCubit.get(context).getBusiness();
            },
            child: Column(
              children: [
                Text(
                    "Active Connection? ${NewsCubit.get(context).ActiveConnection}"),
                const Divider(),
                Text(NewsCubit.get(context).T),
                OutlinedButton(
                    onPressed: () {
                      NewsCubit.get(context).CheckUserConnection();
                    },
                    child: const Text("Check"))
              ],
            ),
          ),
        );
      },
    );
  }
}
