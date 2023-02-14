import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  String dropdownvalue = "ta";
  var trans;
  TextEditingController mycontrol = TextEditingController();

  GoogleTranslator translator = GoogleTranslator();
  void convert() {
    translator
        .translate(mycontrol.text.toString(), to: '$dropdownvalue')
        .then((result) {
      setState(() {
        trans = result.toString();
      });
    });
  }

  static const Map<String, String> lang = {
    'ARFIKANNS': 'af',
    'ALBANIAN': 'sq',
    'ARABIC': 'ar',
    'BENGALI': 'bn',
    'BULGARIAN': 'bg',
    'CHINESE': 'zh',
    'DANISH': 'da',
    'DUTCH': 'nl',
    'ENGLISH': 'en',
    'FRENCH': 'fr',
    'FINNISH': 'fi',
    'GEORGIN': 'ka',
    'GERMAN': 'de',
    'GUJARATI': 'gu',
    'HINDI': 'hi',
    'HUNGARIAN': 'hu',
    'INDONEASIA': 'id',
    'ITALIAN': 'it',
    'JAPANESE': 'ja',
    'KANADA': 'kn',
    'KOREAN': 'ko',
    'LATAIN': 'la',
    'MALAYALAM': 'ml',
    'MARATHI': 'mr',
    'MYANMAR': 'my',
    'POLISH': 'pl',
    'PUNJABI': 'pa',
    'RUSSIAN': 'ru',
    'SAMOAN': 'sm',
    'SANSKRIT': 'sa',
    'SERBIAN': 'sr',
    'SLOVENIAN': 'sl',
    'SPANISH': 'es',
    'TAMIL': 'ta',
    'TELUGU': 'te',
    'TURKISH': 'tr',
    'URDU': 'ur',
    'VIETNAMESE': 'vi',
    'WELSH': 'cy',
    'YIDDISH': 'yi',
    'ZULU': 'zu'
  };

  // funcation overflow............

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20, top: 40),
        child: TextFormField(
            style: const TextStyle(fontSize: 20),
            controller: mycontrol,
            maxLength: 50,
            decoration: const InputDecoration(
                labelText: "Type here",
                labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))))),
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 50),
            child: Card(
              margin: EdgeInsets.only(top: 25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(55)),
              //shadowColor: Colors.grey,
              elevation: 4,
              child: Center(
                child: Container(
                    margin: const EdgeInsets.only(
                        right: 30, left: 30, top: 15, bottom: 13),
                    width: 200,
                    height: 50,
                    decoration: const BoxDecoration(
                        //color: Colors.grey,
                        //boxShadow: BoxShadow.lerpList(12, 2, 6)
                        ),
                    //color: Colors.grey,
                    child: DropdownButton(
                      value: dropdownvalue,
                      items: lang
                          .map((string, value) {
                            return MapEntry(
                              string,
                              DropdownMenuItem(
                                  value: value, child: Text(string)),
                            );
                          })
                          .values
                          .toList(growable: false),
                      icon: Icon(Icons.translate_rounded),
                      isExpanded: true,
                      iconSize: 25.0,
                      iconEnabledColor: Colors.teal,
                      underline: Container(color: Colors.transparent),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    )),
              ),
            ),
          ),
        ],
      ),
      Container(
          margin: const EdgeInsets.only(right: 20, left: 20, top: 50),
          child: ElevatedButton(
              style: OutlinedButton.styleFrom(
                  primary: Colors.teal,
                  backgroundColor: Colors.white,
                  // backgroundColor: Color.fromARGB(255, 138, 138, 138),
                  padding: EdgeInsets.all(15),
                  shape: StadiumBorder()),
              onPressed: (() {
                convert();
              }),
              child: Text("Translator"))),
      trans == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                  margin: const EdgeInsets.only(
                      right: 20, left: 20, top: 20, bottom: 0),
                  //color: Colors.grey,
                  child: Text(
                    // ignore: unnecessary_null_comparison
                    trans == null ? " " : trans.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
    ]));
  }
}
