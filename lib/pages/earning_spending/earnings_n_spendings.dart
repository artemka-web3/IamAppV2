import 'package:flutter/material.dart';
import 'package:i_am_app/pages/earning_spending/free_table.dart';
import 'package:i_am_app/pages/earning_spending/plan.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String parseNumber(String number) {
  String formatted = '';

  for (int i = 0; i < number.length; i++) {
    formatted += number[i];

    if ((number.length - i - 1) % 3 == 0 && i != number.length - 1) {
      formatted += ' ';
    }
  }

  return formatted;
}

class Earnings_N_Spendings extends StatefulWidget {
  TextEditingController income = TextEditingController();
  TextEditingController expenses = TextEditingController();
  TextEditingController independence = TextEditingController();

  Earnings_N_Spendings({super.key});

  @override
  State<Earnings_N_Spendings> createState() => _Earnings_N_SpendingsState();
}

class _Earnings_N_SpendingsState extends State<Earnings_N_Spendings> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (snapshot.data!.getString('income') != null) {
            widget.income.text = snapshot.data!.getString('income')!;
          }
          if (snapshot.data!.getString('expenses') != null) {
            widget.expenses.text = snapshot.data!.getString('expenses')!;
          }
          if (snapshot.data!.getString('independence') != null) {
            widget.independence.text =
                snapshot.data!.getString('independence')!;
          }
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
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white),
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Вввести",
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              controller: widget.income,
                              onChanged: (val) async {
                                if (widget.income.text.length == 0) {
                                  await snapshot.data
                                      ?.setString('income', widget.income.text);
                                  return;
                                }
                                var formatter = NumberFormat('#,###');
                                widget.income.text =
                                    '${formatter.format(int.tryParse(widget.income.text.replaceAll(' ', '')))}'
                                        .replaceAll(',', ' ');
                                widget.income.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: widget.income.text.length));
                                await snapshot.data
                                    ?.setString('income', widget.income.text);
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: const Center(
                              child: Text(
                            "Расходы",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white),
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Выбрать",
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              controller: widget.expenses,
                              onChanged: (val) async {
                                if (widget.expenses.text.length == 0) {
                                  await snapshot.data?.setString(
                                      'income', widget.expenses.text);
                                  return;
                                }
                                var formatter = NumberFormat('#,###');
                                widget.expenses.text =
                                    '${formatter.format(int.tryParse(widget.expenses.text.replaceAll(' ', '')))}'
                                        .replaceAll(',', ' ');
                                widget.expenses.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: widget.expenses.text.length));
                                await snapshot.data
                                    ?.setString('income', widget.expenses.text);
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: const Center(
                              child: Text(
                            "До финансовой \nнезависимости осталось",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white),
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Выбрать",
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              controller: widget.independence,
                              onChanged: (val) async {
                                if (widget.independence.text.length == 0) {
                                  await snapshot.data?.setString(
                                      'income', widget.independence.text);
                                  return;
                                }
                                var formatter = NumberFormat('#,###');
                                widget.independence.text =
                                    '${formatter.format(int.tryParse(widget.independence.text.replaceAll(' ', '')))}'
                                        .replaceAll(',', ' ');
                                widget.independence.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            widget.independence.text.length));
                                await snapshot.data?.setString(
                                    'income', widget.independence.text);
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: const Center(
                              child: Text(
                            "пассивного дохода",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                      builder: (context) => const Plan(),
                                    ),
                                  );
                                }),
                          )),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
