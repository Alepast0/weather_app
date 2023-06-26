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
                  // fontFamily: "Ubuntu",
                  fontSize: 32,
                  height: 1.125,
                  leadingDistribution: TextLeadingDistribution.even,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              headline2: TextStyle(
                  // fontFamily: "Ubuntu",
                  fontSize: 22,
                  height: 1.12,
                  leadingDistribution: TextLeadingDistribution.even))),
      home: const Splash(),
    );
  }
}
