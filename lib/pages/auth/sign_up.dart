import 'package:flutter/material.dart';
import 'package:i_am_app/main.dart';
import 'package:i_am_app/pages/auth/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
        child: Expanded(
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
                  "Регистрация:",
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
                  "Введите ваши данные:",
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
                  height: 8.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Повторите пароль:",
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
                  height: 8.0,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
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
                        "Зарегистрироваться!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Уже есть аккаунт?",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Войти",
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
      ),
    );
  }
}