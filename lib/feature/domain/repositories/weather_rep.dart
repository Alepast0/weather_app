import 'package:weather/feature/domain/entity/weather/current_weather_entity.dart';
import 'package:weather/feature/domain/entity/weather/list_weeather_entity.dart';

abstract class CurrentWeatherRep {
  Future<CurrentWeatherEntity?> getCurrentWeather({required double? lon, required double? lat});

  Future<ListWeatherEntity?> getListWeather({required double? lon, required double? lat});
}
