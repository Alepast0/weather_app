import 'package:hive/hive.dart';
import 'package:weather/feature/domain/entity/weather/current_weather_entity.dart';

class CurrentWeatherAdapter extends TypeAdapter<CurrentWeatherEntity> {
  @override
  final int typeId = 0;
  @override
  CurrentWeatherEntity read(BinaryReader reader) {
    return CurrentWeatherEntity(
      temp: reader.readDouble(),
      cityName: reader.readString(),
      wind: reader.readDouble(),
      humidity: reader.readInt(),
      temp_max: reader.readDouble(),
      temp_min: reader.readDouble(),
      main: reader.readString(),
      deg: reader.readInt(),
      weather: reader.readString(),
      country: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, CurrentWeatherEntity obj) {
    writer.writeDouble(obj.temp!);
    writer.writeString(obj.cityName!);
    writer.writeDouble(obj.wind!);
    writer.writeInt(obj.humidity!);
    writer.writeDouble(obj.temp_max!);
    writer.writeDouble(obj.temp_min!);
    writer.writeString(obj.main!);
    writer.writeInt(obj.deg!);
    writer.writeString(obj.weather!);
    writer.writeString(obj.country!);
  }
}
