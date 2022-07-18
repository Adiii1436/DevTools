// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtools/Pages/weather_page/weather.dart';
import 'package:devtools/Pages/weather_page/weather_model.dart';
import 'package:devtools/Pages/weather_page/weather_page_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:devtools/Pages/weather_page/weather_search_detail.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final ref = FirebaseFirestore.instance.collection('weather_data');
  List<WeatherModel> weathers = [];
  String image = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: InkWell(
            onTap: () {
              ref.get().then((QuerySnapshot snapshot) async {
                for (var element in snapshot.docs) {
                  Weather weatherClass = Weather(city: element['cityName']);
                  await weatherClass.getWeather();
                  weathers = weatherClass.weather;
                  if (weathers.isNotEmpty) {
                    setState(() {
                      element.reference.update({
                        "cityName": weathers[0].cityName,
                        "desc": weathers[0].desc,
                        "temp": weathers[0].temp.ceil(),
                        "wind": weathers[0].wind,
                        "humidity": weathers[0].humidity,
                        "pressure": weathers[0].pressure,
                        "icon": weathers[0].icon,
                      });
                    });
                  }
                }
              });
            },
            child: Container(
                margin: const EdgeInsets.all(30),
                child: const Icon(Icons.refresh))),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            searchBox(context),
            const SizedBox(
              height: 25,
            ),
            Expanded(
                child: StreamBuilder(
                    stream: ref.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return GridView.builder(
                          itemCount:
                              snapshot.hasData ? snapshot.data?.docs.length : 0,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 0.99 / 1),
                          itemBuilder: (context, index) {
                            getImage() {
                              if (snapshot.data?.docs[index]['desc'] ==
                                  'Clouds') {
                                image =
                                    'assets/Images/82ep_o74i_140728.jpg_1_-removebg-preview.png';
                              } else if (snapshot.data?.docs[index]['desc'] ==
                                      'Rain' ||
                                  snapshot.data?.docs[index]['desc'] ==
                                      'Drizzle') {
                                image =
                                    'assets/Images/82ep_o74i_140728.jpg_4_-removebg-preview.png';
                              } else if (snapshot.data?.docs[index]['desc'] ==
                                  'Clear') {
                                image =
                                    'assets/Images/82ep_o74i_140728.jpg-removebg-preview.png';
                              } else if (snapshot.data?.docs[index]['desc'] ==
                                  'Thunderstorm') {
                                image =
                                    'assets/Images/82ep_o74i_140728.jpg_3_-removebg-preview.png';
                              } else if (snapshot.data?.docs[index]['desc'] ==
                                  'Snow') {
                                image =
                                    'assets/Images/82ep_o74i_140728.jpg_5_-removebg-preview.png';
                              }
                            }

                            getImage();
                            return InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WeatherPageDetail(
                                            doc: snapshot.data!.docs[index]
                                                .data())));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  "${snapshot.data?.docs[index]['temp']}",
                                                  style: const TextStyle(
                                                    fontSize: 40,
                                                  )),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.060,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.045,
                                                child: const Text(
                                                  "°",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                              )
                                            ],
                                          ),
                                          Image.asset(
                                            image,
                                            width: 60,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${snapshot.data?.docs[index]['cityName']}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data?.docs[index]['desc']}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black45),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.drop,
                                                size: 15,
                                              ),
                                              Text(
                                                '${snapshot.data?.docs[index]['humidity']}%',
                                                style: const TextStyle(
                                                    fontSize: 12),
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
                                                '${snapshot.data?.docs[index]['wind']} m/s',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ]),
                              ),
                            );
                          });
                    })),

            // const WeatherPlaces(),
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
                        builder: (context) =>
                            WeatherSearchDetail(value: value)))
                .then((value) => setState(() {}));
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
