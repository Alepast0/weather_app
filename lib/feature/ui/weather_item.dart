import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/feature/domain/entity/weather/weather_entity.dart';

class WeatherItem extends StatelessWidget {
  final int index;
  final WeatherEntity itemEntity;

  const WeatherItem({Key? key, required this.index, required this.itemEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaleWidth = MediaQuery.of(context).size.width / 375;
    final scaleHeight = MediaQuery.of(context).size.height / 820;

    final itemTime =
        DateFormat.H().format(DateTime.fromMillisecondsSinceEpoch(itemEntity.dt! * 1000));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scaleWidth, vertical: 16 * scaleHeight),
      decoration: index == 0
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white, width: 2.0 * scaleWidth),
            )
          : null,
      height: 142 * scaleHeight,
      width: 74 * scaleWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 22 * scaleHeight,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                '$itemTime:00',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
              ),
            ),
          ),
          SizedBox(height: 32, width: 32, child: FittedBox(fit: BoxFit.fitHeight, child: getIconByWeather(itemEntity.main, itemTime))),
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

    if ((hour >= 19 || hour < 6)) {
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
