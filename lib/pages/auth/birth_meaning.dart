import 'package:flutter/material.dart';
import 'package:i_am_app/classes/services/firebase_realtime_service.dart';
import 'package:i_am_app/main.dart';
import 'package:i_am_app/pages/auth/gua.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BirthMeaning extends StatefulWidget {
  const BirthMeaning({super.key});

  @override
  State<BirthMeaning> createState() => _BirthMeaningState();
}

class _BirthMeaningState extends State<BirthMeaning> {
  int prevLength = 0;

  String buttonText = 'Введите дату рождения';

  bool isWomen = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String gua = '0';

    int roadSum = 0;

    String birth = '0';

    if (controller.text.length >= 2) {
      birth = controller.text[0] + controller.text[1];
    }

    for (var i = 0; i < controller.text.length; i++) {
      if (double.tryParse(controller.text[i]) == null) {
        continue;
      }
      roadSum += int.parse(controller.text[i]);
      while (roadSum >= 10) {
        String guaStr = roadSum.toString();
        roadSum = 0;
        for (var i = 0; i < guaStr.length; i++) {
          roadSum += int.parse(guaStr[i]);
        }
      }
    }

    if (controller.text.length == 10) {
      gua = (int.parse(controller.text[controller.text.length - 2]) +
              int.parse(controller.text[controller.text.length - 1]))
          .toString();
      if (gua.length > 1) {
        gua = (int.parse(gua[0]) + int.parse(gua[1])).toString();
      }
      if (isWomen) {
        gua = (int.parse(gua) + 5).toString();
      } else {
        gua = (10 - int.parse(gua)).toString();
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Text(
                    "Значение твоего дня рождения",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Мужчина",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      value: isWomen,
                      trackColor: MaterialStatePropertyAll(Colors.black),
                      thumbColor: MaterialStatePropertyAll(Colors.white),
                      onChanged: (val) => setState(
                        () {
                          isWomen = !isWomen;
                        },
                      ),
                    ),
                    Text(
                      "Женщина",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: Text(
                    "Введи дату рождения",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "01/01/1999",
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    onChanged: (_) {
                      buttonText = 'Сохранить';
                      if (controller.text.length == 2 && prevLength == 1) {
                        controller.text += '/';
                      }
                      if (controller.text.length == 5 && prevLength == 4) {
                        controller.text += '/';
                      }
                      if (controller.text.length == 10) {
                        setState(() {});
                      }
                      controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: controller.text.length));
                      prevLength = controller.text.length;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: Text(
                    "Результаты",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ContentTitle(title: "Твоё число ГУА", number: gua),
                const SizedBox(
                  height: 8.0,
                ),
                const ContentContainer(
                    text:
                        "Об энергетике личности Гуа 9 свидетельствует триграмма числа: одна прерывистая линия, окруженная с обеих сторон двумя сплошными..."),
                const SizedBox(
                  height: 8.0,
                ),
                ContentTitle(
                    title: "Число жизненного пути", number: roadSum.toString()),
                const SizedBox(
                  height: 8.0,
                ),
                const ContentContainer(
                  text:
                      "Вы – активны, предприимчивы и очень энергичны. Спонтанное влечение творить и неординарный подход к делу делают из вас человека-первооткрывателя...",
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ContentTitle(
                  title: "Число даты рождения",
                  number: birth,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const ContentContainer(
                  text:
                      "3 – ещё с раннего возраста вы обладаете удивительной способностью схватывать все на лету...",
                ),
                const SizedBox(
                  height: 8.0,
                ),
                GestureDetector(
                  onTap: () async {
                    if (buttonText == 'Введите дату рождения') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "Введите дату рождения",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      );
                      return;
                    }
                    if (buttonText == 'Сохранить') {
                      buttonText = 'Далее';
                      setState(() {});
                      return;
                    }
                    controller.text.trim();
                    if (controller.text.length == 10) {
                      FirebaseDatabaseService service =
                          FirebaseDatabaseService();
                      final pref = await SharedPreferences.getInstance();
                      final phone = pref.getString('phone');
                      String year = '', month = '', day = '';
                      for (var i = 0; i < controller.text.length; i++) {
                        if (i < 2) {
                          day += controller.text[i];
                        }
                        if (i < 5 && i > 2) {
                          month += controller.text[i];
                        }
                        if (i > 5 && i < 10) {
                          year += controller.text[i];
                        }
                      }
                      DateTime date = DateTime(
                        int.parse(year),
                        int.parse(month),
                        int.parse(day),
                      );
                      await service.updateUser(
                        phone!,
                        {
                          'birth': date.millisecondsSinceEpoch,
                          'isWoman': isWomen,
                        },
                      );

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(pageIndex: 0),
                          ),
                          (route) => false);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        111,
                        207,
                        151,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContentTitle extends StatelessWidget {
  final String title;
  final String number;

  const ContentTitle({super.key, required this.title, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        color: Color.fromARGB(255, 37, 46, 41),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Container(
            width: 48,
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentContainer extends StatelessWidget {
  final String text;

  const ContentContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Читать полностью",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                width: 8.0,
              ),
              IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const Gua())),
                icon: const Icon(
                  Icons.arrow_circle_right_rounded,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
