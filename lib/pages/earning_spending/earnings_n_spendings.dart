import 'package:flutter/material.dart';
import 'package:i_am_app/pages/earning_spending/free_table.dart';
import 'package:i_am_app/pages/earning_spending/plan.dart';

class Earnings_N_Spendings extends StatefulWidget {
  const Earnings_N_Spendings({super.key});

  @override
  State<Earnings_N_Spendings> createState() => _Earnings_N_SpendingsState();
}

class _Earnings_N_SpendingsState extends State<Earnings_N_Spendings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                  child: Column(
                children: [
                  Container(
                    child: const Center(
                        child: Text(
                      "Цель месяца по доходам",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: const Text(
                              "300 000 руб/месяц",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                            tileColor: Colors.white,
                            onTap: () {})),
                  )),
                  Container(
                    child: const Center(
                        child: Text(
                      "Цель месяца по доходам",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: const Text(
                              "300 000 руб/месяц",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                            tileColor: Colors.white,
                            onTap: () {})),
                  )),
                  Container(
                    child: const Center(
                        child: Text(
                      "Цель месяца по доходам",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: const Text(
                              "300 000 руб/месяц",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                            tileColor: Colors.white,
                            onTap: () {})),
                  )),
                ],
              )),
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
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        child: InkWell(
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              title: const Text(
                                "Сводная Таблица",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const FreeTable()));
                              }),
                        )),
                    const SizedBox(height: 10),
                    Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        child: InkWell(
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              title: const Text(
                                "Планирование",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Plan(),
                                  ),
                                );
                              }),
                        )),
                    const SizedBox(height: 30),
                  ],
                ))
          ],
        ));
  }
}
