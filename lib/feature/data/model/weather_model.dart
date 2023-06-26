class WeatherModel{
  int? dt;
  double? temp;
  String? main;
  WeatherModel({required this.dt, required this.main, required this.temp});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    temp = json['main']['temp'];
    main = json["weather"][0]["main"];
    dt = json['dt'];
  }
}