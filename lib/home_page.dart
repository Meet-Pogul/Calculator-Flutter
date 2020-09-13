import 'package:flutter/material.dart';
import 'calculate.dart';

class Calculate extends StatefulWidget {
  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate>
    with SingleTickerProviderStateMixin {
  //Configure theme
  ThemeData themeof;
  TextStyle textStyle;
  double _minPad = 5.0;
  String _currentValue = '';
  double _currentResult = 0;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeof = Theme.of(context);
    textStyle = themeof.textTheme.subtitle1;

    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: ListView(
        // shrinkWrap: true,
        reverse: true,
        children: <Widget>[
          Row(
            children: [
              button("00", setCurrentValue),
              button("0", setCurrentValue),
              button(".", setCurrentValue),
              button("=", equalTo),
            ],
          ),
          Row(
            children: [
              button("1", setCurrentValue),
              button("2", setCurrentValue),
              button("3", setCurrentValue),
              button("+", setCurrentValue),
            ],
          ),
          Row(
            children: [
              button("4", setCurrentValue),
              button("5", setCurrentValue),
              button("6", setCurrentValue),
              button("-", setCurrentValue),
            ],
          ),
          Row(
            children: [
              button("7", setCurrentValue),
              button("8", setCurrentValue),
              button("9", setCurrentValue),
              button("*", setCurrentValue),
            ],
          ),
          Row(
            children: [
              button("clear", clear),
              button("%", setCurrentValue),
              button("back", back),
              button("/", setCurrentValue),
            ],
          ),
          Container(
              padding: EdgeInsets.only(bottom: _minPad), child: showResult()),
          Container(
              padding: EdgeInsets.only(bottom: _minPad),
              child: getCurrentValue())
        ],
      )),
    );
  }

  void clear(String symbol) {
    setState(() {
      _currentValue = '';
      _currentResult = 0;
    });
  }

  void equalTo(String symbol) {
    setState(() {
      _currentValue = _currentResult.toString();
      _currentResult = 0;
    });
  }

  void back(String symbol) {
    setState(() {
      _currentValue = _currentValue.substring(0, _currentValue.length - 1);
    });
  }

  Widget button(String symbol, Function function) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(_minPad),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: symbolShow(symbol),
          onPressed: () => function(symbol),
          color: Colors.green,
          elevation: 20.0,
        ),
      ),
    );
  }

  Widget symbolShow(String symbol) {
    if (symbol == 'clear') {
      return Text(
        'C',
        style: TextStyle(fontSize: 50.0),
      );
    } else if (symbol == '*') {
      return Text(
        'x',
        style: TextStyle(fontSize: 50.0),
      );
    } else if (symbol == '00') {
      return Container(
        width: 50.0,
        height: 60.0,
        child: Center(
          child: Text(
            '00',
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      );
    } else if (symbol == 'back') {
      return Container(
        width: 50.0,
        height: 60.0,
        child: Center(
          child: Icon(
            Icons.backspace,
            size: 40.0,
          ),
        ),
      );
    } else {
      return Text(
        symbol,
        style: TextStyle(fontSize: 50.0),
      );
    }
  }

  Widget getCurrentValue() {
    return Text(
      _currentValue,
      style: TextStyle(fontSize: 50),
    );
  }

  void setCurrentValue(value) {
    setState(() {
      _currentValue = _currentValue + value;
    });
  }

  Widget showResult() {
    String value;
    if (_currentValue == '') {
      value = '';
    } else if (double.parse(
            _currentValue.substring(_currentValue.length - 1), (e) => null) ==
        null) {
      value = _currentResult.toString();
    } else {
      try {
        value = calcString(_currentValue).toString();
        _currentResult = double.parse(value);
      } on Exception {
        value = "Syntax Error";
      }
      if (value == "NaN") {
        value = "Infinity";
      }
    }
    return Text(
      value,
      textDirection: TextDirection.rtl,
      style: TextStyle(fontSize: 50),
    );
  }
}
