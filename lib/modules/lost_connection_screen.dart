import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LostConnectionScreen extends StatelessWidget {
  const LostConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_outlined),
          Text('Please check your data connecion and try again'),
        ],
      ),
    );
  }
}
