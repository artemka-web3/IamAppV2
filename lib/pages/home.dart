import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_am_app/pages/auth/birth_meaning.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';

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
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
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
                                      fontSize: 47,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Icon(
                                  (diff < 0.0)
                                      ? Icons.arrow_circle_down
                                      : Icons.arrow_circle_up,
                                  size: 23,
                                ),
                                Text(
                                  diff.toStringAsFixed(1),
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      color: Color(0xFF252D28),
                                      fontSize: 25,
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xFF2C3932),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              onPressed: () {},
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
                          : DayTasks(
                              newCase: newCase!,
                            ),
                    ],
                  ),
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
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (newCase.frogs != null) ? newCase.frogs!.length : 0,
          itemBuilder: (context, index) {
            return Node(
              icon: SvgPicture.asset(
                "assets/images/frog.svg",
              ),
              task: newCase.frogs[index],
              newCase: newCase,
            );
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              (newCase.birthdays != null) ? newCase.birthdays!.length : 0,
          itemBuilder: (context, index) {
            return Node(
              icon: SvgPicture.asset(
                "assets/images/cake.svg",
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              task: newCase.birthdays[index],
              newCase: newCase,
            );
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (newCase.calls != null) ? newCase.calls!.length : 0,
          itemBuilder: (context, index) {
            return Node(
              icon: const Icon(
                Icons.phone,
                color: Colors.black,
              ),
              task: newCase.calls[index],
              newCase: newCase,
            );
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (newCase.tasks != null) ? newCase.tasks!.length : 0,
          itemBuilder: (context, index) {
            return Node(
              icon: SvgPicture.asset(
                "assets/images/task.svg",
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              task: newCase.tasks[index],
              newCase: newCase,
            );
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
                          '${task.time!.hour}:${task.time!.minute}',
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
