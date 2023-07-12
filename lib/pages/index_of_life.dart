import 'package:flutter/material.dart';

class LifeIndex extends StatefulWidget {
  const LifeIndex({super.key});

  @override
  State<LifeIndex> createState() => _LifeIndexState();
}

class _LifeIndexState extends State<LifeIndex> {
  String _currentMonth = "";

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
  void _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Введите текст'),
            content: TextFormField(
              // Вместо controller вы также можете использовать onChanged метод для получения значения введенного текста
              controller: _controller,
              decoration: InputDecoration(hintText: "Введите текст"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: new Text('СОХРАНИТЬ'),
                onPressed: () {
                  //Закрывает диалоговое окно и возвращает введенное значение
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Container(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: months.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), elevation: 20, child: Center(child: Padding(padding: EdgeInsets.all(28), child: Column(children: [Icon(Icons.add_a_photo_outlined), Text(months[index])])))),
                  onTap: () {
                    setState(() {
                      _currentMonth = months[index];
                    });
                  }
                );
              },
            )
          ),
          Container(
            height: 60,
            child: Center(
              child: Text(_currentMonth, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400))
            ),
          ),
          Container(
            height: 100,
            child: Center(
              child: Text("87.4", style: TextStyle(color: Colors.white, fontSize: 72, fontWeight: FontWeight.w800))
            ),
          ),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        title: Text(spheres[index]), 
                        tileColor: Colors.white, 
                        trailing: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF252E29),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('Value', style: TextStyle(color: Colors.white)),
                        ),
                        onTap: () {
                          _displayDialog(context);
                        }
                      )
                    );
                  }
                ),
              ),
            ) 
          )
        ],
      ),
    );
  }
}