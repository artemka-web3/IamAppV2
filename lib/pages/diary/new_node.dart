import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/case.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<TextEditingController> frog = [TextEditingController()];
List<TextEditingController> birthday = [TextEditingController()];
List<TextEditingController> calls = [TextEditingController()];
List<TextEditingController> tasks = [TextEditingController()];
List<TextEditingController> success = [TextEditingController()];

class NewNode extends StatelessWidget {
  NewNode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24.0,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          color: Colors.white,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "Четверг 23/03",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Node(
                      controllers: frog,
                      icon: const Icon(
                        Icons.pets,
                        color: Colors.white,
                      ),
                      title: 'Лягушка дня',
                    ),
                    const SizedBox(height: 8.0),
                    Node(
                      controllers: birthday,
                      icon: const Icon(
                        Icons.cake_outlined,
                        color: Colors.white,
                      ),
                      title: 'Дни рождения и праздники',
                    ),
                    const SizedBox(height: 8.0),
                    Node(
                      controllers: calls,
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      title: 'Встречи и звонки',
                    ),
                    const SizedBox(height: 8.0),
                    Node(
                      controllers: tasks,
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      title: 'Задачи',
                    ),
                    const SizedBox(height: 8.0),
                    Node(
                      controllers: success,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      title: 'Успехи дня',
                    ),
                    const SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () async {
                        List<String> frogCopy = [];
                        List<String> birthdayCopy = [];
                        List<String> callsCopy = [];
                        List<String> tasksCopy = [];
                        List<String> successCopy = [];

                        Case newCase;

                        for (var i = 0; i < frog.length; i++) {
                          if (frog[i].text == "" && frog.length > 1) {
                            frog.removeAt(i);
                          }
                          if (frog[i].text != "") {
                            frogCopy.add(frog[i].text);
                          }
                        }
                        for (var i = 0; i < birthday.length; i++) {
                          if (birthday[i].text == "") {
                            birthday.removeAt(i);
                          }
                          if (birthday[i].text != "") {
                            birthdayCopy.add(birthday[i].text);
                          }
                        }
                        for (var i = 0; i < calls.length; i++) {
                          if (calls[i].text == "" && calls.length > 1) {
                            calls.removeAt(i);
                          }
                          if (calls[i].text != "") {
                            callsCopy.add(calls[i].text);
                          }
                        }
                        for (var i = 0; i < tasks.length; i++) {
                          if (tasks[i].text == "" && tasks.length > 1) {
                            tasks.removeAt(i);
                          }
                          if (tasks[i].text != "") {
                            tasksCopy.add(tasks[i].text);
                          }
                        }
                        for (var i = 0; i < success.length; i++) {
                          if (success[i].text == "" && success.length > 1) {
                            success.removeAt(i);
                          }
                          if (success[i].text != "") {
                            successCopy.add(success[i].text);
                          }
                        }
                        newCase = Case(
                          frogs: frogCopy,
                          birthdays: birthdayCopy,
                          calls: callsCopy,
                          tasks: tasksCopy,
                          successes: successCopy,
                        );
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        print(newCase);
                        context.read<UserBloc>().add(
                              AddCase(
                                  newCase: newCase,
                                  phone: pref.getString('phone')!),
                            );
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
                              const SizedBox(
                                width: 4.0,
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
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Node extends StatelessWidget {
  final Icon icon;
  final String title;
  final Icon? info;

  List<TextEditingController> controllers;

  Node({
    super.key,
    required this.icon,
    required this.title,
    this.info,
    required this.controllers,
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
        StatefulBuilder(
          builder: (context, setState) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shrinkWrap: true,
              itemCount: controllers.length,
              itemBuilder: (context, index) {
                return Container(
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
                            () => controllers.add(TextEditingController()));
                      }
                    },
                    controller: controllers[index],
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
      ],
    );
  }
}
