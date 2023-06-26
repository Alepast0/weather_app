import 'package:weather/feature/data/mapper/mapper.dart';
import 'package:weather/feature/data/model/weather_model.dart';
import 'package:weather/feature/domain/entity/weather/weather_entity.dart';

class WeatherMapper extends Mapper<WeatherModel, WeatherEntity> {
  @override
  WeatherEntity? map(WeatherModel? entity) {
    return WeatherEntity(temp: entity?.temp ?? 0, main: entity?.main ?? '', dt: entity?.dt ?? 0);
  }
}
