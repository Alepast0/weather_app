import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/core/extension.dart';
import 'package:weather/feature/presrntation/auth/auth_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late final latitude;
  late final longitude;

  @override
  void initState() {
    super.initState();
    getLocation().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AuthScreen(lat: latitude, lon: longitude,))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 39.33.hp, left: 11.0.hp),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1, -1),
            end: Alignment(1, 1),
            colors: <Color>[Color(0xff0700ff), Color(0xff000000)],
            stops: <double>[0, 1],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 11.5.wp, 32.0.hp),
              constraints: BoxConstraints(
                maxWidth: 58.25.wp,
              ),
              child: const Text(
                'WEATHER SERVICE',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.7.wp, 0, 0, 0),
              child: const Text(
                'dawn is coming soon',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getLocation() async {
    PermissionStatus permissionStatus = await Permission.locationWhenInUse.status;

    if (permissionStatus.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude;
      longitude = position.longitude;

      setState(() {});
    } else {
      if (permissionStatus.isDenied) {
        await Permission.locationWhenInUse.request();
      } else {
        await Permission.locationWhenInUse.request();
      }

      permissionStatus = await Permission.locationWhenInUse.status;

      if (permissionStatus.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        latitude = position.latitude;
        longitude = position.longitude;

        setState(() {});
      } else {
        print('Не удалось получить разрешение на доступ к местоположению');
      }
    }
  }
}
