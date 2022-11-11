import 'package:flutter/material.dart';
import '/arama.dart';
import 'local_notification_service.dart';
import 'package:intl/intl.dart';

class anasayfa extends StatefulWidget {
  const anasayfa({Key? key}) : super(key: key);

  @override
  _anasayfaState createState() => _anasayfaState();
}

final TextEditingController text = TextEditingController();

List burcyorum = [];
Map burclar = {};
String version = "";

String dil = "tr";
String dosya = "";

DateTime now = DateTime.now();
String baslik = DateFormat('dd / MM / yyyy').format(now);

class _anasayfaState extends State<anasayfa>
    with SingleTickerProviderStateMixin {
  late final LocalNotificationService service;

  bildirim() async {
    await service.showScheduledNotification(
      id: 1000,
      title: 'Tabircim',
      body: 'Rüyanı yorumlayalım ister misin?',
      date: DateTime.now().add(const Duration(seconds: 10)),
    );

    for (int i = 1; i < 16; i++) {
      var tarih = DateTime.now();
      var gun = tarih.day.toString();
      var ay = tarih.month.toString();
      var yil = tarih.year.toString();
      if (tarih.day < 10) {
        gun = '0$gun';
      }
      if (tarih.month < 10) {
        ay = '0$ay';
      }

      DateTime datem =
          DateTime.parse('$yil-$ay-$gun 10:00:04Z').add(Duration(days: i));

      await service.showScheduledNotification(
        id: int.parse(datem.year.toString() +
            datem.month.toString() +
            datem.day.toString()),
        title: 'Tabircim',
        body: 'Rüyanı yorumlayalım ister misin?',
        date: datem,
      );
    }
  }

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();

    bildirim();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/home1.png', fit: BoxFit.cover)),
            Container(
              alignment: Alignment.center,
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 0.0, top: 100.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 5.0, top: 5.0, bottom: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: TextField(
                        controller: text,
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20.0,
                          color: Colors.black,
                        ),

                        onSubmitted: (_) {
                          String chattext = text.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => arama(
                                ara: chattext,
                              ),
                            ),
                          );
                        }, // submit and hide keyboard

                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: CircleAvatar(
                            backgroundColor: const Color(0xff204c7d),
                            child: IconButton(
                                icon: const Icon(Icons.search),
                                color: Colors.white,
                                onPressed: () {
                                  String chattext = text.text;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => arama(
                                        ara: chattext,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          hintText: 'Rüya Ara',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
