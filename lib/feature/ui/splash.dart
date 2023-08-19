import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/feature/presrntation/auth/auth_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late final latitude;
  late final longitude;
  late final country;

  @override
  void initState() {
    super.initState();
    getLocation().then((value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AuthScreen(
                  lat: latitude,
                  lon: longitude,
                  country: country,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    final scaleWidth = MediaQuery.of(context).size.width / 375;
    final scaleHeight = MediaQuery.of(context).size.height / 820;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 292 * scaleHeight, left: 48 * scaleWidth),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 245 * scaleWidth,
              height: 114 * scaleHeight,
              margin: EdgeInsets.fromLTRB(0, 0, 20 * scaleWidth, 288 * scaleHeight),
              constraints: BoxConstraints(
                maxWidth: 250 * scaleWidth,
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
            SizedBox(
              height: 32 * scaleHeight,
              width: 300 * scaleWidth,
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

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        country = placemark.country ?? 'Unknown Country';
      }

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

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks[0];
          country = placemark.country ?? 'Unknown Country';
        }

        setState(() {});
      } else {
        print('Не удалось получить разрешение на доступ к местоположению');
      }
    }
  }
}
