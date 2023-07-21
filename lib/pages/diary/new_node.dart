import 'package:flutter/material.dart';

class NewNode extends StatelessWidget {
  const NewNode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Дела на день',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        actions: const [
          SizedBox(
            width: 40.0,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 24.0,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    color: Colors.white,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Четверг 23/03",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Node(
                icon: Icon(
                  Icons.pets,
                  color: Colors.white,
                ),
                title: 'Лягушка дня',
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Node(
                icon: Icon(
                  Icons.cake_outlined,
                  color: Colors.white,
                ),
                title: 'Дни рождения и праздники',
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Node(
                icon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                title: 'Встречи и звонки',
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Node(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                title: 'Задачи',
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Node(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                title: 'Успехи дня',
              ),
              const SizedBox(
                height: 16.0,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    color: Color.fromARGB(255, 111, 207, 151),
                  ),
                  child: Center(
                    child: Text(
                      "Сохранить",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Node extends StatelessWidget {
  final Icon icon;
  final String title;
  final Icon? info;

  const Node({super.key, required this.icon, required this.title, this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon,
            const SizedBox(
              width: 16.0,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              width: 16.0,
            ),
            info ?? const SizedBox(),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            color: Colors.white,
          ),
          child: TextFormField(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: InputBorder.none,
                hintText: "Новая запись..."),
          ),
        ),
      ],
    );
  }
}
