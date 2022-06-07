import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora/constants.dart';
import 'package:agora/services/helper.dart';
import 'package:agora/ui/auth/login/login_screen.dart';
import 'package:agora/ui/auth/signUp/sign_up_screen.dart';
import 'package:agora/ui/auth/welcome/welcome_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WelcomeBloc>(
      create: (context) => WelcomeBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<WelcomeBloc, WelcomeInitial>(
              listener: (context, state) {
                switch (state.pressTarget) {
                  case WelcomePressTarget.login:
                    push(context, const LoginScreen());
                    break;
                  case WelcomePressTarget.signup:
                    push(context, const SignUpScreen());
                    break;
                  default:
                    break;
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      "assets/images/logo4.png",
                      width: 350.0,
                      height: 350.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 16, top: 32, right: 16, bottom: 8),
                    child: Text(
                      'Agoraya Merhaba Deyin!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(COLOR_PRIMARY),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    child: Text(
                      'bu uygulama, sizin yalnız olmadığınızı bilmeniz için var.',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(COLOR_PRIMARY),
                        textStyle: const TextStyle(color: Colors.white),
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side:
                                const BorderSide(color: Color(COLOR_PRIMARY))),
                      ),
                      child: const Text(
                        'Giriş',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        context.read<WelcomeBloc>().add(LoginPressed());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 40.0, left: 40.0, top: 20, bottom: 20),
                    child: TextButton(
                      child: const Text(
                        'Kayıt',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(COLOR_PRIMARY)),
                      ),
                      onPressed: () {
                        context.read<WelcomeBloc>().add(SignupPressed());
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.only(top: 12, bottom: 12),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: const BorderSide(
                              color: Color(COLOR_PRIMARY),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

              Padding(
          padding: const EdgeInsets.only(
          right: 40.0, left: 40.0, top: 20, bottom: 20),
          child: TextButton(
          child: const Text(
          'Bağış',
          style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(COLOR_PRIMARY)),
          ),
          onPressed: () {
          context.read<WelcomeBloc>().add(SignupPressed());
          },
          style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.only(top: 12, bottom: 12),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: const BorderSide(
          color: Color(COLOR_PRIMARY),
          ),
          ),
          ),
          ),
          ),
              ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
