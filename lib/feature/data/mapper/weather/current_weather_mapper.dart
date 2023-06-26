import 'package:weather/feature/data/mapper/mapper.dart';
import 'package:weather/feature/data/model/current_weather_model.dart';
import 'package:weather/feature/domain/entity/weather/current_weather_entity.dart';

class CurrentWeatherMapper extends Mapper<CurrentWeatherModel, CurrentWeatherEntity> {
  @override
  CurrentWeatherEntity? map(CurrentWeatherModel? entity) {
    return CurrentWeatherEntity(
        temp: entity?.temp ?? 0,
        cityName: entity?.cityName ?? '',
        wind: entity?.wind ?? 0,
        humidity: entity?.humidity ?? 0,
        temp_max: entity?.temp_max ?? 0,
        temp_min: entity?.temp_min ?? 0,
        main: entity?.main ?? '',
        deg: entity?.deg ?? 0,
        weather: entity?.weather ?? '',
        country: entity?.country ?? '');
  }
}
