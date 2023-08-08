import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/user.dart';
import 'package:i_am_app/classes/page_index.dart';
import 'package:i_am_app/pages/auth/logic/authentication_repository.dart';
import 'package:i_am_app/pages/auth/logic/bloc/auth_bloc.dart';
import 'package:i_am_app/pages/auth/logic/log_in.dart';
import 'package:i_am_app/pages/auth/sign_in.dart';
import 'package:i_am_app/pages/bloc/bloc/user_bloc.dart';
import 'package:i_am_app/pages/settings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'classes/services/firebase_realtime_service.dart';
import 'classes/services/notification_service.dart';
import 'pages/home.dart';
import 'pages/goals/goals.dart';
import 'pages/diary/diary.dart';
import 'pages/index_of_life.dart';
import 'pages/helpful_info.dart';
import 'pages/earning_spending/earnings_n_spendings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'iamapp',
  );
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
  FirebaseDatabaseService service = FirebaseDatabaseService();
  SharedPreferences pref = await SharedPreferences.getInstance();
  await NotificationService().initializationNotifications();

  DateTime time = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute + 1,
    0,
    0,
    0,
  );

  Widget home;
  // pref.remove('entered');
  // pref.remove('phone');
  if (pref.getBool('entered') != true && pref.getString('pin') == null) {
    home = SignIn();
  } else {
    home = LogIn();
  }
  await Future.delayed(const Duration(milliseconds: 240));
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(
            phoneAuthRepository: PhoneAuthRepository(),
          ),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Inter',
          hintColor: const Color.fromARGB(75, 37, 46, 41),
          primaryColor: const Color(0xFF252E29),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF252E29),
          ),
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 22.0,
            ),
            titleSmall: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
            bodyMedium: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            bodySmall: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        home: home,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final int pageIndex;
  final String? phone;
  const MyApp({super.key, required this.pageIndex, this.phone});

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
    (context) => AppBar(
          title: Text('Мои цели'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Settings(),
                ));
              },
              icon: Icon(Icons.settings_outlined),
            )
          ],
        ),
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
            resizeToAvoidBottomInset: false,
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
