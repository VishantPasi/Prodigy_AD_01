import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expression = "";
  String defaultResult = "0";

  scaffMess() {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 800),
        backgroundColor: Colors.red,
        content: Center(
            child: Text(
          "Can't enter more than 12 digits including operators",
          style: TextStyle(
              fontSize: 20, fontFamily: "Rubik", fontWeight: FontWeight.w600),
        ))));
  }

  void userAnswer() {
    try {
      String result = expression;
      Parser p = Parser();
      Expression exp = p.parse(result
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-')
          .replaceAll('%', '/100'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      defaultResult = eval.toString();
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 800),
            backgroundColor: Colors.red,
            content: Center(
                child: Text(
              "Invalid format used",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w600),
            ))));
      });
    }
  }

  containerBox(String textvalue, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (expression == "0") {
            expression = "";
          }
          if (expression.length <= 12) {
            expression += value;
          } else {
            scaffMess();
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromARGB(255, 82, 107, 119)),
            child: Center(
                child: Text(textvalue,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: "Rubik")))),
      ),
    );
  }

  containerBoxWithIcon(IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          switch (icon) {
            case Icons.percent:
              if (expression == "0") {
                expression = "";
              }
              if (expression.length <= 12) {
                expression += "%×";
              } else {
                scaffMess();
              }

            case Icons.backspace:
              if (expression.isNotEmpty) {
                expression = expression.substring(0, expression.length - 1);
              }

            case CupertinoIcons.divide:
              if (expression == "0") {
                expression = "";
              }
              if (expression.length <= 12) {
                expression += "÷";
              } else {
                scaffMess();
              }

            case Icons.close:
              if (expression == "0") {
                expression = "";
              }
              if (expression.length <= 12) {
                expression += "×";
              } else {
                scaffMess();
              }

            case Icons.remove:
              if (expression == "0") {
                expression = "";
              }
              if (expression.length <= 12) {
                expression += "−";
              } else {
                scaffMess();
              }

            case Icons.add:
              if (expression == "0") {
                expression = "";
              }
              if (expression.length <= 12) {
                expression += "+";
              } else {
                scaffMess();
              }

            case CupertinoIcons.equal:
              if (expression.isEmpty) {
                defaultResult = "0";
              } else {
                userAnswer();
              }
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: const Color.fromARGB(255, 102, 158, 204)),
          child: Center(
              child: Icon(
            icon,
            size: 30,
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 22, 36),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 280,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(expression,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 209, 237, 255),
                              fontSize: 40,
                              fontFamily: "Rubik")),
                      Text(defaultResult,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 233, 255, 182),
                              fontSize: 45,
                              fontFamily: "Rubik",
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 38, 62, 73),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GridView.count(
                    crossAxisCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            expression = "0";
                            defaultResult = "0";
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color:
                                      const Color.fromARGB(255, 102, 158, 204)),
                              child: const Center(
                                  child: Text("C",
                                      style: TextStyle(
                                          fontSize: 30, fontFamily: "Rubik")))),
                        ),
                      ),
                      containerBoxWithIcon(Icons.percent),
                      containerBoxWithIcon(Icons.backspace),
                      containerBoxWithIcon(CupertinoIcons.divide),
                      containerBox("1", "1"),
                      containerBox("2", "2"),
                      containerBox("3", "3"),
                      containerBoxWithIcon(Icons.close),
                      containerBox("4", "4"),
                      containerBox("5", "5"),
                      containerBox("6", "6"),
                      containerBoxWithIcon(Icons.remove),
                      containerBox("7", "7"),
                      containerBox("8", "8"),
                      containerBox("9", "9"),
                      containerBoxWithIcon(Icons.add),
                      containerBox("00", "00"),
                      containerBox("0", "0"),
                      containerBox(".", "."),
                      containerBoxWithIcon(CupertinoIcons.equal),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
