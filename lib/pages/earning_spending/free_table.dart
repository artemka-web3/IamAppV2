import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/plan.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;

Future<void> createExel(List<Plan> plans, bool isYear) async {
  int columnIndex = 2;

  final xls.Workbook workbook = xls.Workbook();

  final xls.Worksheet sheet = workbook.worksheets[0];

  sheet.getRangeByIndex(1, 1).setText((isYear) ? 'Год' : 'Месяц');
  sheet.getRangeByIndex(2, 1).setText("Доходы");
  sheet.getRangeByIndex(3, 1).setText("Постоянные расходы");
  sheet.getRangeByIndex(4, 1).setText("Переменные расходы");
  sheet.getRangeByIndex(5, 1).setText("Д-Р-Р");
  sheet.getRangeByIndex(6, 1).setText("Нарастающим итогом");
  sheet.getRangeByIndex(7, 1).setText("Пассивный доход");

  for (var plan in plans) {
    if (isYear) {
      sheet.getRangeByIndex(1, columnIndex).setText(plan.date.year.toString());
    } else {
      sheet
          .getRangeByIndex(1, columnIndex)
          .setText(DateFormat('MMMM').format(plan.date).toString());
    }
    sheet.getRangeByIndex(2, columnIndex).setText(plan.income);
    sheet.getRangeByIndex(3, columnIndex).setText(plan.fixedCosts ?? "-");
    sheet.getRangeByIndex(4, columnIndex).setText(plan.varCosts ?? "-");
    sheet.getRangeByIndex(5, columnIndex).setText(plan.drr ?? "-");
    sheet.getRangeByIndex(6, columnIndex).setText(plan.progressiveTotal ?? "-");
    sheet.getRangeByIndex(7, columnIndex).setText(plan.passiveIncome ?? "-");
    columnIndex++;
  }
  //sheet.getRangeByIndex(rowIndex, columnIndex);

  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  final String path = (await getApplicationSupportDirectory()).path;
  final String fileName = '$path/Output.xlsx';
  final File file = File(fileName);
  await file.writeAsBytes(bytes);
  OpenFile.open(fileName);
}

class FreeTable extends StatefulWidget {
  const FreeTable({super.key});

  @override
  State<FreeTable> createState() => _FreeTableState();
}

class _FreeTableState extends State<FreeTable> {
  List<Plan> data = [];

  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (switchValue) {
          data = state.user.month;
        } else {
          data = state.user.years;
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: const Align(
                  alignment: Alignment.center, child: Text('Таблица')),
              actions: [
                IconButton(
                  onPressed: () async {
                    if (switchValue) {
                      createExel(state.user.month, false);
                    } else {
                      createExel(state.user.years, true);
                    }
                  },
                  icon: const Icon(Icons.download),
                )
              ]),
          body: Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Год",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 80,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Switch(
                              thumbColor:
                                  const MaterialStatePropertyAll(Colors.white),
                              trackColor: const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 111, 207, 151)),
                              value: switchValue,
                              onChanged: (value) {
                                setState(() {
                                  switchValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const Text(
                          "Месяц",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(
                              flex: 2,
                            ),
                            Text(
                              "Доходы",
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            Text(
                              "Постоянные \nрасходы",
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            Text(
                              "Переменные \nрасходы",
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(
                              flex: 10,
                            ),
                            Text(
                              "Д-Р-Р",
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            Text(
                              "Нарастающим \nитогом",
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            Text(
                              "Пассивный \nдоход",
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                          ],
                        ),
                        Flexible(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return CustomColumn(
                                  plan: data[index], isYears: !switchValue);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomColumn extends StatelessWidget {
  final Plan plan;
  final bool isYears;

  const CustomColumn({
    super.key,
    required this.plan,
    required this.isYears,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Center(
            child: Text(
              (isYears)
                  ? plan.date.year.toString()
                  : DateFormat('MMMM').format(plan.date),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 16.0),
            ),
          ),
          Spacer(),
          MoneyContainer(
            text: Text(
              plan.income ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            color: Colors.white,
          ),
          Spacer(),
          MoneyContainer(
            text: Text(
              plan.fixedCosts ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            color: Colors.white,
          ),
          Spacer(),
          MoneyContainer(
            text: Text(
              plan.varCosts ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            color: Colors.white,
          ),
          Spacer(
            flex: 12,
          ),
          MoneyContainer(
            text: Text(
              plan.drr ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            gradient: const LinearGradient(
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 214, 255, 231),
                Color.fromARGB(220, 214, 255, 231),
                Color.fromARGB(255, 35, 85, 56),
              ],
            ),
          ),
          Spacer(),
          MoneyContainer(
            text: Text(
              plan.progressiveTotal ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            gradient: const LinearGradient(
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 214, 255, 231),
                Color.fromARGB(220, 214, 255, 231),
                Color.fromARGB(255, 35, 85, 56),
              ],
            ),
          ),
          Spacer(),
          MoneyContainer(
            text: Text(
              plan.passiveIncome ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            color: const Color.fromARGB(255, 111, 207, 151),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class MoneyContainer extends StatelessWidget {
  final Color? color;
  final Gradient? gradient;
  final Text? text;

  const MoneyContainer({super.key, this.color, this.gradient, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Center(child: text),
    );
  }
}
