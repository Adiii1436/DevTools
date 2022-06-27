import 'package:devtools/Pages/bmi_page/result.dart';
import 'package:devtools/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({Key? key}) : super(key: key);

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  var height = 0.0;
  var weight = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MyTheme.creamColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MyTheme.creamColor,
        title: const Text('BMI CALCULATOR').px32(),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.89,
                height: MediaQuery.of(context).size.height * 0.25,
                margin: const EdgeInsets.only(right: 6, left: 6),
                alignment: Alignment.center,
                // margin: const EdgeInsets.only(left: 19, right: 23),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white),
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "HEIGHT",
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(height == 0.0 ? "0" : height.toString(),
                          style: const TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold)),
                      Container(
                        height: 45,
                        // decoration: BoxDecoration(border: Border.all()),
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "cm",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(2)),
                    width: 300,
                    child: HorizontalPicker(
                      height: 60,
                      minValue: 56,
                      maxValue: 240,
                      divisions: 600,
                      suffix: " cm",
                      showCursor: false,
                      backgroundColor: Colors.white,
                      activeItemTextColor: Vx.red600,
                      passiveItemsTextColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          height = value;
                        });
                      },
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.89,
                height: MediaQuery.of(context).size.height * 0.25,
                margin: const EdgeInsets.only(right: 6, left: 6),
                alignment: Alignment.center,
                // margin: const EdgeInsets.only(left: 19, right: 23),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white),
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "WEIGHT",
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(weight == 0.0 ? "0" : weight.toString(),
                          style: const TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold)),
                      Container(
                        height: 45,
                        // decoration: BoxDecoration(border: Border.all()),
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "kg",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(2)),
                    width: 300,
                    child: HorizontalPicker(
                      height: 60,
                      minValue: 40,
                      maxValue: 110,
                      divisions: 600,
                      suffix: " cm",
                      showCursor: false,
                      backgroundColor: Colors.white,
                      activeItemTextColor: Vx.red600,
                      passiveItemsTextColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          weight = value;
                        });
                      },
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                height != 0 && weight != 0
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BmiResult(
                                  height: height,
                                  weight: weight,
                                )))
                    : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        elevation: 0.0,
                        backgroundColor: Vx.gray600,
                        content: Container(
                          margin: const EdgeInsets.only(left: 39),
                          child: const Text(
                            "Please enter your height and weight",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Vx.red500, borderRadius: BorderRadius.circular(3)),
                width: 330,
                height: 50,
                child: const Center(
                    child: Text(
                  'CALCULATE YOUR BMI',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
