import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';

class speech extends StatefulWidget {
  const speech({super.key});

  @override
  State<speech> createState() => _speechState();
}

class _speechState extends State<speech> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _islistening = false;
  String _text = " press the button to start speaking";
  final String _highlight = "Nlp";

  listen() async {
    if (_islistening == false) {
      bool available =
          await _speech.initialize(onStatus: (v) => {}, onError: (v) => {});
      if (available) {
        setState(() {
          _islistening = true;
        });
        _speech.listen(onResult: (value) {
          _text = value.recognizedWords;
        });
      }
    } else {
      setState(() {
        _islistening = false;
        _text;
      });
    }
  }

  //text translatorrr/..................................
  String dropdownvalue = "ta";
  var trans;

  GoogleTranslator translator = GoogleTranslator();
  void convert() {
    translator.translate(_text, to: '$dropdownvalue').then((result) {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: AvatarGlow(
              animate: _islistening,
              glowColor: Colors.teal,
              endRadius: 75.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: FloatingActionButton(
                onPressed: () {
                  listen();
                },
                elevation: 10,
                child: Icon(Icons.mic),
                backgroundColor: Colors.teal,
              )),
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _text,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Card(
                    margin: EdgeInsets.only(top: 25),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(55)),
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
                        ))),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  child: Text("Translator"),
                  onPressed: () {
                    convert();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), elevation: 8),
                ),
                SizedBox(
                  height: 50,
                ),
                trans == null
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            border: Border.all(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            trans,
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}
