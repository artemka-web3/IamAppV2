import 'package:flutter/material.dart';
import 'package:i_am_app/main.dart';
import 'package:i_am_app/pages/auth/birth_meaning.dart';
import 'package:i_am_app/pages/auth/password_recovery.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 23.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              const Spacer(
                flex: 2,
              ),
              const Text(
                "Добрый день!",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              const Text(
                "Войти:",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Телефон",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "+7(***)-***-**-**",
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(50, 37, 46, 41),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Пароль",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "********",
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(50, 37, 46, 41),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BirthMeaning(),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(255, 111, 207, 151),
                  ),
                  child: const Center(
                    child: Text(
                      "Войти",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PasswordRecovery(),
                  ),
                ),
                child: const Text(
                  "Забыли пароль?",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(
                flex: 4,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Нет профиля?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Зарегистрироваться",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
