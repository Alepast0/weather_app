import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather/feature/data/data_sourse/current_weather_adapter.dart';
import 'package:weather/feature/data/data_sourse/list_weather_adapter.dart';
import 'package:weather/feature/domain/entity/weather/current_weather_entity.dart';
import 'package:weather/feature/domain/entity/weather/list_weeather_entity.dart';

class HiveInitializer {
  static Future<void> initializeHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final path = appDocumentDir.path;
    Hive.init(path);
    Hive.registerAdapter(CurrentWeatherAdapter());
    Hive.registerAdapter(ListWeatherAdapter());
    await Hive.openBox<CurrentWeatherEntity>('currentWeather');
    await Hive.openBox<ListWeatherEntity>('weatherList');
  }
}
