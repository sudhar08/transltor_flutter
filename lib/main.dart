import 'package:flutter/material.dart';
import 'package:nlp_college/screens/camera.dart';
import 'package:nlp_college/screens/first.dart';
import 'package:nlp_college/screens/speech.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Translator"),
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.text_fields)),
                  Tab(icon: Icon(Icons.mic)),
                  Tab(
                    icon: Icon(Icons.photo_camera),
                  )
                ],
                indicatorColor: Colors.black,
                indicatorWeight: 3.5,
                splashBorderRadius: BorderRadius.circular(17),
              ),
              backgroundColor: Colors.teal,
              foregroundColor: Colors.black,
            ),
            body: TabBarView(
              children: [
                //text to text.......................
                First(),

                //speech.............................
                speech(),

                //photo view.........................
                camera()
              ],
            ),
          ),
        ));
  }
}
