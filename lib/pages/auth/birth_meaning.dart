import 'package:flutter/material.dart';

class BirthMeaning extends StatelessWidget {
  const BirthMeaning({super.key});

  @override
  Widget build(BuildContext context) {
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
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "01/01/1999",
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
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
                const ContentTitle(title: "Твоё число ГУА", number: "9"),
                const SizedBox(
                  height: 8.0,
                ),
                const ContentContainer(
                    text:
                        "Об энергетике личности Гуа 9 свидетельствует триграмма числа: одна прерывистая линия, окруженная с обеих сторон двумя сплошными..."),
                const SizedBox(
                  height: 8.0,
                ),
                const ContentTitle(title: "Число жизненного пути", number: "1"),
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
                const ContentTitle(
                  title: "Число даты рождения",
                  number: "3",
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
                    child: const Center(
                      child: Text(
                        "Далее",
                        style: TextStyle(
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
                onPressed: () {},
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
