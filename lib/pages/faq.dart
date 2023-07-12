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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FAQ')),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              title: Text(questions[index]),
                              tileColor: Colors.white,
                              onTap: () {}));
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}