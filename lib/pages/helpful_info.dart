import 'package:flutter/material.dart';
import "add_info.dart";

class HelpfulInfo extends StatefulWidget {
  const HelpfulInfo({super.key});

  @override
  State<HelpfulInfo> createState() => _HelpfulInfoState();
}

class _HelpfulInfoState extends State<HelpfulInfo> {
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
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(16.0),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddInfo(sphereIndex: index),
                            ),
                          );
                          // Navigate to spheres[index] page
                        },
                      ),
                    );
                  }),
            ),
          ))
        ],
      ),
    );
  }
}
