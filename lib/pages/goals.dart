import 'package:flutter/material.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              child: ListView(children: [
                Row(
                  children: [
                    Icon(Icons.filter_list_outlined, color: Colors.white,),
                    Card(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Период'),
                    )),
                    Card(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Сфера'),
                    )),
                    Card(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Статус'),
                    )),

                  ],
                ),
                Text('Месяц',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w400)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Здоровье'),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Сходить в спортзал'),
                                  Checkbox(value: true, onChanged: (v) {})
                                ]),
                          ),
                          tileColor: Colors.white,
                          onTap: () {})),
                ),
                Text('Год',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w400)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Бизнес'),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Сходить в налоговую'),
                                  Checkbox(value: true, onChanged: (v) {})
                                ]),
                          ),
                          tileColor: Colors.white,
                          onTap: () {})),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              Text('  Создать новую цель')
                            ],
                          ),
                          tileColor: Colors.white,
                          onTap: () {})),
                )
              ]),
            ),
          ))
        ],
      ),
    );
  }
}