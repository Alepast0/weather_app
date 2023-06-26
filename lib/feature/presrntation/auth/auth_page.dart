import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/feature/domain/repositories/auth_rep.dart';
import 'package:weather/feature/domain/repositories/weather_rep.dart';
import 'package:weather/feature/presrntation/auth/auth_cubit.dart';
import 'package:weather/core/extension.dart';
import 'package:weather/feature/presrntation/weather/weather_cubit.dart';
import 'package:weather/feature/presrntation/weather/weather_page.dart';

class AuthScreen extends StatelessWidget {
  final dynamic lat;
  final dynamic lon;
  const AuthScreen({Key? key, required this.lat, required this.lon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider(
              create: (_) => WeatherCubit(RepositoryProvider.of<CurrentWeatherRep>(context)),
              child: WeatherPage(lon: lon, lat: lat,),
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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state){
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 5.83.wp, top: 1.24.hp, right: 5.83.wp, bottom: 1.8.hp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.92.hp,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: 1.24.hp,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 8.3.hp,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Вход",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              SizedBox(
                                height: 1.45.hp,
                              ),
                              const Text(
                                "Введите данные для входа",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.79.hp,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 0.9.hp, right: 5.83.wp, bottom: 2.7.hp, left: 5.83.wp),
                      child: Padding(
                        padding: EdgeInsets.only(top: 3.03.hp),
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
                              hintStyle: const TextStyle(fontSize: 17),
                              focusColor: Colors.black,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(7, 0, 255, 1), width: 0.49.wp))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.79.hp,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 0.9.hp, right: 5.83.wp, bottom: 2.7.hp, left: 5.83.wp),
                      child: Padding(
                        padding: EdgeInsets.only(top: 3.03.hp),
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
                              hintStyle: const TextStyle(fontSize: 17),
                              hintText: "Пароль",
                              focusColor: Colors.black,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(7, 0, 255, 1), width: 0.49.wp))),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 11.69.hp,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.83.wp)),
                      child: Padding(
                        padding: EdgeInsets.all(5.83.wp),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(7, 0, 255, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.83.wp),
                            ),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _authenticateWithEmailAndPassword(context);
                          },
                          child: const Text(
                            "Войти",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context)
          .signIn(email: _emailController.value.text, password: _passwordController.value.text);
    }
  }
}
