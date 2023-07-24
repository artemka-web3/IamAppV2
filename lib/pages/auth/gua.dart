import 'package:flutter/material.dart';

class Gua extends StatelessWidget {
  const Gua({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Text(
                    "Значение числа ГУА",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/gua.png"),
                        fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const CustomRichText(
                  title: 'Гуа: ',
                  value: '9',
                ),
                const CustomRichText(
                  title: 'Группа: ',
                  value: 'Восточная',
                ),
                const CustomRichText(
                  title: 'Триграмма: ',
                  value: '離 Ли',
                ),
                const CustomRichText(
                  title: 'Стихия: ',
                  value: 'Огонь',
                ),
                const CustomRichText(
                  title: 'Цвет: ',
                  value: 'Красный, зеленый.',
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Основные качества: импульсивность, вспыльчивость, эмоциональность, жизнерадостность, коммуникабельность, гордость, тщеславие, прозорливость, утонченность, экстравагантность, яркость, изменчивость, самодостаточность.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Энергетика",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Об энергетике личности Гуа 9 свидетельствует триграмма числа: одна прерывистая линия, окруженная с обеих сторон двумя сплошными. Это говорит о преобладании сильной энергии Ян, активность и энергичность которой скрывают внутри, в глубине мягкость и податливость. Так же и человек с числом Гуа 9 создает впечатление сильного, упрямого, непреклонного и порой даже жесткого человека, однако его внутренняя природа чувствительна, эмоциональна и нежна. Настолько, что найдя источник вдохновения и опоры, может попасть в зависимость и стать управляемым и покорным — как росток, черпая силы из почвы и не представляя для себя существования без нее.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  " Люди Гуа 9 довольно противоречивы: имея склонность к одиночеству, они при этом общительные и яркие, любят внимание и не остаются незамеченными благодаря умению подать себя, сочетающемуся с хорошим вкусом, обаянию и чувству юмора. Им нравится, когда их любят и восхищаются ими. Подобно своей стихии — огню, они способны вдохновлять окружающих и вести за собой, убеждать и влиять на аудиторию, даже самую скучную информацию преподнося ярко и интересно. Они прирожденные ораторы. Кроме того, они прекрасно видят суть явлений и вещей, обладая огромной силой осознания. Это позволяет им так же ясно видеть и свое предназначение, цели и стремления.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Целеустремлённость",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "А вот с достижением целей у людей числа Гуа 9 не все гладко. Будучи импульсивными и легко увлекающимися, они с энтузиазмом берутся за воплощение в жизнь новой интересной идеи, коих у них всегда много, но могут бросить начатое на полпути, встретив трудности или увлекшись на их взгляд более актуально и интересной целью. Им вообще трудно адекватно оценивать свои возможности, поэтому зачастую их стремления не соответствуют реальности, а увлечения очень часто меняются. Тем не менее они умны и неординарны, однако склонны к критицизму всего и вся, и не умеют признавать свои ошибки.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Финансы",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "В финансовых вопросах они честны и не склонны к аферам, однако копить деньги не умеют. Имея хороший вкус, они любят все красивое и дорогое, поэтому часто живут не по средствам, проживая весь свой доход сразу. В связи с этим они постоянно стремятся уравновесить свои расходы и доходы. Кроме того, им рекомендуется избегать азартных игр, учитывая их склонность к импульсивности и расточительности.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Эмоции",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Утонченные и эктравагантные натуры, они в основном создают впечатление счастливчиков, у которых всегда все хорошо и успешно. Однако на самом деле за их жизнерадостностью, шармом и чувством юмора, которые они никогда не теряют, могут скрываться переживания, потеря интереса к жизни и даже депрессия. Одним из главных факторов их хорошего самочувствия и эмоционального здоровья является внутреннее душевное равновесие, в том числе и эмоциональный баланс, и сострадание к окружающим. Это поможет и избежать серьезных расстройств нервной системы, которая является одним из их слабых мест, в том числе бессонницы и неврастении.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Помимо этого им следует в первую очередь прислушиваться к себе, защищать и отстаивать себя и свои интересы и не идти на поводу у других, иначе они могут попасть под дурное влияние и уйти со своего пути. Также им нужно следить за здоровьем репродуктивной системы и уделять внимание физическому развитию. Имея в основном среднее телосложение, им не помешают физические нагрузки.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Отношения",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "В отношениях они не всегда серьезны, предпочитая поддерживать с партнерами поверхностные отношения. Хотя при этом влюбчивы и вообще проявляют интерес к противоположному полу с раннего возраста. В интимном плане имеют склонность к любовным фантазиям и их осуществлению. Обладая внутренним светом, склонностью к эзотерике и даже даром ясновидения, а также даром доносить до людей информацию, людям числа Гуа 9, можно сказать, предначертано нести в массы духовные знания о мир, бытие и сути вещей. Своим внутренним сиянием они способны одухотворять все, к чему прикасаются. Им следует учиться быть сильными духом, укреплять внутренний стержень и обращать свои слабости в силу, Во второй части статьи мы узнаем о направлениях, которые согласно энергетической характеристике, заложенной при рождении, благоприятны и не благоприятны для человека, числом Гуа которого является 9.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
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
                        "Далее",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  final String title;
  final String value;

  const CustomRichText({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: value,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
