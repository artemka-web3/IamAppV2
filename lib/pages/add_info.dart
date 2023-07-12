import 'package:flutter/material.dart';
import 'package:i_am_app/main.dart';

class AddInfo extends StatefulWidget {
  final int sphereIndex;
  const AddInfo({super.key, required this.sphereIndex});

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  int _currentIndex = 5;
  List<String> healthQuotes = [
    'Хочешь что-то сделать хорошо сделай это сам',
    'Хочешь что-то сделать хорошо сделай это сам',
    'Хочешь что-то сделать хорошо сделай это сам'
  ];
  List<String> healthApps = ['HealthCare 1', 'HealthCare 2', 'HealthCare 3'];
  List<String> healthFilms = ['Фильм 1', 'Фильм 2', 'Фильм 3'];
  List<String> healthBooks = ['книга 1', 'книга 2', 'книга 3'];
  List<String> healthWebs = [
    'https://www.health.com/1',
    'https://www.health.com/2',
    'https://www.health.com/3'
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Inter',
            primaryColor: Color(0xFF252E29),
            appBarTheme: AppBarTheme(backgroundColor: Color(0xFF252E29))),
        home: Scaffold(
          appBar: AppBar(
            title: Text(spheres[widget.sphereIndex]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xFF252E29),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xff6FCF97),
            unselectedItemColor: Colors.white,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_outlined), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.event_note_outlined), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.spa_outlined), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assessment_outlined), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmarks_outlined), label: ''),
            ],
            onTap: (index) {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(pageIndex: index),
                  ),
                );
              });
            },
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/background.png"
                  ), //путь к вашему изображению
                  fit: BoxFit.cover
                ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Цитаты',style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),)
                  ),
                  Container(
                    height: 220,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: healthQuotes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(15.0)),
                                title: Text(healthQuotes[index]),
                                tileColor: Colors.white,
                                onTap: () {}
                              )
                          );
                        }),
                      )
                    ), 
                  Container(
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Приложения',style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),)
                  ),
                  Container(
                    height: 220,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: healthQuotes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(15.0)),
                                title: Text(healthQuotes[index]),
                                tileColor: Colors.white,
                                onTap: () {}
                              )
                          );
                        }),
                      )
                    ), 
                  Container(
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Сайты',style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),)
                  ),
                  Container(
                    height: 220,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: healthQuotes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(15.0)),
                                title: Text(healthQuotes[index]),
                                tileColor: Colors.white,
                                onTap: () {}
                              )
                          );
                        }),
                      )
                    ),
                  Container(
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Книги',style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),)
                  ),
                  Container(
                    height: 220,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: healthQuotes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(15.0)),
                                title: Text(healthQuotes[index]),
                                tileColor: Colors.white,
                                onTap: () {}
                              )
                          );
                        }),
                      )
                    ),
                  Container(
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Фильмы',style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),)
                  ),
                  Container(
                    height: 220,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: healthQuotes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(15.0)),
                                title: Text(healthQuotes[index]),
                                tileColor: Colors.white,
                                onTap: () {}
                              )
                          );
                        }),
                      )
                    ),  
                  ]
                ),
            ),
          ),
        )
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