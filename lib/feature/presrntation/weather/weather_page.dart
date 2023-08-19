import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/feature/ui/weather_item.dart';

import 'weather_cubit.dart';

class WeatherPage extends StatefulWidget {
  final dynamic lat;
  final dynamic lon;
  final String country;

  const WeatherPage({Key? key, required this.lon, required this.lat, required this.country}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    context.read<WeatherCubit>().fetchCurrentWeather(lon: widget.lon, lat: widget.lat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaleWidth = MediaQuery.of(context).size.width / 375;
    final scaleHeight = MediaQuery.of(context).size.height / 820;

    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is Loading) {
          return Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1, -1),
                  end: Alignment(1, 1),
                  colors: <Color>[Color(0x700700ff), Color(0xff000000)],
                  stops: <double>[0, 1],
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ));
        }
        if (state is Success) {
          String windDirection = getWindDirection(state.currentWeatherEntity?.deg);
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1, -1),
                end: Alignment(1, 1),
                colors: <Color>[Color(0x700700ff), Color(0xff000000)],
                stops: <double>[0, 1],
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24 * scaleWidth, vertical: 24 * scaleHeight),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  height: 72 * scaleHeight,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 24 * scaleHeight,
                        child: const FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Icon(Icons.location_on_outlined, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 8 * scaleWidth,
                      ),
                      Expanded(
                        child: Text(
                          "${state.currentWeatherEntity?.cityName}, ${widget.country}",
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 180 * scaleHeight,
                      width: 180 * scaleWidth,
                      child: Stack(
                        children: [
                          ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                            child: Container(
                              width: 150 * scaleWidth,
                              height: 150 * scaleHeight,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffbc86ff),
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          getImageByWeather(state.currentWeatherEntity?.weather)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8 * scaleHeight,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 72 * scaleHeight,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            "${state.currentWeatherEntity?.temp?.toInt()}°",
                            style: Theme.of(context).textTheme.headline1?.copyWith(
                                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 64),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 56 * scaleHeight,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24 * scaleHeight,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                '${state.currentWeatherEntity?.main?.replaceRange(0, 1, state.currentWeatherEntity?.main?[0].toUpperCase() ?? '')}',
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8 * scaleHeight,
                          ),
                          SizedBox(
                            height: 24 * scaleHeight,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                'Макс.: ${state.currentWeatherEntity?.temp_max?.toInt()}° Мин.: ${state.currentWeatherEntity?.temp_min?.toInt()}°',
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 278 * scaleHeight,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24 * scaleWidth, vertical: 24 * scaleHeight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16 * scaleWidth, vertical: 16 * scaleHeight),
                          height: 56 * scaleHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 24 * scaleHeight,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    'Сегодня',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 22 * scaleHeight,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    DateFormat('d MMMM', 'ru_RU').format(DateTime.now()),
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16 * scaleWidth, vertical: 16 * scaleHeight),
                              itemCount: 10,
                              itemBuilder: (context, item) {
                                return WeatherItem(
                                    index: item, itemEntity: state.listWeatherEntity!.list[item]!);
                              }),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 120 * scaleHeight,
                  padding: EdgeInsets.only(
                      right: 24 * scaleWidth, left: 24 * scaleWidth, bottom: 24 * scaleHeight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16 * scaleWidth, vertical: 16 * scaleHeight),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24 * scaleHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        height: 24 * scaleHeight,
                                        width: 24 * scaleWidth,
                                        child: Image.asset("assets/icons/wind.png")),
                                    SizedBox(
                                      width: 8 * scaleWidth,
                                    ),
                                    SizedBox(
                                      height: 22 * scaleHeight,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          "${state.currentWeatherEntity?.wind?.toInt()} м/с",
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                              color: const Color.fromRGBO(255, 255, 255, 0.2),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 22 * scaleHeight,
                                  // width: 180 * scaleWidth,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text('Ветер $windDirection',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16 * scaleHeight,
                          ),
                          SizedBox(
                            height: 24 * scaleHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        height: 24 * scaleHeight,
                                        width: 24 * scaleWidth,
                                        child: Image.asset("assets/icons/humidity.png")),
                                    SizedBox(
                                      width: 10 * scaleWidth,
                                    ),
                                    SizedBox(
                                      height: 22 * scaleHeight,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          "${state.currentWeatherEntity?.humidity}%",
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                              color: const Color.fromRGBO(255, 255, 255, 0.2),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  // width: 180 * scaleWidth,
                                  height: 22 * scaleHeight,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                        _getHumidityText(state.currentWeatherEntity?.humidity),
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Text('Error');
      }),
    );
  }

  String getWindDirection(int? degrees) {
    if (degrees != null) {
      if (degrees >= 0 && degrees < 90) {
        return 'северо-восточный';
      } else if (degrees >= 90 && degrees < 180) {
        return 'юго-восточный';
      } else if (degrees >= 180 && degrees < 270) {
        return 'юго-западный';
      } else {
        return 'северо-западный';
      }
    } else {
      return '';
    }
  }

  String _getHumidityText(int? humidity) {
    if (humidity != null) {
      if (humidity >= 80) {
        return 'Высокая влажность';
      } else if (humidity >= 50) {
        return 'Средняя влажность';
      } else {
        return 'Низкая влажность';
      }
    } else {
      return '';
    }
  }

  Widget getImageByWeather(String? weather) {
    switch (weather) {
      case 'Thunderstorm':
        return Image.asset('assets/images/thunderstorm.png');
      case 'Snow':
        return Image.asset('assets/images/snow.png');
      case 'Clear':
        return Image.asset('assets/images/clear_sky.png');
      case 'Drizzle':
        return Image.asset('assets/images/rain.png');
      case 'Rain':
        return Image.asset('assets/images/rain.png');
      case 'Clouds':
        return Image.asset('assets/images/clouds.png');
      default:
        return Image.asset('assets/images/clouds.png');
    }
  }
}
