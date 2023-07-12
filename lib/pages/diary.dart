import 'package:flutter/material.dart';

class Diary extends StatelessWidget {
  const Diary({super.key});

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.filter_list_outlined,
                          color: Colors.white,
                        ),
                        Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Только не выполненные'),
                        )),
                      ],
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today, color: Colors.green,))
                  ],
                ),
                Text('21/03',
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
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Здоровье'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.alarm),
                                      Text('  9.00')
                                    ],
                                  )
                                ],
                              ),
                              Checkbox(value: false, onChanged: (v) {}),
                            ],
                          ),
                          tileColor: Colors.white,
                          onTap: () {})),
                ),
                Text('23/03',
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
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Здоровье'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.alarm),
                                      Text('  9.00')
                                    ],
                                  )
                                ],
                              ),
                              Checkbox(value: false, onChanged: (v) {}),
                            ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Здоровье'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.alarm),
                                      Text('  9.00')
                                    ],
                                  )
                                ],
                              ),
                              Checkbox(value: false, onChanged: (v) {}),
                            ],
                          ),
                          tileColor: Colors.white,
                          onTap: () {})),
                ),
              ]),
            ),
          ))
        ],
      ),
    );
  }
}