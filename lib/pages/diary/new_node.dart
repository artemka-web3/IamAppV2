import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/case.dart';
import 'package:i_am_app/classes/services/notification_service.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewNode extends StatelessWidget {
  List<TextEditingController> frog = [TextEditingController()];
  List<TextEditingController> birthday = [TextEditingController()];
  List<TextEditingController> calls = [TextEditingController()];
  List<TextEditingController> tasks = [TextEditingController()];
  List<TextEditingController> success = [TextEditingController()];

  List<bool> valuesAlarmTasks = [false];
  List<bool> valuesAlarmFrog = [false];
  List<bool> valuesAlarmCalls = [false];
  List<bool> valuesAlarmSuccess = [false];

  List<TimeOfDay?> timesTasks = [const TimeOfDay(hour: 12, minute: 00)];
  List<TimeOfDay?> timesFrog = [const TimeOfDay(hour: 12, minute: 00)];
  List<TimeOfDay?> timesCalls = [const TimeOfDay(hour: 12, minute: 00)];
  List<TimeOfDay?> timesSuccess = [const TimeOfDay(hour: 12, minute: 00)];

  NewNode({super.key});

  DateTime? date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    String locale = Platform.localeName;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Дела на день',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        actions: const [
          SizedBox(
            width: 40.0,
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: StatefulBuilder(builder: (context, setState) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24.0,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            date = await showDatePicker(
                              context: context,
                              locale: Locale('ru'),
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                            );
                            frog = [TextEditingController()];
                            birthday = [TextEditingController()];
                            calls = [TextEditingController()];
                            tasks = [TextEditingController()];
                            success = [TextEditingController()];
                            if (date == null) {
                              date = DateTime.now();
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  '${DateFormat.EEEE(locale).format(date ?? DateTime.now())[0].toUpperCase()}${DateFormat.EEEE(locale).format(date ?? DateTime.now()).substring(1)} ${date?.day ?? DateTime.now().day} / ${date?.month ?? DateTime.now().month}',
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Node(
                        icon: SvgPicture.asset(
                          "assets/images/frog.svg",
                        ),
                        title: 'Лягушка дня',
                      ),
                      CustomTime(
                        controllers: frog,
                        valuesAlarms: valuesAlarmFrog,
                        times: timesFrog,
                        setState: setState,
                      ),
                      const SizedBox(height: 8.0),
                      Node(
                        icon: SvgPicture.asset(
                          "assets/images/cake.svg",
                        ),
                        title: 'Дни рождения и праздники',
                      ),
                      const SizedBox(height: 8.0),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shrinkWrap: true,
                            itemCount: birthday.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (index == birthday.length - 1) {
                                      setState(() => birthday
                                          .add(TextEditingController()));
                                    }
                                  },
                                  controller: birthday[index],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(16.0),
                                      border: InputBorder.none,
                                      hintText: "Новая запись..."),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Node(
                        icon: const Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                        title: 'Встречи и звонки',
                      ),
                      CustomTime(
                        controllers: calls,
                        valuesAlarms: valuesAlarmCalls,
                        times: timesCalls,
                        setState: setState,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/task.svg",
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "Задачи",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                      CustomTime(
                        controllers: tasks,
                        valuesAlarms: valuesAlarmTasks,
                        times: timesTasks,
                        setState: setState,
                      ),
                      const Divider(
                        color: Colors.white,
                        height: 12.0,
                        thickness: 1.0,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Node(
                        icon: SvgPicture.asset(
                          "assets/images/award.svg",
                        ),
                        title: 'Успехи дня',
                      ),
                      CustomTime(
                        controllers: success,
                        valuesAlarms: valuesAlarmSuccess,
                        times: timesSuccess,
                        setState: setState,
                      ),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () async {
                          List<Task> frogCopy = [];
                          List<Task> birthdayCopy = [];
                          List<Task> callsCopy = [];
                          List<Task> tasksCopy = [];
                          List<Task> successCopy = [];

                          Case newCase;

                          for (var i = 0; i < frog.length; i++) {
                            if (frog[i].text != "") {
                              frogCopy.add(
                                Task(
                                    text: frog[i].text,
                                    time: (valuesAlarmFrog[i])
                                        ? timesFrog[i]
                                        : null),
                              );
                            }
                            if (frog[i].text == "" && frog.length > 1) {
                              frog.removeAt(i);
                            }
                          }

                          for (var i = 0; i < birthday.length; i++) {
                            if (birthday[i].text != "") {
                              birthdayCopy.add(Task(text: birthday[i].text));
                            }
                            if (birthday[i].text == "" && calls.length > 1) {
                              birthday.removeAt(i);
                            }
                          }

                          for (var i = 0; i < calls.length; i++) {
                            if (calls[i].text != "") {
                              callsCopy.add(
                                Task(
                                    text: calls[i].text,
                                    time: (valuesAlarmCalls[i])
                                        ? timesCalls[i]
                                        : null),
                              );
                            }
                            if (calls[i].text == "" && calls.length > 1) {
                              calls.removeAt(i);
                            }
                          }

                          for (var i = 0; i < tasks.length; i++) {
                            if (tasks[i].text != "") {
                              tasksCopy.add(
                                Task(
                                    text: tasks[i].text,
                                    time: (valuesAlarmTasks[i])
                                        ? timesTasks[i]
                                        : null),
                              );
                            }
                            if (tasks[i].text == "" && tasks.length > 1) {
                              tasks.removeAt(i);
                            }
                          }

                          for (var i = 0; i < success.length; i++) {
                            if (success[i].text != "") {
                              successCopy.add(
                                Task(
                                    text: success[i].text,
                                    time: (valuesAlarmSuccess[i])
                                        ? timesSuccess[i]
                                        : null),
                              );
                            }
                            if (success[i].text == "" && success.length > 1) {
                              success.removeAt(i);
                            }
                          }

                          newCase = Case(
                            date: date,
                            frogs: frogCopy,
                            birthdays: birthdayCopy,
                            calls: callsCopy,
                            tasks: tasksCopy,
                            successes: successCopy,
                          );
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();

                          await notify(
                            tasksCopy,
                            date ??
                                DateTime.now().add(
                                  Duration(days: 1),
                                ),
                          );

                          context.read<UserBloc>().add(
                                AddCase(
                                    newCase: newCase,
                                    phone: pref.getString('phone')!),
                              );

                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            color: Color.fromARGB(255, 111, 207, 151),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Сохранить",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

Future<void> notify(List<Task> tasksCopy, DateTime date) async {
  for (var task in tasksCopy) {
    if (task.time != null) {
      if (DateTime(date.year, date.month, date.day, task.time!.hour,
              task.time!.minute)
          .isAfter(DateTime.now())) {
        await NotificationService().showNotification(
          title: task.text,
          body: (task.isTicked == null || task.isTicked == false)
              ? "Не выполнено"
              : "Выполнено",
          time: DateTime(date.year, date.month, date.day, task.time!.hour,
              task.time!.minute),
        );
      }
    }
  }
}

class CustomTime extends StatelessWidget {
  List<TextEditingController> controllers;

  List<bool> valuesAlarms;

  List<TimeOfDay?> times;

  Function setState;

  CustomTime(
      {super.key,
      required this.controllers,
      required this.valuesAlarms,
      required this.times,
      required this.setState});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      shrinkWrap: true,
      itemCount: controllers.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  color: Colors.white,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    if (index == controllers.length - 1) {
                      setState(
                        () {
                          controllers.add(TextEditingController());
                          valuesAlarms.add(false);
                          times.add(
                            const TimeOfDay(hour: 12, minute: 00),
                          );
                        },
                      );
                    }
                  },
                  controller: controllers[index],
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      border: InputBorder.none,
                      hintText: "Новая запись..."),
                ),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            const Icon(
              Icons.alarm,
              color: Colors.white,
            ),
            SizedBox(
              width: 8.0,
            ),
            Switch(
              thumbColor: const MaterialStatePropertyAll(Colors.white),
              inactiveTrackColor: Color.fromARGB(59, 158, 158, 158),
              activeTrackColor: Colors.grey.shade100,
              value: valuesAlarms[index],
              onChanged: (val) => setState(
                () {
                  valuesAlarms[index] = val;
                },
              ),
            ),
            (valuesAlarms[index])
                ? GestureDetector(
                    onTap: () async {
                      times[index] = await showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 12, minute: 00),
                          ) ??
                          const TimeOfDay(hour: 12, minute: 00);
                      if (times[index] == null) {
                        times[index] = TimeOfDay.now();
                      }
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        '${(times[index]!.hour > 9) ? times[index]!.hour : '0${times[index]!.hour}'}:${(times[index]!.minute > 9) ? times[index]!.minute : '0${times[index]!.minute}'}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}

class Node extends StatelessWidget {
  final Widget icon;
  final String title;
  final Icon? info;

  Node({
    super.key,
    required this.icon,
    required this.title,
    this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon,
            const SizedBox(
              width: 8.0,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              width: 8.0,
            ),
            info ?? const SizedBox(),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
