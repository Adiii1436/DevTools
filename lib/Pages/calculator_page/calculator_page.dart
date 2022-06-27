import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  TextEditingController task = TextEditingController();
  String conc = '';

  @override
  Widget build(BuildContext context) {
    var text = [
      'C',
      '%',
      '<',
      '÷',
      '7',
      '8',
      '9',
      '×',
      '4',
      '5',
      '6',
      '-',
      '1',
      '2',
      '3',
      '+',
      '00',
      '0',
      '.',
      '='
    ];
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.39,
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 15, bottom: 40),
              child: TextField(
                controller: task,
                scrollPhysics: const BouncingScrollPhysics(),
                textAlign: TextAlign.right,
                cursorColor: Colors.black38,
                maxLines: null,
                style: const TextStyle(fontSize: 35, color: Colors.black),
                decoration: const InputDecoration(
                  // isDense: true,
                  border: InputBorder.none,
                  enabled: false,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: GridView.builder(
                    itemCount: 20,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (text[index] == 'C') {
                            conc = '';
                            task = TextEditingController(text: conc);
                            setState(() {});
                          } else if (text[index] == '<') {
                            conc = conc.substring(0, conc.length - 1);
                            task = TextEditingController(text: conc);
                            setState(() {});
                          } else if (text[index] == '=') {
                            try {
                              var s1 = conc.split('×');
                              var sum =
                                  double.parse(s1[0]) * double.parse(s1[1]);
                              conc = sum.toString();
                              task = TextEditingController(text: conc);
                              setState(() {});
                            } catch (e) {
                              try {
                                var s1 = conc.split('+');
                                var sum =
                                    double.parse(s1[0]) + double.parse(s1[1]);
                                conc = sum.toString();
                                task = TextEditingController(text: conc);
                                setState(() {});
                              } catch (e) {
                                try {
                                  var s1 = conc.split('-');
                                  var sum =
                                      double.parse(s1[0]) - double.parse(s1[1]);
                                  conc = sum.toString();
                                  task = TextEditingController(text: conc);
                                  setState(() {});
                                } catch (e) {
                                  try {
                                    var s1 = conc.split('%');
                                    var sum = double.parse(s1[0]) %
                                        double.parse(s1[1]);
                                    conc = sum.toInt().toString();
                                    task = TextEditingController(text: conc);
                                    setState(() {});
                                  } catch (e) {
                                    var s1 = conc.split('÷');
                                    var sum = double.parse(s1[0]) /
                                        double.parse(s1[1]);
                                    conc = sum.toString();
                                    task = TextEditingController(text: conc);
                                    setState(() {});
                                  }
                                }
                              }
                            }
                          } else {
                            conc = conc + text[index];
                            task = TextEditingController(text: conc);
                            setState(() {});
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(2),
                          child: Center(
                              child: Text(
                            text[index],
                            style: const TextStyle(fontSize: 29),
                          )),
                        ),
                      );
                    })),
          ),
        ],
      )),
    );
  }
}
