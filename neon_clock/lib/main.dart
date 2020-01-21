import 'dart:async';

import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(ClockCustomizer((ClockModel model) => MyApp(model)));
}

class MyApp extends StatelessWidget {
  const MyApp(this.model);
  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Material(
          child: Clock(model),
        ));
  }
}

class Clock extends StatefulWidget {
  const Clock(this.model);
  final ClockModel model;

  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _now = DateTime.now();
  var _temperature = '';
  var _condition = '';
  var _location = '';

  Map<String, String> weatherIcon = {
    'cloudy': './icons/Cloudy.png',
    'foggy': './icons/Foggy.png',
    'rainy': './icons/Rainy.png',
    'snowy': './icons/Snow.png',
    'sunny': './icons/Sunny.png',
    'thunderstorm': './icons/Thunderstorm.png',
    'windy': './icons/Windy.png'
  };

  @override
  void initState() {
    widget.model.addListener(_updateModel);
    _updateModel();
    Timer.periodic(Duration(minutes: 1), (value) {
      setState(() {
        _now = DateTime.now();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            right: 3.0,
            top: 3.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Color(0xFFFFFFFF).withAlpha(50),
                  width: 8.0,
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white,
                width: 3.0,
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        weatherIcon[_condition],
                        width: 60.0,
                      ),
                      Text(
                        "$_temperature",
                        style: TextStyle(
                          height: 0.9,
                          fontSize: 32,
                          fontFamily: 'Beon',
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 50.0,
                              color: Color.fromARGB(200, 255, 255, 255),
                            ),
                            Shadow(
                              offset: Offset(-2.0, -2.0),
                              blurRadius: 50.0,
                              color: Color.fromARGB(200, 255, 255, 255),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 8.0,
                      ),
                      Text(
                        "$_condition    $_location",
                        style: TextStyle(
                          height: 0.9,
                          fontSize: 16,
                          fontFamily: 'Beon',
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 50.0,
                              color: Color.fromARGB(200, 255, 255, 255),
                            ),
                            Shadow(
                              offset: Offset(-2.0, -2.0),
                              blurRadius: 50.0,
                              color: Color.fromARGB(200, 255, 255, 255),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    DateFormat(widget.model.is24HourFormat ? 'HH:mm' : 'hh:mm')
                        .format(_now),
                    style: TextStyle(
                      height: 0.8,
                      fontSize: 180,
                      fontFamily: 'Beon',
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 50.0,
                          color: Color.fromARGB(200, 255, 255, 255),
                        ),
                        Shadow(
                          offset: Offset(-2.0, -2.0),
                          blurRadius: 50.0,
                          color: Color.fromARGB(200, 255, 255, 255),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat('EEEE, MMM dd').format(_now),
                    style: TextStyle(
                      fontFamily: 'Sacramento',
                      fontSize: 30,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 16.0,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        Shadow(
                          offset: Offset(-2.0, -2.0),
                          blurRadius: 16.0,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
