import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/extension.dart';
import 'package:weather/feature/domain/entity/weather/weather_entity.dart';

class WeatherItem extends StatelessWidget {
  final int index;
  final WeatherEntity itemEntity;

  const WeatherItem({Key? key, required this.index, required this.itemEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemTime =
        DateFormat.H().format(DateTime.fromMillisecondsSinceEpoch(itemEntity.dt! * 1000));
    return Container(
      padding: EdgeInsets.all(1.8.hp),
      decoration: index == 0
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(1.35.hp),
              border: Border.all(color: Colors.white, width: 2.0),
            )
          : null,
      height: 15.96.hp,
      width: 20.19.wp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$itemTime:00',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
          ),
          getIconByWeather(itemEntity.main, itemTime),
          Text(
            "${itemEntity.temp?.toInt()}°",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
          )
        ],
      ),
    );
  }

  Widget getIconByWeather(String? weather, String dateTime) {
    final int hour = int.parse(dateTime);
    print(weather);

    if (weather == 'Clouds' && (hour >= 19 || hour < 6)) {
      return Image.asset('assets/images/CloudMoon.png');
    } else {
      switch (weather) {
        case 'Thunderstorm':
          return Image.asset('assets/images/CloudLightning.png');
        case 'Snow':
          return Image.asset('assets/images/CloudSnow.png');
        case 'Clear':
          return Image.asset('assets/images/Sun.png');
        case 'Drizzle':
          return Image.asset('assets/images/rain.png');
        case 'Rain':
          return Image.asset('assets/images/CloudRain.png');
        default:
          return Image.asset('assets/images/CloudSun.png');
      }
    }
  }
}
