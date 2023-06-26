import 'package:equatable/equatable.dart';

class CurrentWeatherEntity extends Equatable {
  final String? cityName;
  final double? temp;
  final double? wind;
  final int? humidity;
  final double? temp_min;
  final double? temp_max;
  final String? main;
  final int? deg;
  final String? weather;
  final String? country;

  const CurrentWeatherEntity(
      {required this.temp,
      required this.cityName,
      required this.wind,
      required this.humidity,
      required this.temp_max,
      required this.temp_min,
      required this.main,
      required this.deg,
      required this.weather,
      required this.country});

  @override
  List<Object?> get props =>
      [cityName, temp, wind, humidity, temp_max, temp_min, main, deg, weather, country];
}
