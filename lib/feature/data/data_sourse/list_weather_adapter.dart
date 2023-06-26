import 'package:hive/hive.dart';
import 'package:weather/feature/domain/entity/weather/list_weeather_entity.dart';
import 'package:weather/feature/domain/entity/weather/weather_entity.dart';

class ListWeatherAdapter extends TypeAdapter<ListWeatherEntity> {
  @override
  final int typeId = 1;

  @override
  ListWeatherEntity read(BinaryReader reader) {
    final listLength = reader.readInt();
    final list = List<WeatherEntity?>.generate(listLength, (_) => null);

    for (int i = 0; i < listLength; i++) {
      list[i] = WeatherEntity(
        dt: reader.readInt(),
        temp: reader.readDouble(),
        main: reader.readString(),
      );
    }

    return ListWeatherEntity(list: list);
  }

  @override
  void write(BinaryWriter writer, ListWeatherEntity obj) {
    writer.writeInt(obj.list.length);

    for (final weatherEntity in obj.list) {
      writer.writeInt(weatherEntity!.dt!);
      writer.writeDouble(weatherEntity.temp!);
      writer.writeString(weatherEntity.main!);
    }
  }
}
