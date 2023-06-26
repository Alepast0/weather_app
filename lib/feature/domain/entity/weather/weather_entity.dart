import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable{
  final int? dt;
  final double? temp;
  final String? main;

  const WeatherEntity({required this.temp, required this.main, required this.dt});

  @override
  List<Object?> get props => [dt, temp, main];
}