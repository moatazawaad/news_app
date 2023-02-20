import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_news_app/shared/component/components.dart';
import 'package:flutter_udemy_news_app/shared/cubit/cubit.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  BusinessScreen({Key? key}) : super(key: key);

  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return ScreenTypeLayout(
          mobile: Builder(
            builder: (BuildContext context) {
              NewsCubit.get(context).setDesktop(false);

              return RefreshIndicator(
                onRefresh: () async {
                  NewsCubit.get(context).getBusiness();
                },
                key: keyRefresh,
                child: articleBuilder(list, context),
              );
            },
          ),
          desktop: Builder(
            builder: (BuildContext context) {
              NewsCubit.get(context).setDesktop(true);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        NewsCubit.get(context).getBusiness();
                      },
                      key: keyRefresh,
                      child: articleBuilder(list, context),
                    ),
                  ),
                  if (list.isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${list[NewsCubit.get(context).selectedBusinessItem]['description']}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          breakpoints: ScreenBreakpoints(desktop: 600, tablet: 600, watch: 100),
        );
      },
    );
  }
}
