import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/pages/auth/birth_meaning.dart';
import 'package:i_am_app/pages/auth/logic/bloc/auth_bloc_bloc.dart';
import 'package:i_am_app/pages/auth/sign_in.dart';

class OtpPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthInitial>(
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (state is PhoneAuthVerified) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const BirthMeaning(),
              ),
            );
          }
          if (state is PhoneAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  color: Colors.black,
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
                    "Введите код из смс:",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Код",
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
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: "****",
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
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (state is PhoneAuthCodeSentSuccess) {
                        context.read<AuthBloc>().add(VerifySentOtpEvent(
                            verificationId: state.verificationId,
                            otp: controller.text.trim()));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 111, 207, 151),
                      ),
                      child: const Center(
                        child: Text(
                          "Зарегистрироваться!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Уже есть аккаунт?",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Войти",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
