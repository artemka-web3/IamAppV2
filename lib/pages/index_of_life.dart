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
  final ScrollController controller = ScrollController();

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
        animateControllerJump(controller);
        if (state is UserInitial) {
          li.LifeIndex data = updateControllers(
            controllers,
            indexMonth,
            context,
          );
          return Column(
            children: [
              SizedBox(
                  height: 110,
                  child: ListView.builder(
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: months.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const SizedBox();
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
              SizedBox(
                height: 60,
                child: Center(
                    child: Text(months[indexMonth - 1],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w400))),
              ),
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    data.lifeIndex.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 6.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: spheres.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              spheres[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                            Container(
                              width: 42,
                              height: 34,
                              decoration: BoxDecoration(
                                color: const Color(0xFF252E29),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: controllers[index],
                                  onTap: () => controllers[index].clear(),
                                  onTapOutside: (p0) =>
                                      tapOutside(controllers, index),
                                  onChanged: (value) =>
                                      changeField(controllers, index, context),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 24),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 3.0),
                                      border: InputBorder.none,
                                      hintText: '0'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () => save(controllers, data, context),
                child: Text(
                  'Сохранить',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
            ],
          );
        } else {
          //Loading
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
      },
    );
  }
}

//Init conrollers
li.LifeIndex updateControllers(List<TextEditingController> controllers,
    int indexMonth, BuildContext context) {
  final state = BlocProvider.of<UserBloc>(context).state;
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
  return data;
}

void animateControllerJump(ScrollController controller) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (controller.hasClients) {
      controller.animateTo((DateTime.now().month - 1) * (110 + 8.0),
          duration: const Duration(milliseconds: 760), curve: Curves.bounceOut);
    }
  });
}

///Динамическая проверка на условие x <= 5
void changeField(
    List<TextEditingController> controllers, int index, BuildContext context) {
  if (controllers[index].text.length == 3) {
    if (double.parse(controllers[index].text) > 5.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            color: Colors.white,
            child: const Center(
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
}

///Скидываем до нуля контролер если ничего разумного не ввели
void tapOutside(List<TextEditingController> controllers, int index) {
  if (controllers[index].text.length != 3) {
    controllers[index].text = '0.0';
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

///Когда жмём на 'Сохранить'
void save(List<TextEditingController> controllers, li.LifeIndex data,
    BuildContext context) {
  for (var i = 0; i < controllers.length; i++) {
    data.indexes?[i] = double.tryParse(controllers[i].text) ?? 0.0;
  }
  context.read<UserBloc>().add(UpdateIndex(
      phone: BlocProvider.of<UserBloc>(context).state.user.phone, index: data));
}
