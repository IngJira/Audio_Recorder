// ignore_for_file: prefer_const_constructors

/*
 * Copyright 2018, 2019, 2020, 2021 Dooboolab.
 *
 * This file is part of Flutter-Sound.
 *
 * Flutter-Sound is free software: you can redistribute it and/or modify
 * it under the terms of the Mozilla Public License version 2 (MPL2.0),
 * as published by the Mozilla organization.
 *
 * Flutter-Sound is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * MPL General Public License for more details.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:final_test/simple_recorder.dart';

/*
    This APP is just a driver to call the various Flutter Sound examples.
    Please refer to the examples/README.md and all the examples located under the examples/lib directory.
*/

void main() {
  runApp(ExamplesApp());
}

///
const int tNotWeb = 1;

///
class Example {
  ///
  final String? title;

  ///
  final String? subTitle;

  ///
  final String? description;

  ///
  final WidgetBuilder? route;

  ///
  final int? flags;

  ///
  /* ctor */ Example(
      {this.title, this.subTitle, this.description, this.flags, this.route});

  ///
  void go(BuildContext context) =>
      Navigator.push(context, MaterialPageRoute<void>(builder: route!));
}

///
final List<Example> exampleTable = [
  // If you update the following test, please update also the Examples/README.md file and the comment inside the dart file.

  Example(
    title: 'simpleRecorder',
    subTitle: 'A very simple example',
    flags: 0,
    route: (_) => SimpleRecorder(),
    description: '''
This is a very simple example for Flutter Sound beginners,
that shows how to record, and then playback a file.

This example is really basic.
''',
  ),
];

///
class ExamplesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sound Examples',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ExamplesAppHomePage(title: 'Flutter Sound Examples'),
    );
  }
}

///
class ExamplesAppHomePage extends StatefulWidget {
  ///
  ExamplesAppHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  ///
  final String? title;

  @override
  _ExamplesHomePageState createState() => _ExamplesHomePageState();
}

class _ExamplesHomePageState extends State<ExamplesAppHomePage> {
  Example? selectedExample;

  @override
  void initState() {
    selectedExample = exampleTable[0];
    super.initState();
    //_scrollController = ScrollController( );
  }

  @override
  Widget build(BuildContext context) {
    Widget cardBuilder(BuildContext context, int index) {
      var isSelected = (exampleTable[index] == selectedExample);
      return GestureDetector(
        onTap: () => setState(() {
          selectedExample = exampleTable[index];
        }),
        child: Card(
          shape: RoundedRectangleBorder(),
          borderOnForeground: false,
          elevation: 3.0,
          child: Container(
            height: 50,
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isSelected ? Colors.indigo : Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),

            //color: isSelected ? Colors.indigo : Colors.cyanAccent,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(exampleTable[index].title!,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black)),
              Text(exampleTable[index].subTitle!,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black)),
            ]),
          ),
        ),
      );
    }

    Widget makeBody() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Color(0xFFFAF0E6),
                border: Border.all(
                  color: Colors.indigo,
                  width: 3,
                ),
              ),
              child: ListView.builder(
                  itemCount: exampleTable.length, itemBuilder: cardBuilder),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Color(0xFFFAF0E6),
                border: Border.all(
                  color: Colors.indigo,
                  width: 3,
                ),
              ),
              child: SingleChildScrollView(
                child: Text(selectedExample!.description!),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: makeBody(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text((kIsWeb && (selectedExample!.flags! & tNotWeb != 0))
                    ? 'Not supported on Flutter Web '
                    : ''),
                ElevatedButton(
                  onPressed:
                      (kIsWeb && (selectedExample!.flags! & tNotWeb != 0))
                          ? null
                          : () => selectedExample!.go(context),
                  //color: Colors.indigo,
                  child: Text(
                    'GO',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )),
      ),
    );
  }
}