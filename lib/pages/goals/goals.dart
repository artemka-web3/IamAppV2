import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/goal.dart';
import 'package:i_am_app/classes/models/user.dart';
import 'package:i_am_app/classes/page_index.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:i_am_app/pages/diary/new_node.dart';
import 'package:i_am_app/pages/goals/new_goal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

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
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
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
                            child: Text('Период'),
                          )),
                          Card(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Сфера'),
                          )),
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Статус'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26.0,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Месяц',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      //Месяц
                      (state.user.goals.length != 0)
                          ? ListView.builder(
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Год',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      (state.user.goals.length != 0)
                          ? ListView.builder(
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
                            )
                          : Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Пусто",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
    return Container(
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
    );
  }
}
