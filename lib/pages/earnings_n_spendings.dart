import 'package:flutter/material.dart';
import 'planning.dart';

class Earnings_N_Spendings extends StatefulWidget {
  const Earnings_N_Spendings({super.key});

  @override
  State<Earnings_N_Spendings> createState() => _Earnings_N_SpendingsState();
}

class _Earnings_N_SpendingsState extends State<Earnings_N_Spendings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                children: [
                  Container(
                    child: Center(child: Text("Цель месяца по доходам", style: TextStyle(fontSize: 18, color: Colors.white),)),
                  ),
                  Container(
                    child: Padding(padding: EdgeInsets.all(20), child: Card(child: ListTile(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0)),title: Text("300 000 руб/месяц", textAlign: TextAlign.center,),tileColor: Colors.white,onTap: () {})),)
                  ),
                  Container(
                    child: Center(child: Text("Цель месяца по доходам", style: TextStyle(fontSize: 18, color: Colors.white),)),
                  ),
                  Container(
                    child: Padding(padding: EdgeInsets.all(20), child: Card(child: ListTile(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0)),title: Text("300 000 руб/месяц", textAlign: TextAlign.center,),tileColor: Colors.white,onTap: () {})),)
                  ),
                  Container(
                    child: Center(child: Text("Цель месяца по доходам", style: TextStyle(fontSize: 18, color: Colors.white),)),
                  ),
                  Container(
                    child: Padding(padding: EdgeInsets.all(20), child: Card(child: ListTile(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0)),title: Text("300 000 руб/месяц", textAlign: TextAlign.center,),tileColor: Colors.white,onTap: () {})),)
                  ),
                ],
              )
            ),
          ),
          
          // Container(
          //   child: Center(child: Text("Расходы", style: TextStyle(fontSize: 18, color: Colors.white),)),
          // ),
          // Container(
          //   child: Padding(padding: EdgeInsets.all(20), child: Card(child: ListTile(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0)),title: Text("300 000 руб/месяц", textAlign: TextAlign.center,),tileColor: Colors.white,onTap: () {})),)
          // ),
          // Container(
          //   child: Center(child: Text("До фин. независимости осталось: ", style: TextStyle(fontSize: 18, color: Colors.white),)),
          // ),
          // Container(
          //   child: Padding(padding: EdgeInsets.all(20), child: Card(child: ListTile(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0)),title: Text("300 000 руб/месяц", textAlign: TextAlign.center,),tileColor: Colors.white,onTap: () {})),)
          // ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                  child: InkWell(child: ListTile(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0)),title: Text("Сводная Таблица", textAlign: TextAlign.center,),onTap: () {}),)
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                  child: InkWell(child: ListTile(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0)),title: Text("Планирование", textAlign: TextAlign.center,),onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Planning(),
                          ),
                      );
                  }),)
                ),
                SizedBox(height: 30),

              ],
            )
          )

        ],
      )
    );
  }
}