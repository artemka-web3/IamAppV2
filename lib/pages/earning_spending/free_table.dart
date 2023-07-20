import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FreeTable extends StatefulWidget {
  const FreeTable({super.key});

  @override
  State<FreeTable> createState() => _FreeTableState();
}

class _FreeTableState extends State<FreeTable> {
  final List<String> years = const ["2021", "2022", "2023"];
  final List<String> month = const ["Март", "Апрель", "Май"];

  List<String> data = [];

  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    if (switchValue) {
      data = month;
    } else {
      data = years;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title:
              const Align(alignment: Alignment.center, child: Text('Таблица')),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.download),
            )
          ]),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: Expanded(
          child: Column(
            children: [
              const Spacer(
                flex: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Год",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 80,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          thumbColor:
                              const MaterialStatePropertyAll(Colors.white),
                          trackColor: const MaterialStatePropertyAll(
                              Color.fromARGB(255, 111, 207, 151)),
                          value: switchValue,
                          onChanged: (value) {
                            setState(() {
                              switchValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const Text(
                      "Месяц",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(
                    flex: 4,
                  ),
                  Text(
                    data[0],
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    data[1],
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    data[2],
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              const CustomColumn(
                title: "Доходы",
                values: ['75 000', '58 000', '58 000'],
                textColor: Colors.black,
                backgroundColor: Colors.white,
              ),
              const Spacer(),
              const Divider(
                thickness: 1.0,
                color: Colors.white,
              ),
              const Spacer(),
              const CustomColumn(
                title: "Постоянные \nрасходы",
                values: ['75 000', '58 000', '58 000'],
                textColor: Colors.black,
                backgroundColor: Colors.white,
              ),
              const Spacer(),
              const Divider(
                thickness: 1.0,
                color: Colors.white,
              ),
              const Spacer(),
              const CustomColumn(
                title: "Переменные \nрасходы",
                values: ['75 000', '58 000', '58 000'],
                textColor: Colors.black,
                backgroundColor: Colors.white,
              ),
              const Spacer(),
              const Divider(
                thickness: 1.0,
                color: Colors.white,
              ),
              const Spacer(
                flex: 5,
              ),
              const CustomColumn(
                title: "Д-Р-Р",
                values: ['75 000', '58 000', '58 000'],
                textColor: Colors.black,
                gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 214, 255, 231),
                    Color.fromARGB(220, 214, 255, 231),
                    Color.fromARGB(255, 35, 85, 56),
                  ],
                ),
              ),
              const Spacer(),
              const Divider(
                thickness: 1.0,
                color: Colors.white,
              ),
              const Spacer(),
              const CustomColumn(
                title: "Нарастающим \nитогом",
                values: ['75 000', '58 000', '58 000'],
                textColor: Colors.black,
                backgroundColor: Colors.white,
                gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 214, 255, 231),
                    Color.fromARGB(220, 214, 255, 231),
                    Color.fromARGB(255, 35, 85, 56),
                  ],
                ),
              ),
              const Spacer(),
              const Divider(
                thickness: 1.0,
                color: Colors.white,
              ),
              const Spacer(),
              const CustomColumn(
                title: "Пассивный \nдоход",
                values: ['-10 000', '-5 000', '-5 000'],
                textColor: Colors.black,
                backgroundColor: Color.fromARGB(255, 111, 207, 151),
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomColumn extends StatelessWidget {
  final String title;
  final List<String> values;
  final Color? backgroundColor;
  final Color? textColor;
  final Gradient? gradient;

  const CustomColumn({
    super.key,
    required this.title,
    required this.values,
    this.backgroundColor,
    this.textColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MoneyContainer(
                  color: backgroundColor,
                  gradient: gradient,
                  text: Text(
                    values[0],
                  ),
                ),
                MoneyContainer(
                  color: backgroundColor,
                  gradient: gradient,
                  text: Text(
                    values[1],
                  ),
                ),
                MoneyContainer(
                  color: backgroundColor,
                  gradient: gradient,
                  text: Text(
                    values[2],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MoneyContainer extends StatelessWidget {
  final Color? color;
  final Gradient? gradient;
  final Text? text;

  const MoneyContainer({super.key, this.color, this.gradient, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Center(child: FittedBox(child: text)),
    );
  }
}
