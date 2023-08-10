// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/pages/diary/diary.dart';
import 'package:intl/intl.dart';

import 'package:i_am_app/classes/models/plan.dart' as pl;
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';

class CustomCategory {
  TextEditingController controller;
  String? catigory;
  CustomCategory({
    required this.controller,
    this.catigory,
  });
}

List<TextEditingController> controllers = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController()
];

List<CustomCategory> customControllersIncome = [
  CustomCategory(controller: TextEditingController()),
];
List<CustomCategory> customControllersFixed = [
  CustomCategory(controller: TextEditingController()),
];
List<CustomCategory> customControllersVar = [
  CustomCategory(controller: TextEditingController()),
];

bool switchValue = false;

List<String> cEarning = [
  'Зарплата',
  'Бизнес',
  'От аренды имущества',
  'Алименты',
  'Помощь',
  'Продажа имущества',
  'Пассивный доход',
  'Прочее'
];

List<String> cSpendingConst = [
  'Продукты',
  'Жильё',
  'Транспорт',
  'Товары для дома',
  'Школа, садик',
  'Длительное обучение',
  'Кредит',
  'Ипотека',
  'Автокредит',
  'Прочее',
];

List<String> cSpendingTemp = [
  'Путешествие',
  'Хобби',
  'Одежда',
  'Недвижимость',
  'Транспорт',
  'Лечение',
  'Инвестиции',
  'Сбережения',
  'Благотворительность',
  'Прочее',
];
DateTime date = DateTime.now();

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
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
              customControllersIncome.clear();
              customControllersFixed.clear();
              customControllersVar.clear();
              for (var i in controllers) {
                i.clear();
              }
              customControllersIncome = [
                CustomCategory(controller: TextEditingController()),
              ];
              customControllersFixed = [
                CustomCategory(controller: TextEditingController()),
              ];
              customControllersVar = [
                CustomCategory(controller: TextEditingController()),
              ];
              if (switchValue) {
                for (var element in state.user.month) {
                  if (element.date.month == DateTime.now().month &&
                      element.date.year == DateTime.now().year) {
                    controllers[3].text = element.drr ?? '0';
                    controllers[4].text = element.passiveIncome ?? '0';
                    controllers[5].text = element.passiveIncome ?? '0';
                    customControllersIncome.clear();
                    customControllersFixed.clear();
                    customControllersVar.clear();
                    for (var i in element.incomeList) {
                      customControllersIncome.add(
                          CustomCategory(controller: TextEditingController()));
                      customControllersIncome[
                              customControllersIncome.length - 1]
                          .controller
                          .text = i.value;
                      customControllersIncome[
                              customControllersIncome.length - 1]
                          .catigory = i.category;
                    }
                    for (var i in element.fixedCostsList) {
                      customControllersFixed.add(
                          CustomCategory(controller: TextEditingController()));
                      customControllersFixed[customControllersFixed.length - 1]
                          .controller
                          .text = i.value;
                      customControllersFixed[customControllersFixed.length - 1]
                          .catigory = i.category;
                    }
                    for (var i in element.varCostsList) {
                      customControllersVar.add(
                          CustomCategory(controller: TextEditingController()));
                      customControllersVar[customControllersVar.length - 1]
                          .controller
                          .text = i.value;
                      customControllersVar[customControllersVar.length - 1]
                          .catigory = i.category;
                    }
                    if (customControllersIncome.isEmpty) {
                      customControllersIncome.add(
                          CustomCategory(controller: TextEditingController()));
                    }
                    if (customControllersFixed.isEmpty) {
                      customControllersFixed.add(
                          CustomCategory(controller: TextEditingController()));
                    }
                    if (customControllersVar.isEmpty) {
                      customControllersVar.add(
                          CustomCategory(controller: TextEditingController()));
                    }
                  }
                }
              } else {
                for (var element in state.user.years) {
                  controllers[3].text = element.drr ?? '0';
                  controllers[4].text = element.passiveIncome ?? '0';
                  controllers[5].text = element.passiveIncome ?? '0';
                  if (element.date.year == DateTime.now().year) {
                    customControllersIncome.clear();
                    customControllersFixed.clear();
                    customControllersVar.clear();
                    for (var i in element.incomeList) {
                      customControllersIncome.add(
                          CustomCategory(controller: TextEditingController()));
                      customControllersIncome[
                              customControllersIncome.length - 1]
                          .controller
                          .text = i.value;
                      customControllersIncome[
                              customControllersIncome.length - 1]
                          .catigory = i.category;
                    }
                    for (var i in element.fixedCostsList) {
                      customControllersFixed.add(
                          CustomCategory(controller: TextEditingController()));
                      customControllersFixed[customControllersFixed.length - 1]
                          .controller
                          .text = i.value;
                      customControllersFixed[customControllersFixed.length - 1]
                          .catigory = i.category;
                    }
                    for (var i in element.varCostsList) {
                      customControllersVar.add(
                          CustomCategory(controller: TextEditingController()));
                      customControllersVar[customControllersVar.length - 1]
                          .controller
                          .text = i.value;
                      customControllersVar[customControllersVar.length - 1]
                          .catigory = i.category;
                    }
                    if (customControllersIncome.isEmpty) {
                      customControllersIncome.add(
                          CustomCategory(controller: TextEditingController()));
                    }
                    if (customControllersFixed.isEmpty) {
                      customControllersFixed.add(
                          CustomCategory(controller: TextEditingController()));
                    }
                    if (customControllersVar.isEmpty) {
                      customControllersVar.add(
                          CustomCategory(controller: TextEditingController()));
                    }
                  }
                }
              }
              return Column(
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
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "День месяц",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              content: Container(
                                // Need to use container to add size constraint.
                                width: 300,
                                height: 300,
                                child: ListView.builder(
                                    itemCount: months.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        tileColor: Colors.white,
                                        onTap: () {
                                          date = DateTime(
                                              DateTime.now().year, index + 1);
                                          Navigator.of(context).pop();
                                        },
                                        title: Center(
                                          child: Text(
                                            months[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            );
                          },
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
                                  lastDate: DateTime(DateTime.now().year + 30),
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
                  NodeContainer(
                    controllers: customControllersIncome,
                    title: "Доход",
                    showCatigory: true,
                  ),
                  NodeContainer(
                    controllers: customControllersFixed,
                    title: "Постоянные расходы",
                    showCatigory: true,
                  ),
                  NodeContainer(
                    controllers: customControllersVar,
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
                      int income = 0;
                      int fixed = 0;
                      int variable = 0;
                      for (var i in customControllersIncome) {
                        income +=
                            int.parse(i.controller.text.replaceAll(' ', ''));
                      }
                      for (var i in customControllersFixed) {
                        fixed +=
                            int.parse(i.controller.text.replaceAll(' ', ''));
                      }
                      for (var i in customControllersVar) {
                        variable +=
                            int.parse(i.controller.text.replaceAll(' ', ''));
                      }
                      pl.Plan plan = pl.Plan(
                        date: date,
                        income: income.toString(),
                        fixedCosts: fixed.toString(),
                        varCosts: variable.toString(),
                        drr: controllers[3].text,
                        progressiveTotal: controllers[4].text,
                        passiveIncome: controllers[5].text,
                        incomeList: List<pl.Node>.generate(
                            customControllersIncome.length,
                            (index) => pl.Node(
                                category:
                                    customControllersIncome[index].catigory,
                                value: customControllersIncome[index]
                                    .controller
                                    .text)),
                        fixedCostsList: List<pl.Node>.generate(
                            customControllersFixed.length,
                            (index) => pl.Node(
                                category:
                                    customControllersFixed[index].catigory,
                                value: customControllersFixed[index]
                                    .controller
                                    .text)),
                        varCostsList: List<pl.Node>.generate(
                            customControllersVar.length,
                            (index) => pl.Node(
                                category: customControllersVar[index].catigory,
                                value: customControllersVar[index]
                                    .controller
                                    .text)),
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
              );
            },
          ),
        ),
      ),
    );
  }
}

class NodeContainer extends StatelessWidget {
  final String title;
  final bool showCatigory;
  final bool? showInfo;

  final List<CustomCategory> controllers;

  const NodeContainer(
      {super.key,
      required this.title,
      required this.showCatigory,
      this.showInfo,
      required this.controllers});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Divider(
            color: Colors.white,
            thickness: 1.5,
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controllers.length,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Категория",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextForm(
                      setState: setState,
                      controller: controllers[index].controller,
                    ),
                  ],
                );
              }),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                controllers
                    .add(CustomCategory(controller: TextEditingController()));
                setState(() {});
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
        ],
      );
    });
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
    return StatefulBuilder(builder: (context, setState) {
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
                    ? GestureDetector(
                        child: Text(
                          "Категория",
                          style: TextStyle(color: Colors.white),
                        ),
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
            TextForm(
              controller: controller,
              setState: setState,
            ),
          ],
        ),
      );
    });
  }
}

class TextForm extends StatelessWidget {
  final TextEditingController controller;
  Function setState;

  TextForm({super.key, required this.controller, required this.setState});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.0),
        onChanged: (value) {
          controllers[4].text = '0';
          if (controller.text.length == 0) {
            return;
          }
          controllers[3].text = '0';

          for (var i in customControllersIncome) {
            if (i.controller.text != '') {
              controllers[3].text =
                  (int.parse(i.controller.text.replaceAll(' ', '')) +
                          int.parse(controllers[3].text.replaceAll(' ', '')))
                      .toString();
            }
          }
          for (var i in customControllersFixed) {
            if (i.controller.text != '') {
              controllers[3].text =
                  (int.parse(i.controller.text.replaceAll(' ', '')) +
                          int.parse(controllers[3].text.replaceAll(' ', '')))
                      .toString();
            }
          }
          for (var i in customControllersVar) {
            if (i.controller.text != '') {
              controllers[3].text =
                  (int.parse(i.controller.text.replaceAll(' ', '')) +
                          int.parse(controllers[3].text.replaceAll(' ', '')))
                      .toString();
            }
          }
          final data = context.read<UserBloc>().state.user;
          if (switchValue) {
            for (var i in data.month) {
              if (i.date.month < date.month) {
                controllers[4].text =
                    (int.parse(controllers[4].text.replaceAll(' ', '')) +
                            int.parse(i.drr!.replaceAll(' ', '')))
                        .toString();
              }
            }
          } else {
            for (var i in data.years) {
              if (i.date.year < date.year) {
                controllers[4].text =
                    (int.parse(controllers[4].text.replaceAll(' ', '')) +
                            int.parse(i.drr!.replaceAll(' ', '')))
                        .toString();
              }
            }
          }
          controllers[4].text =
              (int.parse(controllers[4].text.replaceAll(' ', '')) +
                      int.parse(controllers[3].text.replaceAll(' ', '')))
                  .toString();
          print(controllers[4].text);
          setState(() {});
          var formatter = NumberFormat('#,###');
          controller.text =
              '${formatter.format(int.tryParse(controller.text.replaceAll(' ', '')))}'
                  .replaceAll(',', ' ');
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length));
        },
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
