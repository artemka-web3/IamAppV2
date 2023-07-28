import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/case.dart';

import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:i_am_app/pages/diary/new_node.dart';

class Diary extends StatelessWidget {
  const Diary({super.key});

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
                      const Row(
                        children: [
                          Icon(
                            Icons.filter_list_outlined,
                            color: Colors.white,
                          ),
                          Card(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Только не выполненные'),
                          )),
                        ],
                      ),
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
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: (newCase.frogs != null) ? newCase.frogs!.length : 0,
          itemBuilder: (context, index) {
            return Node(
              icon: const Icon(
                Icons.pets,
                color: Colors.green,
              ),
              title: (newCase.frogs != null)
                  ? newCase.frogs![index]
                  : "Нет заголовка",
            );
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              (newCase.birthdays != null) ? newCase.birthdays!.length : 0,
          itemBuilder: (context, index) {
            return Node(
              icon: const Icon(
                Icons.cake,
                color: Colors.white,
              ),
              title: (newCase.birthdays != null)
                  ? newCase.birthdays![index]
                  : "Нет заголовка",
            );
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: (newCase.calls != null) ? newCase.calls!.length : 0,
          itemBuilder: (context, index) {
            return Node(
              icon: const Icon(
                Icons.phone,
                color: Colors.white,
              ),
              title: (newCase.calls != null)
                  ? newCase.calls![index]
                  : "Нет заголовка",
            );
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: (newCase.tasks != null) ? newCase.tasks!.length : 0,
          itemBuilder: (context, index) {
            return Node(
              icon: const Icon(
                Icons.phone,
                color: Colors.white,
              ),
              time:
                  (newCase.tasks != null && newCase.tasks?[index].time != null)
                      ? newCase.tasks![index].time!.hour.toString() +
                          ':' +
                          newCase.tasks![index].time!.minute.toString()
                      : 'Время не установлено',
              title: (newCase.tasks != null)
                  ? newCase.tasks![index].task
                  : "Нет заголовка",
            );
          },
        ),
      ],
    );
  }
}

class Node extends StatelessWidget {
  final String title;
  final Icon icon;

  final String? time;

  const Node({super.key, required this.title, required this.icon, this.time});

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
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              (time != null)
                  ? const SizedBox(
                      height: 12.0,
                    )
                  : const SizedBox(),
              (time != null)
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
                          time ?? 'Не указано',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 18.0),
                        ),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
          Align(
              alignment: Alignment.center,
              child: Switch(value: false, onChanged: (val) {})),
        ],
      ),
    );
  }
}
