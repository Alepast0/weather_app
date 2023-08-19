class CurrentWeatherModel {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  double? temp_min;
  double? temp_max;
  String? main;
  int? deg;
  String? weather;
  String? country;

  CurrentWeatherModel(
      {required this.cityName,
      required this.temp,
      required this.humidity,
      required this.wind,
      required this.temp_max,
      required this.temp_min,
      required this.main,
      required this.deg,
      required this.weather,
      required this.country});

  CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    cityName = json['name'];
    temp = json['main']['temp'];
    wind = json['wind']['speed'].runtimeType == double ? json['wind']['speed'] : (json['wind']['speed'] as int).toDouble();
    humidity = json['main']['humidity'];
    temp_min = json['main']['temp_min'];
    temp_max = json['main']['temp_max'];
    main = json["weather"][0]["description"];
    deg = json["wind"]["deg"];
    weather = json["weather"][0]["main"];
    country = json["sys"]["country"];
  }
}
