import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
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
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              widget.income.text =
                  'Заполните значения для этого месяца в\n Планировании';
              widget.expenses.text =
                  'Заполните значения для этого месяца в\n Планировании';
              widget.independence.text =
                  'Заполните значения для этого месяца в\n Планировании';
              for (var element in state.user.month) {
                if (element.date.month == DateTime.now().month &&
                    element.date.year == DateTime.now().year) {
                  widget.income.text = element.income.toString();
                  widget.expenses.text =
                      ((int.tryParse(element.varCosts.toString()) ?? 0) +
                              (int.tryParse(element.fixedCosts.toString()) ??
                                  0))
                          .toString();

                  widget.independence.text =
                      ((int.tryParse(element.fixedCosts ?? '0') ?? 0) +
                              (int.tryParse(element.varCosts ?? '0') ?? 0) -
                              (int.tryParse(element.passiveIncome ?? '0') ?? 0))
                          .toString();
                }
              }
              var formatter = NumberFormat('#,###');
              if (widget.income.text !=
                  'Заполните значения для этого месяца в\n Планировании') {
                widget.income.text =
                    '${formatter.format(int.tryParse(widget.income.text.replaceAll(' ', '')))}'
                        .replaceAll(',', ' ');
                widget.expenses.text =
                    '${formatter.format(int.tryParse(widget.expenses.text.replaceAll(' ', '')))}'
                        .replaceAll(',', ' ');
                widget.independence.text =
                    '${formatter.format(int.tryParse(widget.income.text.replaceAll(' ', '')))}'
                        .replaceAll(',', ' ');
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
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white),
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  widget.income.text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              child: const Center(
                                child: Text(
                                  "Расходы",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white),
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  widget.expenses.text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const Center(
                                child: Text(
                              "До финансовой независимости осталось",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                            Container(
                              margin: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white),
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  widget.independence.text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              child: const Center(
                                  child: Text(
                                "пассивного дохода",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
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
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    title: const Text(
                                      "Сводная Таблица",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16.0),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FreeTable()));
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
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
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
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
