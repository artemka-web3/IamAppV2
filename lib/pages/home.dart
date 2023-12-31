import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_am_app/pages/auth/birth_meaning.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:i_am_app/pages/diary/new_node.dart';

import '../classes/models/case.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  Case newCase = Case();

  double lifeIndex = 0.0;
  double prevLifeIndex = 0.0;

  double diff = 0.0;

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          for (var i in state.user.index) {
            if (i.date.month == DateTime.now().month) {
              lifeIndex = i.lifeIndex;
            }
            if (DateTime.now().month != 1) {
              if (i.date.month == DateTime.now().month - 1) {
                prevLifeIndex = i.lifeIndex;
              }
            } else {
              if (i.date.month == DateTime.december) {
                prevLifeIndex = i.lifeIndex;
              }
            }
          }
          for (var i in state.user.cases) {
            if (i.date!.day == DateTime.now().day &&
                i.date!.month == DateTime.now().month &&
                i.date!.year == DateTime.now().year) {
              newCase = i;
              break;
            }
          }
        }
        diff = lifeIndex - prevLifeIndex;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45 < 230
                          ? 250
                          : MediaQuery.of(context).size.width * 0.45,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Индекс жизни:',
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                    color: Color(0xFF252D28),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  )),
                                ),
                                Text(
                                  months[DateTime.now().month - 1],
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                    color: Color(0xFF252D28),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  )),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    lifeIndex.toStringAsFixed(1),
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF252D28),
                                        fontSize: 52,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    (diff < 0.0)
                                        ? Icons.arrow_circle_down
                                        : Icons.arrow_circle_up,
                                    size: 24,
                                  ),
                                  Text(
                                    diff.abs().toStringAsFixed(1),
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF252D28),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30 < 240
                        ? 240
                        : MediaQuery.of(context).size.width * 0.30,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            foregroundColor:
                                MaterialStatePropertyAll(Color(0xFF252E29))),
                        onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BirthMeaning(),
                            ),
                            (route) => false),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.support,
                                color: Color(0xFF219653),
                              ),
                              Text(
                                'Моя характеристика',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                color: const Color(0xFF2C3932),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const SizedBox(
                              width: 24,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Задачи на сегодня:',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w400,
                              )),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.format_list_bulleted_add,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NewNode(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    (newCase.date == null)
                        ? Column(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 200,
                              ),
                              Text(
                                'Пока тут пусто',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                )),
                              ),
                            ],
                          )
                        : Container(
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              child: DayTasks(
                                newCase: newCase,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: newCase.frogs.length,
          itemBuilder: (context, index) {
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
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: newCase.birthdays.length,
          itemBuilder: (context, index) {
            if (newCase.birthdays[index].isTicked == null ||
                newCase.birthdays[index].isTicked == false) {
              return Node(
                icon: SvgPicture.asset(
                  "assets/images/cake.svg",
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
                task: newCase.birthdays[index],
                newCase: newCase,
              );
            } else {
              return SizedBox();
            }
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: newCase.calls.length,
          itemBuilder: (context, index) {
            if (newCase.calls[index].isTicked == null ||
                newCase.calls[index].isTicked == false) {
              return Node(
                icon: const Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
                task: newCase.calls[index],
                newCase: newCase,
              );
            } else {
              return SizedBox();
            }
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: newCase.tasks.length,
          itemBuilder: (context, index) {
            if (newCase.tasks[index].isTicked == null ||
                newCase.tasks[index].isTicked == false) {
              return Node(
                icon: SvgPicture.asset(
                  "assets/images/task.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
                task: newCase.tasks[index],
                newCase: newCase,
              );
            } else {
              return SizedBox();
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
                context.read<UserBloc>().add(
                      UpdateCase(
                        phone: context.read<UserBloc>().state.user.phone,
                        newCase: newCase,
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
