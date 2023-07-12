import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45 < 230
              ? 230
              : MediaQuery.of(context).size.width * 0.45,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Индекс жизни:',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        color: Color(0xFF252D28),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                    ),
                    Text(
                      'Март',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        color: Color(0xFF252D28),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '87.4',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: Color(0xFF252D28),
                            fontSize: 47,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_circle_down,
                        size: 23,
                      ),
                      Text(
                        '2.0',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: Color(0xFF252D28),
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Icon(Icons.question_mark, size: 23)
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.30 < 240
              ? 240
              : MediaQuery.of(context).size.width * 0.30,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  foregroundColor: MaterialStatePropertyAll(Color(0xFF252E29))),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.support, color: Color(0xFF219653),),
                    Text(
                      'Моя характеристика',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        )
      ]),
    );
  }
}