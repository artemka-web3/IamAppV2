import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPassword extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  SetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false || snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            return SafeArea(
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/background.png"),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Задать код-пароль:',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.bodyMedium,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4),
                              ],
                              onSubmitted: (value) {
                                if (controller.text.trim().length != 4) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Container(
                                        color: Colors.grey,
                                        child: Center(
                                          child: Text(
                                            "Код-пароль должен быть длины 4",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => RepeatPassword(
                                              newPin: controller.text.trim(),
                                            )));
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                          ),
                        ]),
                  )),
            );
          }),
    );
  }
}

class RepeatPassword extends StatelessWidget {
  String newPin;

  TextEditingController controller = TextEditingController();

  RepeatPassword({Key? key, required this.newPin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false || snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            return SafeArea(
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/background.png"),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Повтори код-пароль:',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.bodyMedium,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4),
                              ],
                              controller: controller,
                              onSubmitted: (value) {
                                if (controller.text.trim().length != 4) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Container(
                                        color: Colors.grey,
                                        child: Center(
                                          child: Text(
                                            "Код-пароль должен быть длины 4",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                bool success = false;
                                if (value.trim() == newPin) {
                                  snapshot.data!.setString('pin', value.trim());
                                  success = true;
                                }
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => SuccessPassword(
                                              success: success,
                                            )));
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                          ),
                        ]),
                  )),
            );
          }),
    );
  }
}

class SuccessPassword extends StatelessWidget {
  bool success = false;

  SuccessPassword({Key? key, required this.success}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pop();
    });
    return Scaffold(
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Text(
                (success) ? 'Код задан!' : 'Код не задан! Неправильный повтор',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                )),
              ),
            )),
      ),
    );
  }
}
