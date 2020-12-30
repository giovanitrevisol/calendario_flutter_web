import 'package:flutter/material.dart';

import 'package:calendario/calendario.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin Teste'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: Calendario().buildCalendar(
            background: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
