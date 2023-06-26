import 'package:equatable/equatable.dart';

import 'weather_entity.dart';

class ListWeatherEntity extends Equatable {
  final List<WeatherEntity?> list;

  const ListWeatherEntity({required this.list});

  @override
  List<Object?> get props => [list];
}
