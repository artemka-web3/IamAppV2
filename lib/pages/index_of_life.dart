import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:i_am_app/classes/models/life_index.dart' as li;

class LifeIndex extends StatefulWidget {
  const LifeIndex({super.key});

  @override
  State<LifeIndex> createState() => _LifeIndexState();
}

class _LifeIndexState extends State<LifeIndex> {
  int indexMonth = DateTime.now().month;

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
  final List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < spheres.length; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          List<double> buf = [];
          for (var i = 0; i < 20; i++) {
            buf.add(0);
          }
          li.LifeIndex data = li.LifeIndex(
              date: DateTime(
                DateTime.now().year,
                indexMonth,
              ),
              indexes: buf);
          for (var i = 0; i < controllers.length; i++) {
            controllers[i].text = '0.0';
          }
          if (state.user.index.isNotEmpty) {
            for (var i in state.user.index) {
              if (i.date.month == indexMonth) {
                data = i;
                for (var j = 0; j < controllers.length; j++) {
                  controllers[j].text = i.indexes?[j].toString() ?? '0.0';
                }
                break;
              }
            }
          }
          return Column(
            children: [
              Container(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: months.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return SizedBox();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: InkWell(
                            child: Container(
                              width: 110,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.white),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        double lifesum = 0.0;
                                        final list = state.user.index;
                                        for (var i = 0; i < list.length; i++) {
                                          if (list[i].date.month == index) {
                                            lifesum = list[i].lifeIndex;
                                          }
                                        }
                                        return Text(
                                          lifesum.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700),
                                        );
                                      },
                                    ),
                                    Text(months[index - 1])
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              for (var i in state.user.index) {
                                if (i.date.month == index) {
                                  data = i;
                                  for (var j = 0; j < controllers.length; j++) {
                                    controllers[j].text =
                                        i.indexes?[j].toString() ?? '0.0';
                                  }
                                  break;
                                }
                              }
                              setState(() {
                                indexMonth = index;
                              });
                            }),
                      );
                    },
                  )),
              Container(
                height: 60,
                child: Center(
                    child: Text(months[indexMonth - 1],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w400))),
              ),
              Container(
                height: 100,
                child: Center(
                    child: Text(
                        (data != null)
                            ? data!.lifeIndex.toStringAsFixed(1)
                            : "-",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 72,
                            fontWeight: FontWeight.w800))),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                  child: Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: spheres.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: Text(
                              spheres[index],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                            tileColor: Colors.white,
                            trailing: Container(
                              width: 42,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color(0xFF252E29),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: controllers[index],
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                onChanged: (value) {
                                  if (controllers[index].text.length == 3) {
                                    if (double.parse(controllers[index].text) >
                                        5.0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            color: Colors.white,
                                            child: Center(
                                              child: Text(
                                                'Индекс должен быть не больше 5.0',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                      controllers[index].clear();
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: '0'),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  for (var i = 0; i < controllers.length; i++) {
                    data.indexes?[i] =
                        double.tryParse(controllers[i].text) ?? 0.0;
                  }
                  context
                      .read<UserBloc>()
                      .add(UpdateIndex(phone: state.user.phone, index: data));
                },
                child: Text(
                  'Сохранить',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
      },
    );
  }
}
