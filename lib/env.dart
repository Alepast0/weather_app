import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/injection.dart';

import 'feature/data/data_sourse/hive.dart';
import 'main.dart';

class Env {
  Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await HiveInitializer.initializeHive();
    await initializeDateFormatting('ru_RU');
    await Firebase.initializeApp();
    final injectionContainer = await injection(const App());
    runApp(injectionContainer);
  }
}
