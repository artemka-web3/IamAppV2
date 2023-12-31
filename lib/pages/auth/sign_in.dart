import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/page_index.dart';
import 'package:i_am_app/main.dart';
import 'package:i_am_app/pages/auth/logic/bloc/auth_bloc.dart';
import 'package:i_am_app/pages/auth/logic/log_in.dart';
import 'package:i_am_app/pages/auth/password_recovery.dart';
import 'package:i_am_app/pages/auth/otp.dart';
import 'package:i_am_app/pages/earning_spending/plan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String number = '-1';

  SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false || snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
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

                if (state is PhoneAuthVerified &&
                    snapshot.data!.getString('phone') != null) {
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
                            "Почта",
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
                          child: Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  decoration: const InputDecoration(
                                    hintText: "email",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(50, 37, 46, 41),
                                    ),
                                    contentPadding: EdgeInsets.all(16.0),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Пароль",
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
                          child: Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: TextFormField(
                                  controller: passwordController,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  decoration: const InputDecoration(
                                    hintText: "**********",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(50, 37, 46, 41),
                                    ),
                                    contentPadding: EdgeInsets.all(16.0),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(
                                  SendOtpToPhoneEvent(
                                      emailController.text.trim(),
                                      passwordController.text.trim()),
                                );
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
                          flex: 3,
                        ),
                        (state is AuthLoading)
                            ? const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 111, 207, 151),
                                ),
                              )
                            : const SizedBox(),
                        const Spacer(
                          flex: 4,
                        ),
                        //Кнопку удалить
                        TextButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => LogIn())),
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
        });
  }
}
