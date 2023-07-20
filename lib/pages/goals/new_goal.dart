import 'package:flutter/material.dart';

class NewGoal extends StatefulWidget {
  const NewGoal({super.key});

  @override
  State<NewGoal> createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          SizedBox(
            width: 24.0,
          )
        ],
        title: const Center(
          child: Text(
            "Новая цель",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 2 * AppBar().preferredSize.height,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.0))),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Введите название...",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(75, 37, 46, 41),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.calendar_month),
                      Text(
                        "Январь 2023",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Row(
                    children: [
                      Text(
                        "Сфера:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Выбрать",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(75, 37, 46, 41),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 24 + 64,
                    child: TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Описание...",
                        hintStyle: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(75, 37, 46, 41),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    111,
                    207,
                    151,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Сохранить",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
