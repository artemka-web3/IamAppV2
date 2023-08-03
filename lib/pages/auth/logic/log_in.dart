import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_am_app/main.dart';
import 'package:i_am_app/pages/auth/birth_meaning.dart';
import 'package:i_am_app/pages/earning_spending/plan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key, this.change});

  bool? change;

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? pinChanging;
  TextEditingController pinController = TextEditingController();
  Widget? NextPage;
  int attemts = 5;
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
          String? pin = snapshot.data!.getString('pin');
          if (pin == null) {
            NextPage = BirthMeaning();
          } else {
            NextPage = MyApp(pageIndex: 0);
          }
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  const Spacer(),
                  const Text(
                    "Добрый день!",
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  (widget.change == true)
                      ? Text(
                          "${(pin == null) ? 'Установите' : 'Введите'} Код-пароль",
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      : Text(
                          "Повторите Код-пароль",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: pinController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      onChanged: (value) {
                        if (attemts <= 0) {
                          return;
                        }
                        if (pin != null) {
                          if (pinController.text.length == 4) {
                            if (pin == pinController.text) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyApp(
                                      pageIndex: 0,
                                    ),
                                  ),
                                  (route) => false);
                            } else {
                              setState(() {
                                attemts--;
                              });
                            }
                          }
                        }
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "****",
                        hintStyle: TextStyle(fontSize: 16.0),
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  (pin != null)
                      ? Center(
                          child: Text(
                            "Осталось попыток: $attemts",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      : SizedBox(),
                  (pin == null || widget.change != null)
                      ? GestureDetector(
                          onTap: () async {
                            if (widget.change == true) {
                              if (pinController.text == pinChanging) {
                                snapshot.data!
                                    .setString('pin', pinController.text);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Container(
                                      color: Colors.grey,
                                      child: Center(
                                        child: Text(
                                          "Неверный повтор пароля",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                            }
                            if (widget.change == false) {
                              pinChanging = pinController.text;
                              widget.change = true;
                              pinController.clear();
                              setState(() {});
                            }
                            if (pinController.text.length == 4) {
                              snapshot.data!
                                  .setString('pin', pinController.text);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BirthMeaning(),
                                  ),
                                  (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Container(
                                    color:
                                        const Color.fromARGB(255, 37, 46, 41),
                                    child: Center(
                                      child: Text(
                                        "Ошибка! Код-пароль должен состоять из 4 цифр",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: const Color.fromARGB(255, 111, 207, 151),
                            ),
                            child: const Center(
                              child: Text(
                                "Сохранить Код-пароль",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
