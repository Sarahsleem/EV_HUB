import 'package:evhub/core/theming/colors.dart';
import 'package:flutter/material.dart';

class HelpFaqScreen extends StatelessWidget {
  const HelpFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // لدعم اللغة العربية
      child: Scaffold(
        backgroundColor: ColorsManager.darkBlue,
        appBar: AppBar(
          backgroundColor: ColorsManager.darkBlue,
          title: const Text('🆘 Help & FAQ – مركز المساعدة'),
        ),
        body: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'مرحباً بك في EV Hub!\nنحن هنا لمساعدتك في كل ما يخص استخدام التطبيق وخدمات السيارات الكهربائية.',
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 32, thickness: 2),

            buildQuestion(
              '1. ما هو EV Hub؟',
              'EV Hub هو تطبيق شامل لكل ما يتعلق بالسيارات الكهربائية في مصر والمنطقة العربية. يمكنك من خلاله:\n• شراء أو بيع سيارة كهربائية.\n• الوصول إلى مراكز الشحن.\n• طلب خدمات الصيانة أو التأمين.\n• الحصول على أفضل العروض من الموردين المعتمدين.',
            ),
            //buildSeparator(),

            buildQuestion(
              '2. إزاي أقدر أبيع عربيتي من خلال التطبيق؟',
              '1. سجل دخولك أو أنشئ حساب جديد.\n2. اضغط على “أضف سيارة للبيع”.\n3. املأ بيانات السيارة، وارفع صور واضحة.\n4. فريقنا هيراجع الإعلان وينشره خلال وقت قصير.',
            ),
            //buildSeparator(),

            buildQuestion(
              '3. هل في رسوم على بيع السيارة؟',
              'نشر السيارة للبيع مجاني، لكن في بعض الحالات ممكن نعرض عليك خدمات مدفوعة زي الترويج للإعلان أو الظهور في الصفحة الرئيسية.',
            ),
            //buildSeparator(),

            buildQuestion(
              '4. إزاي أقدر أشتري عربية من خلال التطبيق؟',
              '• تصفح السيارات المعروضة حسب الفئة أو السعر.\n• تواصل مباشرة مع البائع من خلال التطبيق.\n• حدد موعد للمعاينة أو اطلب تقرير فني من شركائنا.',
            ),
            //buildSeparator(),

            buildQuestion(
              '5. فين أماكن الشحن القريبة مني؟',
              'من خلال خريطة الشحن داخل التطبيق، تقدر تشوف أقرب محطات الشحن، حالتها، ونوع الشواحن المتاحة.',
            ),
            //buildSeparator(),

            buildQuestion(
              '6. إزاي أطلب خدمة صيانة أو تأمين؟',
              '• افتح قسم الخدمات.\n• اختار الخدمة المطلوبة (صيانة، تأمين، أفلام حماية…).\n• عبّي النموذج، وسيتم التواصل معك من مزودي الخدمة.',
            ),
           // buildSeparator(),

            buildQuestion(
              '7. هل في ضمان على السيارات أو الخدمات؟',
              'نحن نعرض فقط السيارات من أفراد وموردين موثوقين، لكن ننصح دايماً بمعاينة السيارة والحصول على تقرير فني قبل الشراء. أما بخصوص الخدمات، فيتم تقديمها من شركات معتمدة بضمان رسمي.',
            ),
            //buildSeparator(),

            buildQuestion(
              '8. عندي مشكلة في التطبيق، أعمل إيه؟',
              '• ترسل لنا من خلال صفحة “اتصل بنا”.\n• أو تبعت رسالة على البريد: support@evhubtl.com\n• أو تتواصل معنا عبر الشات داخل التطبيق.',
            ),
            //buildSeparator(),

            const Text(
              '🛠 دعم فني على مدار الساعة\n\nفريق الدعم بتاعنا متاح لمساعدتك يوميًا من الساعة 10 صباحًا حتى 10 مساءً. هنرد عليك في أسرع وقت ممكن.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildQuestion(String title, String answer) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 8),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
          child: Text(answer),
        ),
      ],
    );
  }

  Widget buildSeparator() {
    return const Divider(
      height: 24,
      thickness: 1.5,
      color: Colors.grey,
    );
  }
}
