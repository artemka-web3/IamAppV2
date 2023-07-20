import 'package:flutter/material.dart';
import 'package:i_am_app/classes/page_index.dart';
import 'package:i_am_app/pages/auth/sign_up.dart';
import 'package:i_am_app/pages/earning_spending/free_table.dart';
import 'package:i_am_app/pages/settings.dart';
import 'package:provider/provider.dart';
import 'pages/home.dart';
import 'pages/goals.dart';
import 'pages/diary.dart';
import 'pages/index_of_life.dart';
import 'pages/helpful_info.dart';
import 'pages/earning_spending/earnings_n_spendings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Inter',
          primaryColor: const Color(0xFF252E29),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF252E29))),
      home: const SignUp()));
}

class MyApp extends StatefulWidget {
  final int pageIndex;
  const MyApp({super.key, required this.pageIndex});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pageOptions = [
    Home(),
    Goals(),
    Diary(),
    LifeIndex(),
    Earnings_N_Spendings(),
    HelpfulInfo(),
  ];
  final _appBars = [
    (context) => AppBar(title: Text('Главная'), actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Settings(),
              ));
            },
            icon: Icon(Icons.settings_outlined),
          )
        ]),
    (context) => AppBar(title: Text('Мои цели'), actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Settings(),
              ));
            },
            icon: Icon(Icons.settings_outlined),
          )
        ]),
    (context) => AppBar(title: Text('Ежедневник'), actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Settings(),
              ));
            },
            icon: Icon(Icons.settings_outlined),
          )
        ]),
    (context) => AppBar(title: Text('Индекс Жизни'), actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Settings(),
              ));
            },
            icon: Icon(Icons.settings_outlined),
          )
        ]),
    (context) => AppBar(title: Text('Доходы и Расходы'), actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Settings(),
              ));
            },
            icon: Icon(Icons.settings_outlined),
          )
        ]),
    (context) => AppBar(title: Text('Полезная Информация'), actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Settings(),
              ));
            },
            icon: Icon(Icons.settings_outlined),
          )
        ]),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageIndex(),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: _appBars[context.read<PageIndex>().index](context),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Color(0xFF252E29),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Color(0xff6FCF97),
                unselectedItemColor: Colors.white,
                currentIndex: context.read<PageIndex>().index,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.assignment_outlined), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.event_note_outlined), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.diamond_outlined), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.stacked_line_chart_outlined), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bookmarks_outlined), label: ''),
                ],
                onTap: (index) {
                  setState(() {
                    context.read<PageIndex>().changeIndex(index);
                  });
                }),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover)),
              child: IndexedStack(
                  index: context.read<PageIndex>().index,
                  children: _pageOptions),
            ),
          );
        },
      ),
    );
  }
}
