import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/component/components.dart';
import '../../shared/component/todo_components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormText(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (String? value) {
                    NewsCubit.get(context).getSearch(value);
                    // return null;
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefixIcon: Icons.search,
                ),
              ),
              Expanded(
                child: articleBuilder(
                  list,
                  context,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
