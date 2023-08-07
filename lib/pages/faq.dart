import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  FAQPage({Key? key}) : super(key: key);
  final questions = [
    'Что такое число ГУА?',
    'Что такое число жизненного пути?',
    'Что такое число дня рождения?',
    'Зачем считать индекс жизни каждый месяц?',
    'Что такое пассивный доход?',
  ];
  final answers = [
    'Число Гуа – ваше счастливое магическое число позволяет использовать магнитные силы Земли для достижения своих целей',
    'Число жизненного пути показывает предписанный Вам путь, на вашу истинную природу, уникальность вашей личности и кармический долг, который вам нужно преодолеть',
    'Ключ к коду судьбы, способному сыграть необычайно важную роль в построении ваших жизненных планов',
    'Задача человека - стремление становиться лучше, счастливее, богаче и т.д. Ежемесячный расчет Индекса жизни поможет Вам расставлять правильные приоритеты и смотреть за динамикой Вашего развития.',
    'Доход, не зависящий от ежедневной деятельности. Скажу проще, что пассивный доход - это Ваша финансовая независимость и свобода. Это то, к чему нужно стремиться.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Text(questions[index],
                              style: const TextStyle(color: Colors.black)),
                          tileColor: Colors.white,
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      questions[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    content: Container(
                                      height: 200,
                                      child: Center(
                                        child: Text(
                                          answers[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text(
                                          "Назад",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                        ),
                      );
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
