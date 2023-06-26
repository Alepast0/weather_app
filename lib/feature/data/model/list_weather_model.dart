import 'weather_model.dart';

class ListWeatherModel {
  List<WeatherModel?> list = [];

  ListWeatherModel({required this.list});

  ListWeatherModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonList = json['list'];
    list = jsonList.map((item) => WeatherModel.fromJson(item)).toList();
  }
}
