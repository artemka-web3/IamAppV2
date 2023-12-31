import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/pages/auth/logic/bloc/auth_bloc.dart' as authbloc;
import 'package:i_am_app/pages/auth/sign_in.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:i_am_app/pages/faq.dart';
import 'package:i_am_app/pages/set_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  bool switchNotify = false;
  bool indexNotify = false;

  Settings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: StatefulBuilder(builder: (context, setState) {
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
                    Card(
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: Text(
                              'Код-пароль и Face-ID',
                              style: TextStyle(color: Colors.black),
                            ),
                            tileColor: Colors.white,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AuthSettings()));
                            })),
                    Card(
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Допуск уведомлений',
                                    style: TextStyle(color: Colors.black)),
                                Switch(
                                  value: switchNotify,
                                  onChanged: (bool v) =>
                                      setState(() => switchNotify = v),
                                ),
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
                                Flexible(
                                    child: Text(
                                        'Напоминать про индекс жизни раз в месяц',
                                        style: TextStyle(color: Colors.black))),
                                Switch(
                                    value: indexNotify,
                                    onChanged: (bool v) => setState(
                                          () => indexNotify = v,
                                        ))
                              ],
                            ),
                            tileColor: Colors.white,
                            onTap: () {})),
                    Card(
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: Text('FAQ',
                                style: TextStyle(color: Colors.black)),
                            tileColor: Colors.white,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FAQPage()));
                            })),
                    Card(
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: Text('Связаться с нами',
                                style: TextStyle(color: Colors.black)),
                            tileColor: Colors.white,
                            onTap: () {})),
                    Card(
                        child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      title: Text('Удаление аккаунта',
                          style: TextStyle(color: Colors.black)),
                      tileColor: Colors.white,
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Удаление аккаунта',
                              style: TextStyle(color: Colors.black)),
                          content: const Text(
                              'Вы действительно хотите удалить аккаунт? Все данные будут стёрты',
                              style: TextStyle(color: Colors.black)),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Оставить'),
                              child: const Text('Оставить',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            TextButton(
                              onPressed: () async {
                                context.read<UserBloc>().add(DeleteAcc(
                                    phone: context
                                        .read<UserBloc>()
                                        .state
                                        .user
                                        .phone));
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignIn(),
                                    ),
                                    (route) => false);
                              },
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
        );
      }),
    );
  }
}

class AuthSettings extends StatelessWidget {
  const AuthSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Настройки')),
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
                          title: Text('Задать код-пароль',
                              style: TextStyle(color: Colors.black)),
                          tileColor: Colors.white,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => SetPassword()));
                          })),
                  Card(
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Вход по Face-ID',
                                  style: TextStyle(color: Colors.black)),
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
