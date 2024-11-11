import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final TextEditingController _txt = TextEditingController(text: '0');
  String a = '';
  String b = '';
  String oper = '';
  double result = 0;

  void btnPressed(String btnText) {
    if (btnText == 'C') {
      _txt.text = '0';
      a = '';
      b = '';
      oper = '';
    } else if (btnText == '+' || btnText == '-' || btnText == '*' || btnText == '/') {
      oper = btnText;
    } else if (btnText == '=') {
      double x = double.parse(a);
      double y = double.parse(b);
      switch(oper) {
        case '+':
          result = x + y;
          break;
        case '-':
          result = x - y;
          break;
        case '*':
          result = x * y;
          break;
        case '/':
          result = x / y;
          break;
      }

      String z = result.toString();
      int n = z.length;
      if (z[n-1] == '0' && z[n-2] == '.' ) {
        _txt.text = z.substring(0, z.length - 2);
      } else {
        _txt.text = z;
      }
      a = '';
      b = '';
      oper = '';

    } else if (btnText == '√') {
      _txt.text = sqrt(double.parse(_txt.text)).toString();
      a = '';
      b = '';
      oper = '';
      // double lI = double.parse(_txt.text);
      // double teLi = sqrt(lI) ;
      // _txt.text = teLi.toString() ;
    }
    else if (btnText == '«') {
      if (oper == '') {
        a = a.substring(0, a.length - 1);
        if (a.isEmpty) {
          a = '';
          _txt.text = '0';
        } else {
          _txt.text = a;
        }
      } else {
        b = b.substring(0, b.length - 1);
        if (b.isEmpty) {
          b = '';
          _txt.text = '0';
        } else {
          _txt.text = b;
        }
      }
    } else if (btnText == '±') {
      if (oper.isEmpty) {
        if (a[0] == '-') {
          a = a.substring(1, a.length);
          _txt.text = a;
        }else {
          a = '-$a';
          _txt.text = a;
        }
      } else {
        if (b[0] == '-') {
          b = b.substring(1, b.length);
          _txt.text = b;
        }else {
          b = '-$b';
          _txt.text = b;
        }
      }
    }else {
      if (oper == '') {
        a += btnText;
        _txt.text = a;
      } else {
        b += btnText;
        _txt.text = b;
      }
    }
  }

  Widget createButton(String btnText, Color textColor, Color btnColor) {
    return ElevatedButton(
        onPressed: () => btnPressed(btnText),
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
      ),
        child: Text(
            btnText,
          style: TextStyle(
            fontSize: 30,
            color: textColor,
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Simple Flutter calculator",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            TextField(
              controller: _txt,
              readOnly: true,
              style: const TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.end,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*.\d*')),
              ],
              maxLength: 18,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 50,),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: [
                  createButton('C', Colors.white, Colors.red),
                  createButton('«', Colors.white, Colors.pinkAccent),
                  createButton('±', Colors.white, Colors.black38),
                  createButton('√', Colors.white, Colors.black38),
                  createButton('7', Colors.black, Colors.white38),
                  createButton('8', Colors.black, Colors.white38),
                  createButton('9', Colors.black, Colors.white38),
                  createButton('+', Colors.white, Colors.black38),
                  createButton('4', Colors.black, Colors.white38),
                  createButton('5', Colors.black, Colors.white38),
                  createButton('6', Colors.black, Colors.white38),
                  createButton('-', Colors.white, Colors.black38),
                  createButton('1', Colors.black, Colors.white38),
                  createButton('2', Colors.black, Colors.white38),
                  createButton('3', Colors.black, Colors.white38),
                  createButton('*', Colors.white, Colors.black38),
                  createButton('.', Colors.white, Colors.black38),
                  createButton('0', Colors.black, Colors.white38),
                  createButton('=', Colors.white, Colors.black38),
                  createButton('/', Colors.white, Colors.black38),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
