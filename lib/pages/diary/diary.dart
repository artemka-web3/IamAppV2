import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_am_app/classes/models/case.dart';
import 'package:i_am_app/classes/models/user.dart';

import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:i_am_app/pages/diary/new_node.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> param = [
  "Все",
  "Только не выполненные",
  "Только выполненные",
];
String? paramVal;

class Diary extends StatelessWidget {
  Diary({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatefulBuilder(builder: (context, setState) {
                        return Row(
                          children: [
                            Icon(
                              Icons.filter_list_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: DropdownButton(
                                onChanged: (value) async {
                                  paramVal = value ?? "Все";
                                  if (value != null) {
                                    if (value == param[0]) {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      context.read<UserBloc>().add(
                                            GetUserByPhone(
                                                phone: preferences
                                                    .getString('phone')!),
                                          );
                                    }
                                    if (value == param[1]) {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      context.read<UserBloc>().add(
                                            GetUserByPhone(
                                                phone: preferences
                                                    .getString('phone')!,
                                                onlyDone: false),
                                          );
                                    }
                                    if (value == param[2]) {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      context.read<UserBloc>().add(
                                            GetUserByPhone(
                                                phone: preferences
                                                    .getString('phone')!,
                                                onlyDone: true),
                                          );
                                    }
                                  }
                                },
                                hint: const Text(
                                  "Выбрать",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(75, 37, 46, 41),
                                  ),
                                ),
                                value: paramVal,
                                items: param.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        );
                      }),
                      IconButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => NewNode())),
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    key: UniqueKey(),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.user.cases.length,
                    itemBuilder: (context, index) {
                      return DayTasks(
                        newCase: state.user.cases[index],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DayTasks extends StatelessWidget {
  final Case newCase;

  const DayTasks({super.key, required this.newCase});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            (newCase.date != null)
                ? '${newCase.date!.day}/${newCase.date!.month}'
                : "Нет даты",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ListView.builder(
          key: UniqueKey(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (newCase.frogs != null) ? newCase.frogs!.length : 0,
          itemBuilder: (context, index) {
            if (paramVal == param[0] || paramVal == null) {
              return Node(
                icon: SvgPicture.asset(
                  "assets/images/frog.svg",
                ),
                task: newCase.frogs[index],
                newCase: newCase,
              );
            } else {
              if (paramVal == param[1]) {
                if (newCase.frogs[index].isTicked == null ||
                    newCase.frogs[index].isTicked == false) {
                  return Node(
                    icon: SvgPicture.asset(
                      "assets/images/frog.svg",
                    ),
                    task: newCase.frogs[index],
                    newCase: newCase,
                  );
                } else {
                  return SizedBox();
                }
              } else {
                if (paramVal == param[2]) {
                  if (newCase.frogs[index].isTicked != null &&
                      newCase.frogs[index].isTicked == true) {
                    return Node(
                      icon: SvgPicture.asset(
                        "assets/images/frog.svg",
                      ),
                      task: newCase.frogs[index],
                      newCase: newCase,
                    );
                  } else {
                    return SizedBox();
                  }
                } else {
                  return SizedBox();
                }
              }
            }
          },
        ),
        ListView.builder(
          key: UniqueKey(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              (newCase.birthdays != null) ? newCase.birthdays!.length : 0,
          itemBuilder: (context, index) {
            if (paramVal == param[0] || paramVal == null) {
              return Node(
                icon: SvgPicture.asset(
                  "assets/images/cake.svg",
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
                task: newCase.birthdays[index],
                newCase: newCase,
              );
            } else {
              if (paramVal == param[1]) {
                if (newCase.birthdays[index].isTicked == null ||
                    newCase.birthdays[index].isTicked == false) {
                  return Node(
                    icon: SvgPicture.asset(
                      "assets/images/cake.svg",
                      colorFilter:
                          ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                    task: newCase.birthdays[index],
                    newCase: newCase,
                  );
                } else {
                  return SizedBox();
                }
              } else {
                if (paramVal == param[2]) {
                  if (newCase.birthdays[index].isTicked != null &&
                      newCase.birthdays[index].isTicked == true) {
                    return Node(
                      icon: SvgPicture.asset(
                        "assets/images/cake.svg",
                        colorFilter:
                            ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      ),
                      task: newCase.birthdays[index],
                      newCase: newCase,
                    );
                  } else {
                    return SizedBox();
                  }
                } else {
                  return SizedBox();
                }
              }
            }
          },
        ),
        ListView.builder(
          key: UniqueKey(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (newCase.calls != null) ? newCase.calls!.length : 0,
          itemBuilder: (context, index) {
            if (paramVal == param[0] || paramVal == null) {
              return Node(
                icon: Icon(
                  Icons.call,
                  color: Colors.black,
                ),
                task: newCase.calls[index],
                newCase: newCase,
              );
            } else {
              if (paramVal == param[1]) {
                if (newCase.calls[index].isTicked == null ||
                    newCase.calls[index].isTicked == false) {
                  return Node(
                    icon: Icon(
                      Icons.call,
                      color: Colors.black,
                    ),
                    task: newCase.calls[index],
                    newCase: newCase,
                  );
                } else {
                  return SizedBox();
                }
              } else {
                if (paramVal == param[2]) {
                  if (newCase.calls[index].isTicked != null &&
                      newCase.calls[index].isTicked == true) {
                    return Node(
                      icon: Icon(
                        Icons.call,
                        color: Colors.black,
                      ),
                      task: newCase.calls[index],
                      newCase: newCase,
                    );
                  } else {
                    return SizedBox();
                  }
                } else {
                  return SizedBox();
                }
              }
            }
          },
        ),
        ListView.builder(
          key: UniqueKey(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (newCase.tasks != null) ? newCase.tasks!.length : 0,
          itemBuilder: (context, index) {
            if (paramVal == param[0] || paramVal == null) {
              return Node(
                icon: SvgPicture.asset(
                  "assets/images/task.svg",
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
                task: newCase.tasks[index],
                newCase: newCase,
              );
            } else {
              if (paramVal == param[1]) {
                if (newCase.tasks[index].isTicked == null ||
                    newCase.tasks[index].isTicked == false) {
                  return Node(
                    icon: SvgPicture.asset(
                      "assets/images/task.svg",
                      colorFilter:
                          ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                    task: newCase.tasks[index],
                    newCase: newCase,
                  );
                } else {
                  return SizedBox();
                }
              } else {
                if (paramVal == param[2]) {
                  if (newCase.tasks[index].isTicked != null &&
                      newCase.tasks[index].isTicked == true) {
                    return Node(
                      icon: SvgPicture.asset(
                        "assets/images/task.svg",
                        colorFilter:
                            ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      ),
                      task: newCase.tasks[index],
                      newCase: newCase,
                    );
                  } else {
                    return SizedBox();
                  }
                } else {
                  return SizedBox();
                }
              }
            }
          },
        ),
        ListView.builder(
          key: UniqueKey(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              (newCase.successes != null) ? newCase.successes!.length : 0,
          itemBuilder: (context, index) {
            if (paramVal == param[0] || paramVal == null) {
              return Node(
                icon: SvgPicture.asset(
                  "assets/images/award.svg",
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
                task: newCase.successes[index],
                newCase: newCase,
              );
            } else {
              if (paramVal == param[1]) {
                if (newCase.successes[index].isTicked == null ||
                    newCase.successes[index].isTicked == false) {
                  return Node(
                    icon: SvgPicture.asset(
                      "assets/images/award.svg",
                      colorFilter:
                          ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                    task: newCase.successes[index],
                    newCase: newCase,
                  );
                } else {
                  return SizedBox();
                }
              } else {
                if (paramVal == param[2]) {
                  if (newCase.successes[index].isTicked != null &&
                      newCase.successes[index].isTicked == true) {
                    return Node(
                      icon: SvgPicture.asset(
                        "assets/images/award.svg",
                        colorFilter:
                            ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      ),
                      task: newCase.successes[index],
                      newCase: newCase,
                    );
                  } else {
                    return SizedBox();
                  }
                } else {
                  return SizedBox();
                }
              }
            }
          },
        ),
      ],
    );
  }
}

class Node extends StatelessWidget {
  final Case newCase;

  final Widget icon;

  final Task task;

  Node(
      {super.key,
      required this.task,
      required this.icon,
      required this.newCase});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    icon,
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      task.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              (task.time != null)
                  ? const SizedBox(
                      height: 12.0,
                    )
                  : const SizedBox(),
              (task.time != null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.alarm,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${(task.time!.hour > 9) ? task.time!.hour : '0${task.time!.hour}'}:${(task.time!.minute > 9) ? task.time!.minute : '0${task.time!.minute}'}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 18.0),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Switch(
                value: task.isTicked ?? false,
                onChanged: (val) {
                  task.isTicked = val;
                  context.read<UserBloc>().add(UpdateCase(
                      phone: context.read<UserBloc>().state.user.phone,
                      newCase: newCase));
                }),
          ),
        ],
      ),
    );
  }
}
