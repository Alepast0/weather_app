import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:weather/feature/data/mapper/weather/current_weather_mapper.dart';
import 'package:weather/feature/data/mapper/weather/list_weather_mapper.dart';
import 'package:weather/feature/data/model/current_weather_model.dart';
import 'package:weather/feature/data/model/list_weather_model.dart';
import 'package:weather/feature/domain/entity/weather/current_weather_entity.dart';
import 'package:weather/feature/domain/entity/weather/list_weeather_entity.dart';
import 'package:weather/feature/domain/repositories/weather_rep.dart';

class CurrentWeatherFailure implements Exception {}

class CurrentWeatherRepImpl implements CurrentWeatherRep {
  CurrentWeatherRepImpl(this.boxCurrent, this.boxList, {required this.currentWeatherMapper, required this.listWeatherMapper});

  final CurrentWeatherMapper currentWeatherMapper;
  final Box<CurrentWeatherEntity> boxCurrent;
  final Box<ListWeatherEntity> boxList;
  final ListWeatherMapper listWeatherMapper;

  @override
  Future<CurrentWeatherEntity?> getCurrentWeather({required double? lon, required double? lat}) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        final currentWeather = boxCurrent.get('currentWeather');
        if (currentWeather != null) {
          return currentWeather;
        }
      } else {
        final request = Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=ru&appid=bded3297c4c4b696e8383b0cde4e69dd&units=metric");
        final response = await http.get(request);
        final _response = CurrentWeatherModel.fromJson(json.decode(response.body));
        final currentWeather = currentWeatherMapper.map(_response);

        await boxCurrent.clear();
        await boxCurrent.put('currentWeather', currentWeather!);

        return currentWeather;
      }
    } catch (e, c) {
      print(e);
      print(c);
      throw CurrentWeatherFailure();
    }
  }

  @override
  Future<ListWeatherEntity?> getListWeather({required double? lon, required double? lat}) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        final listWeather = boxList.get('weatherList');
        if (listWeather != null) {
          return listWeather;
        }
      } else {
        final request = Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?lat=57&lon=-2.15&appid=bded3297c4c4b696e8383b0cde4e69dd&lang=ru&units=metric");
        final response = await http.get(request);
        final _response = ListWeatherModel.fromJson(json.decode(response.body));
        final listWeather = listWeatherMapper.map(_response);

        await boxList.clear();
        await boxList.put('weatherList', listWeather!);

        return listWeather;
      }
    } catch (e, c) {
      print(e);
      print(c);
      throw CurrentWeatherFailure();
    }
  }
}
