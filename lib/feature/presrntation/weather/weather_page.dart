import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/extension.dart';
import 'package:weather/feature/ui/weather_item.dart';

import 'weather_cubit.dart';

class WeatherPage extends StatefulWidget {
  final dynamic lat;
  final dynamic lon;

  const WeatherPage({Key? key, required this.lon, required this.lat}) : super(key: key);

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
    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is Loading) {
          return Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1, -1),
                  end: Alignment(1, 1),
                  colors: <Color>[Color(0xff0700ff), Color(0xff000000)],
                  stops: <double>[0, 1],
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
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
                colors: <Color>[Color(0xff0700ff), Color(0xff000000)],
                stops: <double>[0, 1],
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.83.wp),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  height: 8.09.hp,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 5.83.wp,
                      ),
                      SizedBox(
                        width: 4.86.wp,
                      ),
                      Text(
                        "${state.currentWeatherEntity?.cityName}, ${state.currentWeatherEntity?.country}",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 43.75.wp,
                      height: 20.22.hp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(189, 135, 255, 0.5),
                            blurRadius: 5.62.hp,
                          ),
                        ],
                      ),
                      child: getImageByWeather(state.currentWeatherEntity?.weather),
                    ),
                    SizedBox(
                      height: 1.0.hp,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 8.09.hp,
                      child: Center(
                        child: Text(
                          "${state.currentWeatherEntity?.temp?.toInt()}°",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 64, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.0.hp,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 6.29.hp,
                      child: Column(
                        children: [
                          Text(
                            '${state.currentWeatherEntity?.main?.replaceRange(0, 1, state.currentWeatherEntity?.main?[0].toUpperCase() ?? '')}',
                            style: const TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          SizedBox(
                            height: 0.9.hp,
                          ),
                          Text(
                            'Макс.: ${state.currentWeatherEntity?.temp_max?.toInt()}° Мин.: ${state.currentWeatherEntity?.temp_min?.toInt()}°',
                            style: const TextStyle(fontSize: 17, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 35.0.hp,
                  padding: EdgeInsets.all(5.83.wp),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.89.wp),
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.86.wp),
                          height: 6.9.hp,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Сегодня',
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                              Text(
                                DateFormat('d MMMM', 'ru_RU').format(DateTime.now()),
                                style: const TextStyle(fontSize: 15, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 0.11.hp,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.all(1.8.hp),
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
                  height: 12.0.hp,
                  padding: EdgeInsets.symmetric(horizontal: 5.83.wp),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.8.hp),
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.86.wp),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 2.71.hp,
                                      width: 5.83.wp,
                                      child: Image.asset("assets/icons/wind.png")),
                                  SizedBox(
                                    width: 2.43.wp,
                                  ),
                                  Text(
                                    "${state.currentWeatherEntity?.wind} м/с",
                                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 40.0.wp,
                                child: Text(windDirection,
                                    style: const TextStyle(color: Colors.white, fontSize: 15)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.5.hp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 2.71.hp,
                                      width: 5.83.wp,
                                      child: Image.asset("assets/icons/humidity.png")),
                                  SizedBox(
                                    width: 2.43.wp,
                                  ),
                                  Text(
                                    "${state.currentWeatherEntity?.humidity}%",
                                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 40.0.wp,
                                child: Text(_getHumidityText(state.currentWeatherEntity?.humidity),
                                    style: const TextStyle(color: Colors.white, fontSize: 15)),
                              )
                            ],
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
        return 'Северо-восточный';
      } else if (degrees >= 90 && degrees < 180) {
        return 'Юго-восточный';
      } else if (degrees >= 180 && degrees < 270) {
        return 'Юго-западный';
      } else {
        return 'Северо-западный';
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
