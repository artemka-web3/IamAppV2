import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/goal.dart';
import 'package:i_am_app/classes/services/notification_service.dart';
import 'package:i_am_app/pages/auth/logic/bloc/auth_bloc.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewGoal extends StatefulWidget {
  const NewGoal({super.key});

  @override
  State<NewGoal> createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoal> {
  DateTime? date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(Duration(days: 1));

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
  ];

  String? selectedSphere;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        print(date!.month);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              const SizedBox(
                width: 24.0,
              )
            ],
            title: const Center(
              child: Text(
                "Новая цель",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
              ),
            ),
            leading: IconButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  Navigator.of(context).pop();
                  context.read<UserBloc>().add(
                        GetUserByPhone(phone: pref.getString('phone')!),
                      );
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 2 * AppBar().preferredSize.height,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18.0))),
                  child: Column(
                    children: [
                      TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18),
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Введите название...",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(75, 37, 46, 41),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          initializeDateFormatting();
                          date = await showDatePicker(
                            context: context,
                            locale: Locale('ru'),
                            initialDate: DateTime.now().add(Duration(days: 1)),
                            firstDate: DateTime.now().add(Duration(days: 1)),
                            lastDate: DateTime(2030),
                          );
                          date ??= DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)
                              .add(const Duration(days: 1));
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            Text(
                              '${months[date!.month - 1]} ${date!.year}',
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Сфера:",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              onChanged: (value) => setState(() {
                                selectedSphere = value ?? "Выбрать";
                              }),
                              hint: const Text(
                                "Выбрать",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(75, 37, 46, 41),
                                ),
                              ),
                              value: selectedSphere,
                              items: spheres.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 24 + 64,
                        child: TextFormField(
                          maxLines: null,
                          controller: descriptionController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Описание...",
                            hintStyle: TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(75, 37, 46, 41),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () async {
                    if (titleController.text.isEmpty) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          content: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "Введите название",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      );
                      return;
                    }

                    if (selectedSphere == null) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          content: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "Выберите сферу",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      );
                      return;
                    }

                    if (descriptionController.text.isEmpty) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          content: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "Выберите сферу",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      );
                      return;
                    }

                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    Goal goal = Goal(
                        title: titleController.text,
                        date: date,
                        sphere: selectedSphere,
                        description: descriptionController.text);
                    await NotificationService().showNotification(
                      title: selectedSphere,
                      body: descriptionController.text,
                      time: date ?? DateTime.now(),
                    );
                    context.read<UserBloc>().add(
                          AddGoal(
                            goal: goal,
                            phone: preferences.getString('phone')!,
                          ),
                        );
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        111,
                        207,
                        151,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Сохранить",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                (state is UserLoading)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }
}
