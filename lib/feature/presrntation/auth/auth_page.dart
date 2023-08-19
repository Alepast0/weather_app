import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/feature/domain/repositories/auth_rep.dart';
import 'package:weather/feature/domain/repositories/weather_rep.dart';
import 'package:weather/feature/presrntation/auth/auth_cubit.dart';
import 'package:weather/feature/presrntation/weather/weather_cubit.dart';
import 'package:weather/feature/presrntation/weather/weather_page.dart';

class AuthScreen extends StatelessWidget {
  final dynamic lat;
  final dynamic lon;
  final String country;

  const AuthScreen({Key? key, required this.lat, required this.lon, required this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider(
              create: (_) => WeatherCubit(RepositoryProvider.of<CurrentWeatherRep>(context)),
              child: WeatherPage(
                lon: lon,
                lat: lat,
                country: country,
              ),
            );
          }
          return BlocProvider(
              create: (_) => AuthCubit(RepositoryProvider.of<AuthRepository>(context)),
              child: const AuthPage());
        });
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaleWidth = MediaQuery.of(context).size.width / 375;
    final scaleHeight = MediaQuery.of(context).size.height / 812;

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        }
      }, builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 24 * scaleWidth,
                      top: 11 * scaleHeight,
                      right: 24 * scaleWidth,
                      bottom: 16 * scaleHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 26 * scaleHeight,
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 11 * scaleHeight,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 66 * scaleHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 32 * scaleHeight,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "Вход",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12 * scaleHeight,
                            ),
                            SizedBox(
                              height: 22 * scaleHeight,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "Введите данные для входа",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 96 * scaleHeight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8 * scaleHeight,
                        right: 24 * scaleWidth,
                        bottom: 24 * scaleWidth,
                        left: 24 * scaleWidth),
                    child: Padding(
                      padding: EdgeInsets.only(top: 27 * scaleHeight),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Пожалуйста введите Ваш Email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 17),
                            focusColor: Colors.black,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color.fromRGBO(7, 0, 255, 1), width: 1))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 96 * scaleHeight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8 * scaleHeight,
                        right: 24 * scaleWidth,
                        bottom: 24 * scaleHeight,
                        left: 24 * scaleWidth),
                    child: Padding(
                      padding: EdgeInsets.only(top: 27 * scaleHeight),
                      child: TextFormField(
                        obscureText: obscureText,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Пожалуйста введите Ваш пароль";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: obscureText
                                  ? const Icon(
                                      Icons.visibility_outlined,
                                      color: Color.fromRGBO(7, 0, 255, 1),
                                    )
                                  : Image.asset(
                                      'assets/icons/Mask.png',
                                      color: const Color.fromRGBO(7, 0, 255, 1),
                                    ),
                            ),
                            hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 17),
                            hintText: "Пароль",
                            focusColor: Colors.black,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color.fromRGBO(7, 0, 255, 1), width: 1))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 104 * scaleHeight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24 * scaleWidth, vertical: 24 * scaleHeight),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(7, 0, 255, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24 * scaleWidth),
                          ),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          _authenticateWithEmailAndPassword(context);
                        },
                        child: SizedBox(
                          height: 24 * scaleHeight,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              "Войти",
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context)
          .signIn(email: _emailController.value.text, password: _passwordController.value.text);
    }
  }
}
