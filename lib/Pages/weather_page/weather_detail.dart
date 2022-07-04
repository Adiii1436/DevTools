import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtools/Pages/weather_page/weather.dart';
import 'package:devtools/Pages/weather_page/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherDetail extends StatefulWidget {
  final String value;

  const WeatherDetail({super.key, required this.value});

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  final ref = FirebaseFirestore.instance.collection('weather_data');
  List<WeatherModel> weathers = [];
  String image = 'assets/Images/cloud-gbada6f791_1280-removebg-preview.png';

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  getWeather() async {
    Weather weatherClass = Weather(city: widget.value);
    await weatherClass.getWeather();
    weathers = weatherClass.weather;
    addToFirebase();
    setState(() {});
  }

  addToFirebase() {
    ref.add({
      "cityName": weathers[0].cityName,
      "desc": weathers[0].desc,
      "temp": weathers[0].temp.ceil(),
      "wind": weathers[0].wind,
      "humidity": weathers[0].humidity,
      "feelsLike": weathers[0].feelsLike,
      "pressure": weathers[0].pressure,
      "icon": weathers[0].icon,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        // color: Colors.red,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(22),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Icon(Icons.my_location_outlined),
            SizedBox(
              width: 5,
            ),
            Text("Your location Now"),
          ]),
          const SizedBox(
            height: 10,
          ),
          Text(
            weathers.isNotEmpty ? weathers[0].cityName : '',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            image,
            width: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.037,
            width: MediaQuery.of(context).size.width * 0.42,
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              weathers.isNotEmpty ? weathers[0].desc : '',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            weathers.isNotEmpty ? "${weathers[0].temp}°C" : '',
            style: const TextStyle(fontSize: 60),
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
                  Text(weathers.isNotEmpty ? "${weathers[0].wind}m/s" : '')
                ],
              ),
              Row(
                children: [
                  const Icon(CupertinoIcons.drop),
                  Text(weathers.isNotEmpty ? "${weathers[0].humidity}%" : '')
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.blur_circular_outlined),
                  Text(
                    weathers.isNotEmpty ? "${weathers[0].pressure} hPa" : '',
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
              Text('34°C', style: TextStyle(fontSize: 16))
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
              Text('34', style: TextStyle(fontSize: 16))
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
      )),
    );
  }
}

// if (weathers.isNotEmpty &&
//         (weathers[weathers.length - 1].desc == 'light rain' ||
//             weathers[weathers.length - 1].desc == 'heavy rain')) {
//       image = 'assets/Images/cloud-g209a35d97_1280-removebg-preview.png';
//     } else if (weathers.isNotEmpty &&
//         weathers[weathers.length - 1].desc == 'sunny') {
//       image = 'assets/Images/sun-g4218ebaab_1280-removebg-preview.png';
//     } else if (weathers.isNotEmpty &&
//         weathers[weathers.length - 1].desc == 'sunny') {
//       image = 'assets/Images/sun-g4218ebaab_1280-removebg-preview.png';
//     } else if (weathers.isNotEmpty &&
//         weathers[weathers.length - 1].desc == 'cloudy') {
//       image = 'assets/Images/sun-g4218ebaab_1280-removebg-preview.png';
//     } else {
//       image = 'assets/Images/sun-g4218ebaab_1280-removebg-preview.png';
//     }
