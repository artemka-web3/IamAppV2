import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover),
          ),
          child: SizedBox(
            child: Column(
              children: [
                AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  actions: const [
                    SizedBox(
                      width: 36.0,
                    )
                  ],
                  title: const Center(
                    child: Text("Планирование"),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
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
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    CustomContainer(
                      title: data[0],
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    CustomContainer(
                      title: data[1],
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    CustomContainer(
                      title: data[2],
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const ContainerTextForm(
                  title: "Доход",
                  showCatigory: true,
                ),
                const ContainerTextForm(
                  title: "Постоянные расходы",
                  showCatigory: true,
                ),
                const ContainerTextForm(
                  title: "Переменные расходы",
                  showCatigory: true,
                ),
                const ContainerTextForm(
                  title: "Д-Р-Р",
                  showCatigory: false,
                  showInfo: true,
                ),
                const ContainerTextForm(
                  title: "Нарастающим итогом",
                  showCatigory: false,
                ),
                const ContainerTextForm(
                  title: "Пассивный доход",
                  showCatigory: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerTextForm extends StatelessWidget {
  final String title;
  final bool showCatigory;
  final bool? showInfo;

  final TextEditingController? controller;

  const ContainerTextForm(
      {super.key,
      required this.title,
      required this.showCatigory,
      this.showInfo,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 16.0,
              ),
              (showCatigory)
                  ? const Text(
                      "Категория",
                      style: TextStyle(color: Colors.white),
                    )
                  : const SizedBox(),
              (showInfo != null)
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.query_builder,
                        color: Colors.white,
                      ))
                  : const SizedBox(),
            ],
          ),
          const SizedBox(
            height: 24.0,
          ),
          TextForm(
            controller: controller,
          ),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  final TextEditingController? controller;

  const TextForm({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Введите сумму...",
          hintStyle: const TextStyle(
            color: Color.fromARGB(129, 37, 46, 41),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String title;

  const CustomContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Center(
        child: FittedBox(
          child: Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
