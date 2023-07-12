import 'package:flutter/material.dart';
import 'package:i_am_app/pages/faq.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Container(
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
                  Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Text('Код-пароль и Face-ID'),
                          tileColor: Colors.white,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AuthSettings()));
                          })),
                  Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Допуск уведомлений'),
                              Switch(value: false, onChanged: (bool v) {})
                            ],
                          ),
                          tileColor: Colors.white,
                          onTap: () {})),
                  Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: Text('Напоминать про индекс жизни раз в месяц')),
                              Switch(value: false, onChanged: (bool v) {})
                            ],
                          ),
                          tileColor: Colors.white,
                          onTap: () {})),
                  Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Text('FAQ'),
                          tileColor: Colors.white,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FAQPage()));
                          })),
                  Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Text('Связаться с нами'),
                          tileColor: Colors.white,
                          onTap: () {})),
                  Card(
                      child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    title: Text('Удаление аккаунта'),
                    tileColor: Colors.white,
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Удаление аккаунта'),
                        content: const Text(
                            'Вы действительно хотите удалить аккаунт? Все данные будут стёрты'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Оставить'),
                            child: const Text('Оставить'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Удалить'),
                            child: const Text(
                              'Удалить',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                ]),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class AuthSettings extends StatelessWidget {
  const AuthSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FAQ')),
      body: Container(
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
                  Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Text('Задать код-пароль'),
                          tileColor: Colors.white,
                          onTap: () {})),
                  Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Вход по Face-ID'),
                              Switch(value: false, onChanged: (value) {})
                            ],
                          ),
                          tileColor: Colors.white,
                          onTap: () {}))
                ]),
              ),
            ))
          ],
        ),
      ),
    );
  }
}