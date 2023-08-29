// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/info.dart';
import 'package:i_am_app/classes/page_index.dart';
import 'package:i_am_app/main.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';

String save = "Сохранить";

class AddInfo extends StatefulWidget {
  final int sphereIndex;
  const AddInfo({super.key, required this.sphereIndex});

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  List<TextEditingController> controllerQutes = [TextEditingController()];
  List<TextEditingController> controllerApps = [TextEditingController()];
  List<TextEditingController> controllerWebsites = [TextEditingController()];
  List<TextEditingController> controllerBooks = [TextEditingController()];
  List<TextEditingController> controllerFilms = [TextEditingController()];

  bool isVisibleQutes = true;
  bool isVisibleApps = true;
  bool isVisibleWebsites = true;
  bool isVisibleBooks = true;
  bool isVisibleFilms = true;

  int? indexOfInfo;

  List<String> spheres = [
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Inter',
            primaryColor: const Color(0xFF252E29),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF252E29))),
        home: Scaffold(
          appBar: AppBar(
            title: Text(spheres[widget.sphereIndex]),
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios)),
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              var data = Info(title: spheres[widget.sphereIndex]);
              for (var i = 0; i < state.user.info.length; i++) {
                if (state.user.info[i].title == spheres[widget.sphereIndex]) {
                  indexOfInfo = i;
                  controllerQutes = [];
                  controllerApps = [];
                  controllerWebsites = [];
                  controllerBooks = [];
                  controllerFilms = [];
                  for (var j = 0; j < state.user.info[i].quotes.length; j++) {
                    if (state.user.info[i].quotes[j] != '') {
                      controllerQutes.add(TextEditingController(
                          text: state.user.info[i].quotes[j]));
                    }
                  }
                  for (var j = 0; j < state.user.info[i].apps.length; j++) {
                    if (state.user.info[i].apps[j] != '') {
                      controllerApps.add(TextEditingController(
                          text: state.user.info[i].apps[j]));
                    }
                  }
                  for (var j = 0; j < state.user.info[i].websites.length; j++) {
                    if (state.user.info[i].websites[j] != '') {
                      controllerWebsites.add(TextEditingController(
                          text: state.user.info[i].websites[j]));
                    }
                  }
                  for (var j = 0; j < state.user.info[i].films.length; j++) {
                    if (state.user.info[i].films[j] != '') {
                      controllerFilms.add(TextEditingController(
                          text: state.user.info[i].films[j]));
                    }
                  }
                  for (var j = 0; j < state.user.info[i].books.length; j++) {
                    if (state.user.info[i].books[j] != '') {
                      controllerBooks.add(TextEditingController(
                          text: state.user.info[i].books[j]));
                    }
                  }
                  controllerQutes.add(TextEditingController());
                  controllerApps.add(TextEditingController());
                  controllerWebsites.add(TextEditingController());
                  controllerBooks.add(TextEditingController());
                  controllerFilms.add(TextEditingController());
                  data = state.user.info[i];
                  break;
                }
              }
              return ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/background.png",
                        ), //путь к вашему изображению
                        fit: BoxFit.cover),
                  ),
                  child: SingleChildScrollView(
                    child: StatefulBuilder(builder: (context, setState) {
                      return Column(mainAxisSize: MainAxisSize.max, children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                const Text(
                                  'Цитаты',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(
                                        () => isVisibleQutes = !isVisibleQutes);
                                  },
                                  icon: Text(
                                    (isVisibleQutes) ? "-" : '+',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isVisibleQutes,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controllerQutes.length,
                                itemBuilder: (context, index) {
                                  return TextForm(
                                    controller: controllerQutes[index],
                                    controllers: controllerQutes,
                                    index: index,
                                    setState: setState,
                                    onChanged: () {
                                      data.quotes = List.from(
                                          controllerQutes.map((e) => e.text));
                                      data.apps = List.from(
                                          controllerApps.map((e) => e.text));
                                      data.websites = List.from(
                                          controllerWebsites
                                              .map((e) => e.text));
                                      data.books = List.from(
                                          controllerBooks.map((e) => e.text));
                                      data.films = List.from(
                                          controllerFilms.map((e) => e.text));
                                      if (indexOfInfo == null) {
                                        state.user.info.add(data);
                                      } else {
                                        state.user.info[indexOfInfo!] = data;
                                      }
                                      save = "Добавлено";
                                      context.read<UserBloc>().add(UpdateInfo(
                                          phone: state.user.phone, info: data));
                                    },
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text('Приложения',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(
                                      () => isVisibleApps = !isVisibleApps);
                                },
                                icon: Text(
                                  (isVisibleApps) ? "-" : '+',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isVisibleApps,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controllerApps.length,
                                itemBuilder: (context, index) {
                                  return TextForm(
                                    controllers: controllerApps,
                                    index: index,
                                    controller: controllerApps[index],
                                    setState: setState,
                                    onChanged: () {
                                      data.quotes = List.from(
                                          controllerQutes.map((e) => e.text));
                                      data.apps = List.from(
                                          controllerApps.map((e) => e.text));
                                      data.websites = List.from(
                                          controllerWebsites
                                              .map((e) => e.text));
                                      data.books = List.from(
                                          controllerBooks.map((e) => e.text));
                                      data.films = List.from(
                                          controllerFilms.map((e) => e.text));
                                      if (indexOfInfo == null) {
                                        state.user.info.add(data);
                                      } else {
                                        state.user.info[indexOfInfo!] = data;
                                      }
                                      save = "Добавлено";
                                      context.read<UserBloc>().add(UpdateInfo(
                                          phone: state.user.phone, info: data));
                                    },
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text('Сайты',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() =>
                                      isVisibleWebsites = !isVisibleWebsites);
                                },
                                icon: Text(
                                  (isVisibleWebsites) ? "-" : '+',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isVisibleWebsites,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controllerWebsites.length,
                                itemBuilder: (context, index) {
                                  return TextForm(
                                    controllers: controllerWebsites,
                                    index: index,
                                    controller: controllerWebsites[index],
                                    setState: setState,
                                    onChanged: () {
                                      data.quotes = List.from(
                                          controllerQutes.map((e) => e.text));
                                      data.apps = List.from(
                                          controllerApps.map((e) => e.text));
                                      data.websites = List.from(
                                          controllerWebsites
                                              .map((e) => e.text));
                                      data.books = List.from(
                                          controllerBooks.map((e) => e.text));
                                      data.films = List.from(
                                          controllerFilms.map((e) => e.text));
                                      if (indexOfInfo == null) {
                                        state.user.info.add(data);
                                      } else {
                                        state.user.info[indexOfInfo!] = data;
                                      }
                                      save = "Добавлено";
                                      context.read<UserBloc>().add(UpdateInfo(
                                          phone: state.user.phone, info: data));
                                    },
                                  );
                                }),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text('Книги',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(
                                    () => isVisibleBooks = !isVisibleBooks);
                              },
                              icon: Text(
                                (isVisibleBooks) ? "-" : '+',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: isVisibleBooks,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controllerBooks.length,
                                itemBuilder: (context, index) {
                                  return TextForm(
                                    controllers: controllerBooks,
                                    index: index,
                                    controller: controllerBooks[index],
                                    setState: setState,
                                    onChanged: () {
                                      data.quotes = List.from(
                                          controllerQutes.map((e) => e.text));
                                      data.apps = List.from(
                                          controllerApps.map((e) => e.text));
                                      data.websites = List.from(
                                          controllerWebsites
                                              .map((e) => e.text));
                                      data.books = List.from(
                                          controllerBooks.map((e) => e.text));
                                      data.films = List.from(
                                          controllerFilms.map((e) => e.text));
                                      if (indexOfInfo == null) {
                                        state.user.info.add(data);
                                      } else {
                                        state.user.info[indexOfInfo!] = data;
                                      }
                                      save = "Добавлено";
                                      context.read<UserBloc>().add(UpdateInfo(
                                          phone: state.user.phone, info: data));
                                    },
                                  );
                                }),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text('Фильмы',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(
                                    () => isVisibleFilms = !isVisibleFilms);
                              },
                              icon: Text(
                                (isVisibleFilms) ? "-" : '+',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: isVisibleFilms,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: controllerFilms.length,
                              itemBuilder: (context, index) {
                                return TextForm(
                                  controllers: controllerFilms,
                                  index: index,
                                  controller: controllerFilms[index],
                                  setState: setState,
                                  onChanged: () {
                                    data.quotes = List.from(
                                        controllerQutes.map((e) => e.text));
                                    data.apps = List.from(
                                        controllerApps.map((e) => e.text));
                                    data.websites = List.from(
                                        controllerWebsites.map((e) => e.text));
                                    data.books = List.from(
                                        controllerBooks.map((e) => e.text));
                                    data.films = List.from(
                                        controllerFilms.map((e) => e.text));
                                    if (indexOfInfo == null) {
                                      state.user.info.add(data);
                                    } else {
                                      state.user.info[indexOfInfo!] = data;
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: GestureDetector(
                            onTap: () {
                              data.quotes =
                                  List.from(controllerQutes.map((e) => e.text));
                              data.apps =
                                  List.from(controllerApps.map((e) => e.text));
                              data.websites = List.from(
                                  controllerWebsites.map((e) => e.text));
                              data.books =
                                  List.from(controllerBooks.map((e) => e.text));
                              data.films =
                                  List.from(controllerFilms.map((e) => e.text));
                              if (indexOfInfo == null) {
                                state.user.info.add(data);
                              } else {
                                state.user.info[indexOfInfo!] = data;
                              }
                              save = "Добавлено";
                              context.read<UserBloc>().add(UpdateInfo(
                                  phone: state.user.phone, info: data));
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color.fromARGB(255, 111, 207, 151),
                              ),
                              child: Center(
                                child: Text(
                                  save,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 124.0,
                        ),
                      ]);
                    }),
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class TextForm extends StatelessWidget {
  List<TextEditingController> controllers;
  final index;

  final TextEditingController? controller;
  final Function setState;
  final onChanged;

  TextForm(
      {super.key,
      this.controller,
      required this.setState,
      this.index,
      required this.controllers,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14.0),
              onChanged: (value) {
                setState(() {
                  save = 'Сохранить';
                });
              },
              onFieldSubmitted: (newValue) {
                setState(() {
                  onChanged();
                });
              },
              decoration: InputDecoration(
                hintText: "Введите...",
                hintStyle: const TextStyle(
                  color: Color.fromARGB(129, 37, 46, 41),
                ),
                contentPadding: const EdgeInsets.all(16.0),
                border: InputBorder.none,
                fillColor: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 4.0,
          ),
          IconButton(
            onPressed: () {
              save = 'Сохранить';
              if (controllers.length > 1) {
                controllers.removeAt(index);
              }
              setState(() {});
            },
            icon: Icon(
              Icons.delete,
              color: Color.fromARGB(185, 244, 67, 54),
            ),
          ),
        ],
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
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}





// Expanded(
//                           cColor.fromARGB(255, 208, 173, 173)g(
//                           padding: EdgeInsets.all(20),
//                           child: Container(
//                             height: 50,
//                             child: ListView.builder(
//                                 //scrollDirection: Axis.vertical,
//                                 itemCount: healthQuotes.length,
//                                 itemBuilder: (context, index) {
//                                   return Card(
//                                       child: ListTile(
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(15.0)),
//                                           title: Text(healthQuotes[index]),
//                                           tileColor: Colors.white,
//                                           onTap: () {}));
//                                 }),
//                           ),
//                         )),