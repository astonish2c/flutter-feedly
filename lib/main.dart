import 'package:flutter/material.dart';

import 'Utils/utils.dart';
import 'classes/secure.dart';
import 'screens/home_screen.dart';

void main(List<String> args) {
  Secure.load();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.scaffoldMessengerState,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Feedly',
      home: const HomeScreen(),
    );
  }
}
