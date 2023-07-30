import 'package:flutter/material.dart';
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
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            List<double> buf = [];
            for (var i = 0; i < 20; i++) {
              buf.add(0);
            }
            li.LifeIndex data = li.LifeIndex(
                date: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                ),
                indexes: buf);
            if (state.user.index.isNotEmpty) {
              for (var i in state.user.index) {
                if (i.date.month == indexMonth) {
                  data = i;
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
                        return InkWell(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                elevation: 20,
                                child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(28),
                                        child: Column(children: [
                                          Icon(Icons.add_a_photo_outlined),
                                          Text(months[index - 1])
                                        ])))),
                            onTap: () {
                              for (var i in state.user.index) {
                                if (i.date.month == index) {
                                  data = i;
                                  break;
                                }
                              }
                              setState(() {
                                indexMonth = index;
                              });
                            });
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
                          (data != null) ? data!.lifeIndex.toString() : "-",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 72,
                              fontWeight: FontWeight.w800))),
                ),
                SizedBox(
                  height: 18.0,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () => context
                        .read<UserBloc>()
                        .add(UpdateIndex(phone: state.user.phone, index: data)),
                    child: Text(
                      'Сохранить',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: spheres.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  title: Text(
                                    spheres[index],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                  tileColor: Colors.white,
                                  trailing: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF252E29),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      data.indexes![index].toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Введите текст'),
                                            content: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              // Вместо controller вы также можете использовать onChanged метод для получения значения введенного текста
                                              controller: _controller,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              decoration: InputDecoration(
                                                  hintText: "Введите текст",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: Text('СОХРАНИТЬ'),
                                                onPressed: () {
                                                  data.indexes![index] =
                                                      double.tryParse(
                                                              _controller
                                                                  .text) ??
                                                          data.indexes![index];
                                                  context.read<UserBloc>().add(
                                                      UpdateIndex(
                                                          phone:
                                                              state.user.phone,
                                                          index: data));
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                    ;
                                  }));
                        }),
                  ),
                ))
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
      ),
    );
  }
}
