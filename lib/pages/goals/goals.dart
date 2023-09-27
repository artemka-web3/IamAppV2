import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/goal.dart';
import 'package:i_am_app/classes/models/user.dart';
import 'package:i_am_app/classes/page_index.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:i_am_app/pages/diary/new_node.dart';
import 'package:i_am_app/pages/goals/new_goal.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? selectedPeriod = "Период";
String? selectedSphere = "Сфера";
String? selectedTicked = "Статус";

class Goals extends StatelessWidget {
  Goals({super.key});

  bool? isGrown;
  bool? isTicked;

  final List<String> ticked = ['Все', 'Выполнено', 'Не выполнено'];

  final List<String> period = ['Сначала ближние', 'Сначала дальние'];

  final List<String> spheres = [
    'Здоровье',
    'Внешний вид',
    'Любовь',
    'Дети и родители',
    'Друзья и коллеги',
    'Хобби и развлечения',
    'Путешествия',
    'Уют в доме',
    'Личностное развитие',
    'Духовное развитие',
    'Доходы и расходы',
    'Долги',
    'Мой банк. Страхование',
    'Бизнес',
    'Юридические навыки',
    'Сбережения',
    'Благотворительность',
    'Инвестиции',
    'Самоконтроль',
    'Уверенность в себе',
    'Все',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const CircularProgressIndicator();
          }
          final phone = snapshot.data!.getString('phone');
          context.read<UserBloc>().add(GetUserByPhone(phone: phone ?? "-1"));
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/background.png"),
                          fit: BoxFit.cover)),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 111, 207, 151),
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 24.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.0,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return Row(
                          children: [
                            Icon(
                              Icons.filter_list_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            CategoryPicker(
                              callback: (String? str) {
                                selectedPeriod = str;
                                if (selectedPeriod == period[0]) {
                                  isGrown = true;
                                }
                                if (selectedPeriod == period[1]) {
                                  isGrown = false;
                                }
                                context.read<UserBloc>().add(GetUserByPhone(
                                    phone: state.user.phone,
                                    goalSphere: selectedSphere,
                                    goalIsDone: isTicked,
                                    growGoal: isGrown ?? true));
                              },
                              params: period,
                              selected: selectedPeriod,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            CategoryPicker(
                              callback: (String? str) {
                                selectedSphere = str;
                                if (selectedSphere ==
                                    spheres[spheres.length - 1]) {
                                  selectedSphere = null;
                                }
                                context.read<UserBloc>().add(GetUserByPhone(
                                    phone: state.user.phone,
                                    goalSphere: selectedSphere,
                                    goalIsDone: isTicked,
                                    growGoal: isGrown ?? true));
                              },
                              params: spheres,
                              selected: selectedSphere,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            CategoryPicker(
                              callback: (String? str) {
                                selectedTicked = str;
                                if (selectedTicked == ticked[0]) {
                                  isTicked = null;
                                }
                                if (selectedTicked == ticked[1]) {
                                  isTicked = true;
                                }
                                if (selectedTicked == ticked[2]) {
                                  isTicked = false;
                                }
                                context.read<UserBloc>().add(GetUserByPhone(
                                    phone: state.user.phone,
                                    goalSphere: selectedSphere,
                                    goalIsDone: isTicked,
                                    growGoal: isGrown ?? true));
                              },
                              params: ticked,
                              selected: selectedTicked,
                            ),
                          ],
                        );
                      }),
                      const SizedBox(
                        height: 26.0,
                      ),
                      //Месяц
                      (state.user.goals.length != 0)
                          ? Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.user.goals.length,
                                itemBuilder: (context, index) {
                                  if (state.user.goals[index].date!.month ==
                                      DateTime.now().month) {
                                    return Note(
                                      goal: state.user.goals[index],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            )
                          : Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Пусто",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      (state.user.goals.length != 0)
                          ? Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.user.goals.length,
                                itemBuilder: (context, index) {
                                  if (state.user.goals[index].date!.year ==
                                          DateTime.now().year &&
                                      state.user.goals[index].date!.month !=
                                          DateTime.now().month) {
                                    return Note(
                                      goal: state.user.goals[index],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            )
                          : Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Пусто",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Card(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                Text('  Создать новую цель')
                              ],
                            ),
                            tileColor: Colors.white,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const NewGoal(),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Note extends StatelessWidget {
  final Goal goal;

  Note({
    super.key,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final date = goal.date;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          convertDate(date),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: 8.0,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  goal.title ?? "Нет заголовка",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18.0),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    goal.description ?? "Нет описания",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 18.0),
                  ),
                  Checkbox(
                    value: goal.isTicked ?? false,
                    onChanged: (val) async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      goal.isTicked = val ?? false;
                      User user = context.read<UserBloc>().state.user;
                      for (var i = 0; i < user.goals.length; i++) {
                        if (user.goals[i].date == goal.date &&
                            user.goals[i].title == goal.title) {
                          user.goals[i] = goal;
                        }
                      }
                      context.read<UserBloc>().add(
                            UpdateGoal(
                              phone: preferences.getString('phone')!,
                              goal: goal,
                            ),
                          );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

String convertDate(DateTime? date) {
  if (date == null) {
    return "Нет даты";
  } else {
    String day = date.day.toString(),
        month = date.month.toString(),
        year = date.year.toString(),
        result;

    if (date.day < 10) {
      day = '0' + day;
    }
    if (date.month < 10) {
      month = '0' + month;
    }
    result = day + '/' + month + '/' + year;
    return result;
  }
}

class CategoryPicker extends StatelessWidget {
  final Function(String? str) callback;
  final List<String> params;

  String? selected;

  CategoryPicker(
      {super.key,
      required this.callback,
      required this.params,
      this.selected = "Выбор"});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                actionsPadding: EdgeInsets.only(
                  right: 20.0,
                  bottom: 20.0,
                ),
                insetPadding: EdgeInsets.zero,
                title: Text(
                  "Выберите фильтр",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                content: Container(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: params.length,
                      itemBuilder: (context, index) => Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            callback(params[index]);
                            setState(() {});
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                child: Text(
                                  params[index],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 2.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text(
                      "Назад",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              selected ?? "Выбор",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        );
      },
    );
  }
}
