import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/pages/auth/logic/bloc/auth_bloc.dart';

import 'auth/logic/log_in.dart';

class LinkPage extends StatelessWidget {
  String email;
  LinkPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthInitial>(
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (state is PhoneAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  color: const Color.fromARGB(255, 37, 46, 41),
                  child: Center(
                    child: Text(
                      "Ошибка",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            );
          }
          if (state is PhoneAuthVerified) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LogIn(),
              ),
            );
          }
        });
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Проверьте почту",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(VerifySentOtpEvent(email));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 111, 207, 151),
                      ),
                      child: const Center(
                        child: Text(
                          "Я уже авторизовался по",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
