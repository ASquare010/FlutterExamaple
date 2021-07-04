import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/AppTheme.dart';
import 'package:flutter_app/WeatherForecast/Modal/Modal.dart';
import 'package:flutter_app/WeatherForecast/Modal/Network.dart';
import 'package:flutter_app/WeatherForecast/Modal/Utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CustomWidgets.dart';

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
                                  : '',
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
                          return InkWell(
                            child: DayWeatherChip(
                              temp: snapshot.hasData ? '${snapshot.data.list[index].main.temp.toStringAsFixed(0)}' : 'Loading',
                              day:  snapshot.hasData ? '${Utils.getDate(snapshot.data.list[index].dtTxt)}' : 'Loading',
                              icon:   snapshot.hasData ? Utils.weatherIcon(snapshot.data.list[index].weather[0].main) : 'Loading',

                            ),
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
