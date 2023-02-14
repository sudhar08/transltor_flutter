import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class camera extends StatefulWidget {
  const camera({super.key});

  @override
  State<camera> createState() => _cameraState();
}

class _cameraState extends State<camera> {
  //translator methods are here...........
  String dropdownvalue = 'ta';
  File? imagefile;
  var text;
  var trans;
  TextEditingController mycontrol = TextEditingController();

  GoogleTranslator translator = GoogleTranslator();
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
  final growablelist = [];
  Future readtext() async {
    growablelist.clear();
    FirebaseVisionImage ourimage = FirebaseVisionImage.fromFile(imagefile!);
    TextRecognizer recognizertext = FirebaseVision.instance.textRecognizer();
    VisionText readtext = await recognizertext.processImage(ourimage);

    for (TextBlock block in readtext.blocks) {
      for (TextLine line in block.lines) {
        setState(() {
          text = line.text;
          translator
              .translate(text.toString(), to: '$dropdownvalue')
              .then((value) {
            setState(() {
              growablelist.add(value);
            });
          });
        });
      }
    }
  }

//translator methods...............

//image storage methods.............

  void getimage({required ImageSource source}) async {
    final file =
        await ImagePicker().pickImage(source: source, imageQuality: 100);
    if (file?.path != null) {
      setState(() {
        imagefile = File(file!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Column(
              children: [
                if (imagefile != null)
                  Container(
                    margin: EdgeInsets.only(right: 40, left: 60, top: 8),
                    width: 280,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: FileImage(imagefile!), fit: BoxFit.contain),
                    ),
                  )
                else
                  Container(),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final action = CupertinoActionSheet(
                          title: Text("Upload A Image"),
                          message: Text("Select Anyone"),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () {
                                getimage(source: ImageSource.camera);
                              },
                              isDefaultAction: true,
                              child: Text("Camera"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                getimage(source: ImageSource.gallery);
                              },
                              isDefaultAction: true,
                              child: Text("Gallery"),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: const Text("cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                        showCupertinoModalPopup(
                            context: context, builder: (context) => action);
                      },
                      child: Text(
                        "Upload a Image",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), backgroundColor: Colors.blue),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(55)),
                      child: Container(
                        width: 130,
                        height: 50,
                        //color: Colors.grey,
                        child: Center(
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
                            //isExpanded: true,
                            iconSize: 25.0,
                            underline: Container(
                              color: Colors.transparent,
                            ),
                            iconEnabledColor: Colors.teal,
                            onChanged: (newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    child: Text("Tanslate.."),
                    onPressed: () {
                      readtext();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    child: Text(
                  growablelist == null ? "  " : growablelist.toString(),
                  maxLines: 100,
                )),
              ],
            ))));
  }
}
