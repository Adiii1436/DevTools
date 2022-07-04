// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtools/Pages/weather_page/weather.dart';
import 'package:devtools/Pages/weather_page/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:devtools/Pages/weather_page/weather_detail.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            searchBox(context),
            const SizedBox(
              height: 25,
            ),
            const WeatherPlaces(),
          ]),
        ),
      ),
    );
  }

  Container searchBox(BuildContext context) {
    final fieldText = TextEditingController();
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: TextField(
          controller: fieldText,
          onSubmitted: (value) {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WeatherDetail(value: value)))
                .then((value) => setState(() {
                      fieldText.clear();
                    }));
          },
          // controller: title,
          cursorColor: Colors.black38,
          style: const TextStyle(
              // fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black26,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(
                color: Colors.black26,
              ))),
    );
  }
}

class WeatherPlaces extends StatefulWidget {
  const WeatherPlaces({Key? key}) : super(key: key);

  @override
  State<WeatherPlaces> createState() => _WeatherPlacesState();
}

class _WeatherPlacesState extends State<WeatherPlaces> {
  final ref = FirebaseFirestore.instance.collection('weather_data');
  List<WeatherModel> weathers = [];
  String image = '';

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder(
            stream: ref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return GridView.builder(
                  itemCount:
                      snapshot.hasData ? snapshot.data?.docChanges.length : 0,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.84 / 1),
                  itemBuilder: (context, index) {
                    if (snapshot.data?.docChanges[index].doc['desc'] ==
                        'Clouds') {
                      image =
                          'assets/Images/82ep_o74i_140728.jpg_1_-removebg-preview.png';
                    } else if (snapshot.data?.docChanges[index].doc['desc'] ==
                            'Rain' ||
                        snapshot.data?.docChanges[index].doc['desc'] ==
                            'Drizzle') {
                      image =
                          'assets/Images/82ep_o74i_140728.jpg_4_-removebg-preview.png';
                    } else if (snapshot.data?.docChanges[index].doc['desc'] ==
                        'Clear') {
                      image =
                          'assets/Images/82ep_o74i_140728.jpg-removebg-preview.png';
                    } else if (snapshot.data?.docChanges[index].doc['desc'] ==
                        'Thunderstorm') {
                      image =
                          'assets/Images/82ep_o74i_140728.jpg_3_-removebg-preview.png';
                    } else if (snapshot.data?.docChanges[index].doc['desc'] ==
                        'Snow') {
                      image =
                          'assets/Images/82ep_o74i_140728.jpg_5_-removebg-preview.png';
                    }
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${snapshot.data?.docChanges[index].doc['temp']}°",
                                    style: const TextStyle(
                                      fontSize: 40,
                                    )),
                                Image.asset(
                                  image,
                                  width: 60,
                                ),
                              ],
                            ),
                            Text(
                              "${snapshot.data?.docChanges[index].doc['cityName']}",
                              style: const TextStyle(fontSize: 17),
                            ),
                            Text(
                              "${snapshot.data?.docChanges[index].doc['desc']}",
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black45),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.drop,
                                      size: 15,
                                    ),
                                    Text(
                                      '${snapshot.data?.docChanges[index].doc['humidity']}%',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.wind,
                                      size: 15,
                                    ),
                                    Text(
                                      '${snapshot.data?.docChanges[index].doc['wind']}m/s',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                addToFirebase() {
                                  snapshot.data?.docChanges[index].doc.reference
                                      .update({
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

                                getWeather() async {
                                  Weather weatherClass = Weather(
                                      city: snapshot.data?.docChanges[index]
                                          .doc['cityName']);
                                  await weatherClass.getWeather();
                                  weathers = weatherClass.weather;
                                  addToFirebase();
                                  setState(() {});
                                }

                                getWeather();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.035,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    // color: Colors.teal,
                                    border: Border.all(color: Colors.teal),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "Refresh",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ]),
                    );
                  });
            }));
  }
}
