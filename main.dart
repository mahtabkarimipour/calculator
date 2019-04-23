import 'package:flutter/material.dart';
import './calculator_view.dart';

main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Calculator')),
        body: CalculatorView(),
      ),
    );
  }
}
