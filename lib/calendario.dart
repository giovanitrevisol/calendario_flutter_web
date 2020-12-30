import 'dart:async';

import 'package:calendario/screen/controller/calendario_controller.dart';
import 'package:calendario/screen/screen/calendario_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Calendario {
  static const MethodChannel _channel = const MethodChannel('calendario');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Widget buildCalendar({Color background, double height, double width}) {
    return Provider<CalendarioController>(
      create: (context) => CalendarioController(),
      child: CalendarioScreen(
        background: background,
      ),
    );
  }
}
