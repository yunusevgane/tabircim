import '/detay.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' as rootBundle;

class arama extends StatefulWidget {
  String ara;

  arama({Key? key, required this.ara}) : super(key: key);

  @override
  _aramaState createState() => _aramaState();
}

class jsonsMap {
  String? ruya;
  String? aciklama;
  jsonsMap({this.ruya, this.aciklama});
  jsonsMap.fromJson(Map<String, dynamic> json) {
    ruya = json['ruya'];
    aciklama = json['aciklama'];
  }
}

class _aramaState extends State<arama> {
  final TextEditingController text = TextEditingController();
  String aradetay = "";

  List ruya = [];

  @override
  Widget build(BuildContext context) {
    text.text = widget.ara;
    aradetay = widget.ara;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0xff060831),
      ),
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
              margin: const EdgeInsets.only(top: 5),
              alignment: Alignment.topCenter,
              child: aramainput(context),
            ),
            if (aradetay.length > 1)
              Container(
                margin: const EdgeInsets.only(
                    bottom: 0, top: 80, left: 0, right: 0),
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: ReadJsonData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return bulunamadi();
                    } else if (data.hasData) {
                      var items = data.data as List<jsonsMap>;
                      int sayi = items == null ? 0 : items.length;
                      if (sayi == 0) {
                        return bulunamadi();
                      } else {
                        return ListView.builder(
                            itemCount: items == null ? 0 : items.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 0, bottom: 0, left: 30, right: 30),
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      color: const Color(0xff204c7d),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => detay(
                                                  ara: items[index]
                                                      .ruya
                                                      .toString(),
                                                  detays: items[index]
                                                      .aciklama
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                                items[index].ruya.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                          )),
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            if (aradetay.isEmpty)
              Container(
                margin: const EdgeInsets.only(
                    bottom: 100, top: 100, left: 20, right: 20),
                alignment: Alignment.center,
                child: bulunamadi(),
              ),
          ],
        ),
      ),
    );
  }

  bulunamadi() {
    return Center(
        child: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff204c7d),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Rüya Bulunamadı.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Ençok aranan rüyalar.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: <Widget>[
                chip("Aslan"),
                chip("Balık"),
                chip("Kar"),
                chip("Deniz"),
                chip("Ceviz"),
                chip("Yılan"),
                chip("Köpek"),
                chip("Ağlamak"),
                chip("Fare"),
                chip("Kedi"),
                chip("Altın"),
                chip("Hamile"),
              ],
            )
          ],
        ),
      ),
    ));
  }

  ActionChip chip(adi) {
    return ActionChip(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        label: Text(adi),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => arama(
                ara: adi,
              ),
            ),
          );
        });
  }

  Container aramainput(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: Container(
          padding: const EdgeInsets.only(
              left: 0.0, right: 5.0, top: 5.0, bottom: 5.0),
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
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              hintStyle: const TextStyle(fontSize: 20.0, color: Colors.grey),
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
    );
  }

  Future<List<jsonsMap>> ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('assets/ruya.json');
    var list = json.decode(jsondata) as List<dynamic>;

    list = list
        .where((arayici) =>
            arayici["ruya"].toLowerCase().contains(aradetay.toLowerCase()))
        .toList();

    return list.map((i) => jsonsMap.fromJson(i)).toList();
  }
}

// SingleChildScrollView
