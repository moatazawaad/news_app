import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import '../todo_app_cubit/todo_cubit.dart';
// import 'package:flutter_udemy_news_app/shared/cubit/cubit.dart';

Widget loginButton({
  double width = double.infinity,
  Color background = Colors.red,
  bool isUpperCase = true,
  double height = 40.0,
  double radius = 10.0,
  //it was Function but not worked until changed to VoidCallBack
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultFormText({
  required TextEditingController controller,
  required TextInputType type,
  FormFieldValidator<String>? onSubmit,
  FormFieldValidator<String>? onChange,
  bool isPassword = false,
  VoidCallback? onTab,
  final String? value,
  final FormFieldValidator<String>? validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      //  keyboardAppearance: Brightness.dark,
      controller: controller,
      obscureText: isPassword,
      onTap: onTab,
      keyboardType: type,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      // onChanged: (String? value) {
      //   onChange;
      // },
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        // hintText: 'Email',
        labelText: label,
        // hintStyle: TextStyle(
        //   color: Colors.red,
        // ),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon))
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['id'],
                );
              },
              icon: Icon(
                Icons.check_box,
              ),
              color: Colors.green,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'archive',
                  id: model['id'],
                );
              },
              icon: Icon(
                Icons.archive,
              ),
              color: Colors.black54,
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(
          id: model['id'],
        );
      },
    );

Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0),
          child: Container(
            width: double.infinity,
            height: 2.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 100.0,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
