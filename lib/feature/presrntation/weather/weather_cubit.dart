import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/feature/domain/entity/weather/current_weather_entity.dart';
import 'package:weather/feature/domain/entity/weather/list_weeather_entity.dart';
import 'package:weather/feature/domain/repositories/weather_rep.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class Success extends WeatherState {
  Success({required this.currentWeatherEntity, required this.listWeatherEntity});

  final CurrentWeatherEntity? currentWeatherEntity;
  final ListWeatherEntity? listWeatherEntity;

  @override
  List<Object?> get props => [currentWeatherEntity, listWeatherEntity];
}

class ListSuccess extends WeatherState {
  ListSuccess({required this.listWeatherEntity});

  final ListWeatherEntity? listWeatherEntity;

  @override
  List<Object?> get props => [ListWeatherEntity];
}

class WeatherError extends WeatherState {
  final String error;

  WeatherError(this.error);

  @override
  List<Object?> get props => [error];
}

class WeatherCubit extends Cubit<WeatherState> {
  final CurrentWeatherRep currentWeatherRep;

  WeatherCubit(this.currentWeatherRep) : super(Loading());

  Future<void> fetchCurrentWeather({required double lon, required double lat}) async {
    try {
      emit(Loading());
      final currentWeather = await currentWeatherRep.getCurrentWeather(lon: lon, lat: lat);
      final listWeather = await currentWeatherRep.getListWeather(lon: lon, lat: lat);
      emit(Success(
        currentWeatherEntity: currentWeather,
        listWeatherEntity: listWeather,
      ));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
