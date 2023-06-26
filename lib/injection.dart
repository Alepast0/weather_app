import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weather/feature/data/mapper/weather/current_weather_mapper.dart';
import 'package:weather/feature/data/mapper/weather/list_weather_mapper.dart';
import 'package:weather/feature/data/mapper/weather/weather_mapper.dart';
import 'package:weather/feature/data/repositories/auth_rep.dart';
import 'package:weather/feature/data/repositories/weather_rep.dart';
import 'package:weather/feature/domain/entity/weather/current_weather_entity.dart';
import 'package:weather/feature/domain/entity/weather/list_weeather_entity.dart';
import 'package:weather/feature/domain/repositories/auth_rep.dart';
import 'package:weather/feature/domain/repositories/weather_rep.dart';

Future<Widget> injection(Widget app) async {
  final currentWeatherMapper = CurrentWeatherMapper();
  final weatherMapper = WeatherMapper();
  final listWeatherMapper = ListWeatherMapper(weatherMapper: weatherMapper);

  final currentBox = Hive.box<CurrentWeatherEntity>('currentWeather');
  final listBox = Hive.box<ListWeatherEntity>('weatherList');

  final currentWeatherRepositoryImpl = CurrentWeatherRepImpl(currentBox, listBox,
      currentWeatherMapper: currentWeatherMapper, listWeatherMapper: listWeatherMapper);
  final authRepositoryImpl = AuthRepositoryImpl();

  return MultiRepositoryProvider(providers: [
    RepositoryProvider<AuthRepository>(create: (_) => authRepositoryImpl),
    RepositoryProvider<CurrentWeatherRep>(create: (_) => currentWeatherRepositoryImpl),
  ], child: app);
}
