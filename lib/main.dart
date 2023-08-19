import 'package:flutter/material.dart';
import 'package:weather/development.dart';
import 'package:weather/feature/ui/splash.dart';

Future<void> main() async => Development().init();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontFamily: "Ubuntu",
                  color: Colors.black),
              bodyText1: TextStyle(
                fontFamily: "Roboto",
                fontSize: 15,
              ),)),
      home: const Splash(),
    );
  }
}
