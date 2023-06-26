import 'package:weather/feature/data/mapper/mapper.dart';
import 'package:weather/feature/data/model/list_weather_model.dart';
import 'package:weather/feature/domain/entity/weather/list_weeather_entity.dart';

import 'weather_mapper.dart';

class ListWeatherMapper extends Mapper<ListWeatherModel, ListWeatherEntity> {
  final WeatherMapper weatherMapper;

  ListWeatherMapper({required this.weatherMapper});

  @override
  ListWeatherEntity? map(ListWeatherModel? entity) {
    return ListWeatherEntity(list: weatherMapper.mapList(entity?.list));
  }
}
