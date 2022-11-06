import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == '⌫') {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal, color: Colors.white),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ProjectColors.appBarBg,
        title: const Text(
          'Calculator Basic YGT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: equationFontSize, color: Colors.black)),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result.toString(),
              style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: resultFontSize, color: Colors.black)),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: sized_box_for_whitespace
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                width: MediaQuery.of(context).size.width * 0.75,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Table(
                    border: //border radius
                        TableBorder.all(width: .5, color: Colors.black),
                    children: [
                      TableRow(children: [
                        buildButton('C', 1, Colors.redAccent),
                        buildButton('⌫', 1, Colors.blue),
                        buildButton('÷', 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildButton('7', 1, Colors.black54),
                        buildButton('8', 1, Colors.black54),
                        buildButton('9', 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildButton('4', 1, Colors.black54),
                        buildButton('5', 1, Colors.black54),
                        buildButton('6', 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildButton('1', 1, Colors.black54),
                        buildButton('2', 1, Colors.black54),
                        buildButton('3', 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildButton('.', 1, Colors.black54),
                        buildButton('0', 1, Colors.black54),
                        buildButton('00', 1, Colors.black54),
                      ]),
                    ],
                  ),
                ),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  border: TableBorder.all(width: .5, color: Colors.black),
                  children: [
                    TableRow(children: [
                      buildButton('×', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('-', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('+', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('=', 2, Colors.redAccent),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProjectColors {
  static final Color appBarBg = Colors.red.shade800;
  static const Color buttonBorder = Color(0xFF1E1E1E);
}

class ProjectDecor {
  static final boxDec =
      BoxDecoration(border: Border.all(width: 3, color: Colors.black), borderRadius: BorderRadius.circular(10));
}
