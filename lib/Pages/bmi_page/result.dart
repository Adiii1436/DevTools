import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BmiResult extends StatelessWidget {
  final double height;
  final double weight;

  const BmiResult({super.key, required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {
    String status = '';
    Color? cl;
    String desc = '';
    String info = '';
    final bmi = weight / ((height / 100) * (height / 100));
    if (bmi < 18.5) {
      status = 'UNDERWEIGHT';
      cl = Colors.blue;
      desc = 'Underweight BMI range: <18kg/m2';
      info = 'You are underweight. Eat more!';
    } else if (bmi >= 18.5 && bmi <= 25) {
      status = 'NORMAL';
      cl = Colors.green;
      desc = 'Normal BMI range: 18.5 - 25kg/m2';
      info = 'You have a normal body weight. Good job!';
    } else if (bmi > 25 && bmi <= 29.9) {
      status = 'OVERWEIGHT';
      cl = Colors.yellow;
      desc = 'Overweight BMI range: 25 - 29.9kg/m2';
      info = 'You are overweight. Eat less!';
    } else {
      status = 'OBESE';
      cl = Colors.orange;
      desc = 'Obese BMI range: >29.9 kg/m2';
      info = 'Fuck! so much fat. God bless you.';
    }
    var firstDesc = desc.split(":")[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 25, top: 65),
            child: const Text(
              'Your Result',
              style: TextStyle(fontSize: 33),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              width: 320,
              height: 390,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Text(
                    status,
                    style: TextStyle(
                        fontSize: 23, color: cl, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  bmi.ceil().toString(),
                  style: const TextStyle(
                      fontSize: 100, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$firstDesc:",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(desc.split(":")[1], style: const TextStyle(fontSize: 15)),
                const SizedBox(
                  height: 30,
                ),
                Text(info.substring(0, 23),
                    style: const TextStyle(fontSize: 15)),
                Text(info.substring(23), style: const TextStyle(fontSize: 15)),
              ]),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Vx.red500, borderRadius: BorderRadius.circular(3)),
                width: 320,
                height: 50,
                child: const Center(
                    child: Text(
                  'RE-CALCULATE YOUR BMI',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
