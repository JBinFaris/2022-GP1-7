import 'package:faydh/SignUp_Form.dart';
import 'package:flutter/material.dart';


class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 70, right: 5, left: 5),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const SignupForm();
                  }));
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromARGB(255, 18, 57, 20),
                )),
          )),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.9],
              colors: [Color.fromARGB(142, 26, 77, 46), Color(0xffd6ecd0)]),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              Image.asset(
                'assets/imgs/logo.png',
                width: 150,
                height: 150,
              ),
              const Text(
                "يشكل استخدام هذا التطبيق قبولاً بالشروط والأحكام الواردة فيه، وتحتفظ فيض، بالحق في مراجعة شروط الاستخدام المذكورة في أي وقت، وتلتزم بالإعلان عن أي تعديل أو تغيير في تلك الشروط على تطبيقها.",
                textAlign: TextAlign.right,
              ),
              const Text(
                "شروط الاستخدام: ",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "تطبق قواعد وشروط استخدام تطبيق فيض على جميع زوار ومستخدمي التطبيق. ويجوز إيقاف أو منع أو إنهاء استخدام التطبيق في حال حدوث انتهاك من قبل أحد المستخدمين، أو في حال توفرت أسباب تدعو للاعتقاد بأن أحد المستخدمين قد انتهك وخالف شروط وقواعد الاستخدام.",
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "▪محاولة إجراء اختبار أو مسح أو فحص لإمكانية إصابة نقاط الضعف في النظام أو انتهاك سلامة الإجراءات أو توثيقها دون تصريح رسمي.",
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "▪محاولة التدخل في الخدمة المقدمة لأي مستخدم بما في ذلك على سبيل المثال وليس الحصر، عن طريق وضع فيروس على التطبيق أو زيادة الحمل عليه أو إغراقه بالرسائل الإلكترونية أو تحطيمه.",
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "▪إن مخالفة قواعد الاستخدام وانتهاك النظام أو الشبكة يعرض المخالف للمسؤولية المدنية والجنائية وسيتم مباشرة التحقيق في الحالات التي قد تنطوي على مثل هذه المخالفات والانتهاكات وملاحقة المتسبب فيها قضائياً.",
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "▪إرسال رسائل إلكترونية إلى التطبيق غير مرغوب فيها، بما ذلك عمليات الدعاية، أو الإعلان عن المنتجات أو الخدمات، أو تزييف أي عنوان الكتروني أو جزء من معلومات العنوان في أي رسالة إلكترونية أو إرسال رسائل مجموعات إخبارية.",
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "حقوق الطبع:",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "تعتبر كافة الحقوق بما في ذلك حقوق الطبع وقاعدة البيانات ومحتوياته، مملوكة للتطبيق أو مرخصة باسمها أو مستخدمة من قبلها، وفقاً لما تجيزه القوانين السارية.",
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "حقوق الملكية الفكرية:",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "يقر المستخدم ويوافق على أن كافة المحتويات والمواد المتوفرة والمعروضة في هذا التطبيق تخضع للحماية بواسطة القوانين التي تحكم حقوق الطبع والأسرار التجارية وحقوق الملكية الفكرية الأخرى، فإن المستخدم يوافق على أن لا يبث أو يعرض أو ينفذ أو ينشر أو يعدل أو يحرر أو يُنشئ أية أعمال مشتقة من تلك المواد أو المحتويات.",
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "يجوز للمستخدم أن يطبع أو يحمل نسخة من المواد أو المحتويات في هذا التطبيق، في أي حاسب آلي شخصي لاستخدامه الشخصي أو لاستخدام غير تجاري، وذلك شريطة أن يحافظ على كافة حقوق الطبع وحقوق الملكية الأخرى دون تغيير، ويحظر استرجاع البيانات أو أية محتويات أخرى بطريقة منظمة من هذا التطبيق لإنشاء أو جمع تشكيلة أو مجموعة أو قاعدة بيانات أو دليل بدون إذن خطي. ويحظر استخدام المحتويات أو المواد المنشورة في هذا التطبيق لأي غرض لا يكون مسموحاً به صراحة ضمن الشروط الخاصة بالاستخدام.",
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "إخلاء المسؤولية:",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "لا تتحمل فيض تحت أي ظرف من الظروف مسؤولية أية أضرار مباشرة أو غير مباشرة أو عرضية أو تبعية أو خاصة أو استثنائية تنشأ عن استخدام أو عدم القدرة على استخدام هذا التطبيق. ويطبّق هذا الشرط سواء كانت المسؤولية المدعى بها مسؤولية تعاقدية أو تقصيرية أو مسؤولية ناشئة عن الإهمال أو أي شكل آخر من أشكال المسؤولية القانونية. في حال انقطاع الخدمة نتيجة أسباب قهرية، فإن “فيض” لا تتحمل مسؤولية تلك الأعطال أو أية أضرار متعلقة بها.",
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "القوانين والشرائع السائدة:",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "أي نزاع أو مطالبة تنشأ عن أو فيما يتعلق بهذا التطبيق يجب أن تخضع وتفسر وفقا لقوانين المملكة العربية السعودية.",
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "سياسة التسليم / سياسة الشحن:",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "لا يتم تقديم أو عرض أي منتجات أو مواد مادية في التطبيق وعليه لا توجد أي سياسات تخص التسليم والشحن.",
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 600),
            ],
          ),
        ),
      ),

      // ignore: prefer_const_constructors
    );
  }
}
