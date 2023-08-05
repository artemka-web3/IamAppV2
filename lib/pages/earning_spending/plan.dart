import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:intl/intl.dart';
import 'package:i_am_app/classes/models/plan.dart' as pl;

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  DateTime date = DateTime.now();

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  List<String> months = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь'
  ];

  List<String> data = [];

  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
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
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return SizedBox(
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
                    GestureDetector(
                      onTap: () async {
                        if (switchValue) {
                          date = await showDatePicker(
                                context: context,
                                initialDate: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                ),
                                firstDate: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                ),
                                lastDate: DateTime(
                                  DateTime.now().year + 30,
                                  DateTime.now().month,
                                ),
                              ) ??
                              DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                              );
                          date = DateTime(date.year, date.month);
                        } else {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Выберите год",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                content: Container(
                                  // Need to use container to add size constraint.
                                  width: 300,
                                  height: 300,
                                  child: YearPicker(
                                    firstDate: DateTime(DateTime.now().year),
                                    lastDate:
                                        DateTime(DateTime.now().year + 30),
                                    initialDate: DateTime.now(),
                                    selectedDate: date,
                                    onChanged: (DateTime dateTime) {
                                      date = dateTime;
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        setState(() {});
                      },
                      child: Row(
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
                            title: (switchValue)
                                ? (date.month == 1)
                                    ? months[11]
                                    : months[date.month - 2]
                                : (date.year - 1).toString(),
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          CustomContainer(
                            title: (switchValue)
                                ? months[date.month - 1]
                                : (date.year).toString(),
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          CustomContainer(
                            title: (switchValue)
                                ? (date.month == 12)
                                    ? months[0]
                                    : months[date.month]
                                : (date.year + 1).toString(),
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
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    ContainerTextForm(
                      controller: controllers[0],
                      title: "Доход",
                      showCatigory: true,
                    ),
                    ContainerTextForm(
                      controller: controllers[1],
                      title: "Постоянные расходы",
                      showCatigory: true,
                    ),
                    ContainerTextForm(
                      controller: controllers[2],
                      title: "Переменные расходы",
                      showCatigory: true,
                    ),
                    ContainerTextForm(
                      controller: controllers[3],
                      title: "Д-Р-Р",
                      showCatigory: false,
                      showInfo: true,
                    ),
                    ContainerTextForm(
                      controller: controllers[4],
                      title: "Нарастающим итогом",
                      showCatigory: false,
                    ),
                    ContainerTextForm(
                      controller: controllers[5],
                      title: "Пассивный доход",
                      showCatigory: false,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        pl.Plan plan = pl.Plan(
                          date: date,
                          income: controllers[0].text,
                          fixedCosts: controllers[1].text,
                          varCosts: controllers[2].text,
                          drr: controllers[3].text,
                          progressiveTotal: controllers[4].text,
                          passiveIncome: controllers[5].text,
                        );
                        context.read<UserBloc>().add(
                              AddPlan(
                                  phone: state.user.phone,
                                  plan: plan,
                                  isYears: !switchValue),
                            );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color.fromARGB(255, 111, 207, 151),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Center(
                              child: Text(
                                "Сохранить",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            (state is UserLoading)
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
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

  final TextEditingController controller;

  const ContainerTextForm(
      {super.key,
      required this.title,
      required this.showCatigory,
      this.showInfo,
      required this.controller});

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
                      ),
                    )
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
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.0),
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
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
