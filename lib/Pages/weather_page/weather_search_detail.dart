import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtools/Pages/weather_page/weather.dart';
import 'package:devtools/Pages/weather_page/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class WeatherSearchDetail extends StatefulWidget {
  final String value;

  const WeatherSearchDetail({super.key, required this.value});

  @override
  State<WeatherSearchDetail> createState() => _WeatherSearchDetailState();
}

class _WeatherSearchDetailState extends State<WeatherSearchDetail> {
  final ref = FirebaseFirestore.instance.collection('weather_data');
  List<WeatherModel> weathers = [];
  String image = 'assets/Images/cloud-gbada6f791_1280-removebg-preview.png';
  Color? boxColor;
  bool emptiness = true;
  String emptinessText = '';

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  getWeather() async {
    Weather weatherClass = Weather(city: widget.value);
    await weatherClass.getWeather();
    weathers = weatherClass.weather;
    if (weathers.isNotEmpty) {
      addToFirebase();
      emptiness = false;
    } else {
      emptinessText = 'City not found';
    }

    setState(() {});
  }

  addToFirebase() {
    ref.add({
      "cityName": weathers[0].cityName,
      "desc": weathers[0].desc,
      "temp": weathers[0].temp.ceil(),
      "wind": weathers[0].wind,
      "humidity": weathers[0].humidity,
      "pressure": weathers[0].pressure,
      "icon": weathers[0].icon,
    });
  }

  @override
  Widget build(BuildContext context) {
    if (weathers.isNotEmpty) {
      if (weathers[0].desc == 'Clouds') {
        image = 'assets/Images/cloud-gbada6f791_1280-removebg-preview.png';
        boxColor = Vx.gray400;
      } else if (weathers[0].desc == 'Rain' || weathers[0].desc == 'Drizzle') {
        image = 'assets/Images/cloud-g209a35d97_1280-removebg-preview.png';
        boxColor = Vx.blue400;
      } else if (weathers[0].desc == 'Clear') {
        image = 'assets/Images/sun-g4218ebaab_1280-removebg-preview.png';
        boxColor = Vx.yellow400;
      } else if (weathers[0].desc == 'Thunderstorm') {
        image = 'assets/Images/82ep_o74i_140728.jpg_3_-removebg-preview.png';
        boxColor = Vx.gray400;
      } else if (weathers[0].desc == 'Snow') {
        image = 'assets/Images/cloud-g6cf4c508a_1280-removebg-preview.png';
        boxColor = Vx.gray400;
      }
    }
    return Scaffold(
      body: SafeArea(
          child: emptiness
              ? Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: emptinessText == ''
                      ? const CircularProgressIndicator()
                      : Text(
                          emptinessText,
                          style: const TextStyle(fontSize: 30),
                        ),
                )
              : Container(
                  // color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(22),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.my_location_outlined,
                                color: Vx.green700,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Your location Now",
                                style: TextStyle(
                                    color: Vx.green700,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          weathers.isNotEmpty ? weathers[0].cityName : '',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
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
                              color: boxColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            weathers.isNotEmpty ? weathers[0].desc : '',
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
                            Text(
                                weathers.isNotEmpty
                                    ? "${weathers[0].temp}"
                                    : '',
                                style: const TextStyle(
                                    fontSize: 55, fontWeight: FontWeight.bold)),
                            Container(
                              alignment: Alignment.topLeft,
                              height:
                                  MediaQuery.of(context).size.height * 0.080,
                              width: MediaQuery.of(context).size.width * 0.045,
                              child: const Text(
                                "°",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Text('C',
                                style: TextStyle(
                                    fontSize: 55, fontWeight: FontWeight.bold)),
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
                                Text(weathers.isNotEmpty
                                    ? "${weathers[0].wind}m/s"
                                    : '')
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(CupertinoIcons.drop),
                                Text(weathers.isNotEmpty
                                    ? "${weathers[0].humidity}%"
                                    : '')
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.blur_circular_outlined),
                                Text(
                                  weathers.isNotEmpty
                                      ? "${weathers[0].pressure} hPa"
                                      : '',
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text('openweather.com',
                                style: TextStyle(fontSize: 16))
                          ],
                        )
                      ]),
                )),
    );
  }
}
