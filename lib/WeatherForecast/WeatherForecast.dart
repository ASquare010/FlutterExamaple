import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/AppTheme.dart';
import 'package:flutter_app/WeatherForecast/Modal/Modal.dart';
import 'package:flutter_app/WeatherForecast/Modal/Network.dart';
import 'package:flutter_app/WeatherForecast/Modal/Utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  Future<ApiModal> weatherForecast;
  String city = 'lahore';

  @override
  void initState() {
    //using FutureBuilder
    weatherForecast = getData();

    ///use this code when u don't use FutureBuilder
    // Network().getData('lahore').then((value) {
    //   setState(() {
    //     weatherForecast = value;
    //     load = true;
    //   });
    // });
    super.initState();
  }

  Future<ApiModal> getData() {
    return Network().getData(city);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: weatherForecast,
        builder: (BuildContext context, AsyncSnapshot<ApiModal> snapshot) {
          return Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Image.asset(
                      'assets/bg.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    blurTextForm(),
                    Text(
                      snapshot.hasData ? '${snapshot.data.city.name} , ${snapshot.data.city.country}' : 'Loading...',
                      style: TextStyle(color: white, fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        snapshot.hasData ? '${Utils.getDateConverter(snapshot.data.list[0].dtTxt)}' : 'Loading',
                        style: TextStyle(color: grey),
                      ),
                    ),
                    Expanded(
                        child: snapshot.hasData
                            ? Icon(
                                Utils.weatherIcon(snapshot.data.list[0].weather[0].main),
                                size: 150,
                                color: white.withOpacity(0.2),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  color: white.withOpacity(0.2),
                                ),
                              ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.hasData
                                  ? '${snapshot.data.list[0].main.temp.toStringAsFixed(0)}°C '
                                  : 'Loading...',
                              style: TextStyle(fontSize: 45, color: white),
                            ),
                            Text(
                              snapshot.hasData
                                  ? '${snapshot.data.list[0].weather[0].description.toUpperCase()}'
                                  : '',
                              style: TextStyle(color: grey),
                            )
                          ],
                        ),
                       snapshot.hasData? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            WeatherInfoContainer(
                              icon: FontAwesomeIcons.temperatureHigh,
                              text: '${snapshot.data.list[0].main.feelsLike} °C',
                            ),
                            WeatherInfoContainer(
                              icon: FontAwesomeIcons.solidGrinBeamSweat,
                              text: '${snapshot.data.list[0].main.humidity} %',
                            ),
                            WeatherInfoContainer(
                                icon: FontAwesomeIcons.wind, text: '${snapshot.data.list[0].wind.speed} mi/h'),
                          ],
                        ):SizedBox()
                      ],
                    ),
                    Spacer()
                  ],
                ),
                DraggableScrollableSheet(
                  builder: (context, scrollController) {
                    return BlurContainer(
                      padding: 4,
                      child: GridView.builder(
                        controller: scrollController,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(6),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 4 / 1,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 8,
                        ),
                        itemCount:snapshot.hasData? snapshot.data.list.length:0,
                        itemBuilder: (BuildContext context, int index) {
                          return DayWeatherChip(
                            temp: snapshot.hasData ? '${snapshot.data.list[index].main.temp.toStringAsFixed(0)}' : 'Loading',
                            day:  snapshot.hasData ? '${snapshot.data.list[index].dtTxt.weekday}' : 'Loading',
                            icon:   snapshot.hasData ? Utils.weatherIcon(snapshot.data.list[index].weather[0].main) : 'Loading',

                          );
                        },
                      ),
                    );
                  },
                  initialChildSize: 0.12,
                  maxChildSize: 0.35,
                  minChildSize: 0.12,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget blurTextForm() {
    return BlurContainer(
      child: TextField(
        cursorColor: white,
        style: TextStyle(color: white),
        onSubmitted: (value) {
          city = value;
          setState(() {
            weatherForecast = getData();
          });
          // print(widget.city);
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search City',
            hintStyle: TextStyle(color: grey),
            prefixIcon: Icon(
              Icons.search,
              color: white,
            ),
            suffixIcon: Icon(
              Icons.location_on_outlined,
              color: white,
            )),
      ),
    );
  }

}

class BlurContainer extends StatelessWidget {
  final Widget child;
  final double margin, padding, borderRadius;

  const BlurContainer({this.margin = 8, this.padding = 8, this.borderRadius = 8, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(margin),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFE9F3F9).withOpacity(0.2),
                      // Color(0xFF000000).withOpacity(0.1),
                      Color(0xFFE1ECFF).withOpacity(0.1)
                    ],
                    end: Alignment.topRight)),
            child: child,
          ),
        ),
      ),
    );
  }
}

class DayWeatherChip extends StatelessWidget {
  final String day, temp;
  final IconData icon;

  const DayWeatherChip({this.temp = '10', this.day = 'Sunday',this.icon = FontAwesomeIcons.sun});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(10),
          left: Radius.circular(10),
        ),
        color: white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      // spreadRadius: 5,
                      blurRadius: 6,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    // left: Radius.circular(10),
                  ),
                  color: white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    day,
                  ),
                  Text('$temp °C'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(icon,color: Colors.black.withOpacity(0.6),),
          )
        ],
      ),
    );
  }
}

class WeatherInfoContainer extends StatelessWidget {
  final String text;
  final IconData icon;

  const WeatherInfoContainer({this.text = 'temp', this.icon = Icons.http});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: Text(
            text,
            style: TextStyle(color: grey),
          ),
        ),
        Icon(
          icon,
          color: white,
        ),
      ],
    );
  }
}
