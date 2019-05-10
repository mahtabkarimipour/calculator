import 'package:flutter/material.dart';

class CalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _CalculatorOutPutViewState state = _CalculatorOutPutViewState();
    return Column(
      children: [
        _CalculatorOutputView(state),
        Flexible(
          child: CalculatorPanel(state),
        ),
      ],
    );
  }
}

class CalculatorPanel extends StatelessWidget {
  final _CalculatorOutPutViewState state;

  CalculatorPanel(this.state);

  final List<String> _buttons_chars = [
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    'C',
    '0',
    '=',
    '/'
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: const EdgeInsets.all(30.0),
        crossAxisSpacing: 2.0,
        crossAxisCount: 4,
        children: _buttons_chars
            .map((element) => Container(
                  child: RawMaterialButton(
                    onPressed: () => state.buttonPressed(element),
                    child: new Text(element,
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.redAccent,
                    padding: const EdgeInsets.all(5.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                ))
            .toList());
  }
}

class _CalculatorOutputView extends StatefulWidget {
  final State<StatefulWidget> state;

  _CalculatorOutputView(this.state);

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class _CalculatorOutPutViewState extends State<_CalculatorOutputView> {
  String t = 'Welcome';
  String state = 'Start';
  int op1, op2;
  String op, tmp;

  void buttonPressed(String char) {
    if (char == 'C') {
      setState(() {
        t = 'Result';
        state = 'Start';
        op = '';
      });
    }
    if (char == '=') {
      if (state == 'Op2') {
        op2 = int.parse(tmp);
        switch (op) {
          case '+':
            {
              setState(() {
                t = (op1 + op2).toString();
              });
            }
            break;
          case '-':
            {
              setState(() {
                t = (op1 - op2).toString();
              });
            }
            break;
          case '*':
            {
              setState(() {
                t = (op1 * op2).toString();
              });
            }
            break;
          case '/':
            {
              setState(() {
                t = (op1 / op2).toString();
              });
            }
            break;
        }
        state = 'Start';
      }
      return;
    }

    switch (state) {
      case 'Start':
        {
          if (isNumeric(char)) {
            setState(() {
              t = char;
              state = "Op1";
            });
          }
        }
        break;

      case 'Op1':
        {
          if (isNumeric(char)) {
            setState(() {
              t = t + char;
            });
          } else {
            op = char;
            op1 = int.parse(t);
            setState(() {
              t = t + char;
            });
            tmp = '';
            state = 'Op2';
          }
        }
        break;

      case 'Op2':
        {
          if (isNumeric(char)) {
            tmp = tmp + char;
            setState(() {
              t = t + char;
            });
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        t,
        style: TextStyle(fontSize: 40),
      ),
      padding: EdgeInsets.all(30),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}
