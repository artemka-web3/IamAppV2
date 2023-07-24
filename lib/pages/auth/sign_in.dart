import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/pages/auth/logic/bloc/auth_bloc_bloc.dart';
import 'package:i_am_app/pages/auth/logic/log_in.dart';
import 'package:i_am_app/pages/auth/password_recovery.dart';
import 'package:i_am_app/pages/auth/otp.dart';

class SignIn extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();

  SignIn({super.key});

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

          if (state is PhoneAuthCodeSentSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OtpPage(),
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
                  SizedBox(
                    height: AppBar().preferredSize.height,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  const Text(
                    "Добрый день!",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  const Text(
                    "Войти:",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Телефон",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: "+7(***)-***-**-**",
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(50, 37, 46, 41),
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      final number = phoneController.text;
                      context
                          .read<AuthBloc>()
                          .add(SendOtpToPhoneEvent(number: number));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 111, 207, 151),
                      ),
                      child: const Center(
                        child: Text(
                          "Войти",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 7,
                  ),
                  //Кнопку удалить
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const LogIn())),
                    child: Text(
                      "Войти с пин-кодом",
                      style: Theme.of(context).textTheme.titleMedium,
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
