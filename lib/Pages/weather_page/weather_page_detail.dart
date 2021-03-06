// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class WeatherPageDetail extends StatefulWidget {
  final doc;
  const WeatherPageDetail({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  State<WeatherPageDetail> createState() => _WeatherPageDetailState();
}

class _WeatherPageDetailState extends State<WeatherPageDetail> {
  String image = 'assets/Images/cloud-gbada6f791_1280-removebg-preview.png';
  Color? boxColor;

  @override
  Widget build(BuildContext context) {
    if (widget.doc['desc'] == 'Clouds') {
      image = 'assets/Images/cloud-gbada6f791_1280-removebg-preview.png';
      boxColor = Vx.gray400;
    } else if (widget.doc['desc'] == 'Rain' ||
        widget.doc['desc'] == 'Drizzle') {
      image = 'assets/Images/cloud-g209a35d97_1280-removebg-preview.png';
      boxColor = Vx.blue400;
    } else if (widget.doc['desc'] == 'Clear') {
      image = 'assets/Images/sun-g4218ebaab_1280-removebg-preview.png';
      boxColor = Vx.yellow500;
    } else if (widget.doc['desc'] == 'Thunderstorm') {
      image = 'assets/Images/82ep_o74i_140728.jpg_3_-removebg-preview.png';
      boxColor = Vx.gray400;
    } else if (widget.doc['desc'] == 'Snow') {
      image = 'assets/Images/cloud-g6cf4c508a_1280-removebg-preview.png';
      boxColor = Vx.gray400;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: boxColor,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                widget.doc.reference
                    .delete()
                    .whenComplete(() => Navigator.pop(context));
              },
              icon: const Icon(Icons.delete_outline_outlined))
        ],
      ),
      body: SafeArea(
        child: Container(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(22),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Icon(
                Icons.my_location_outlined,
                color: Vx.green700,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Your location Now",
                style:
                    TextStyle(color: Vx.green700, fontWeight: FontWeight.bold),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.doc.data()['cityName'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              image,
              width: 160,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.037,
              width: MediaQuery.of(context).size.width * 0.42,
              decoration: BoxDecoration(
                  color: boxColor, borderRadius: BorderRadius.circular(15)),
              child: Text(
                widget.doc.data()['desc'],
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.doc.data()['temp'].toString(),
                    style: const TextStyle(
                        fontSize: 55, fontWeight: FontWeight.bold)),
                Container(
                  alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height * 0.080,
                  width: MediaQuery.of(context).size.width * 0.045,
                  child: const Text(
                    "??",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text('C',
                    style:
                        TextStyle(fontSize: 55, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(CupertinoIcons.wind),
                    Text("${widget.doc.data()['wind']}m/s")
                  ],
                ),
                Row(
                  children: [
                    const Icon(CupertinoIcons.drop),
                    Text("${widget.doc.data()['humidity']}%")
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.blur_circular_outlined),
                    Text(
                      "${widget.doc.data()['pressure']} hPa",
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Temperature',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('celcius', style: TextStyle(fontSize: 16))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Wind',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('m/s', style: TextStyle(fontSize: 16))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Source',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('openweather.com', style: TextStyle(fontSize: 16))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
