import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class WeatherForecastMap extends StatefulWidget {
  const WeatherForecastMap({
    Key key,
  }) : super(key: key);

  @override
  WeatherForecastMapState createState() => WeatherForecastMapState();
}

class WeatherForecastMapState extends State<WeatherForecastMap> {
  GoogleMapController googleMapController;
  Position currentPosition;
  bool isLoading = true;
  String currentAddress = 'lahore';

  @override
  void initState() {
    // TODO: implement initState
    _checkLocationService();
    super.initState();
  }

  void onMapCreate(GoogleMapController controller) {
    googleMapController = controller;
  }

  /// to receive location and stop loading
  void _checkLocationService() {
    _determinePosition().then((value) {
      setState(() {
        currentPosition = value;
        isLoading = false;
      });
    });
  }

  ///To check Location permission and return Object Position
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  /// Converts Coordinates to City name as string
  void onMapTap(LatLng laLg) async {
    String address;
    print(laLg);
    placemarkFromCoordinates(laLg.latitude, laLg.longitude).then((placeMarks) {
      if (placeMarks.first.subAdministrativeArea == '') {
        address = placeMarks.first.administrativeArea.toLowerCase();
        print(address);
      } else {
        address = placeMarks.first.subAdministrativeArea.toLowerCase();
        print(address);
      }
      if (address.toLowerCase().contains('city')) {
        currentAddress = address.toLowerCase().replaceAll('city', '');
        print(currentAddress);
      } else if (address.toLowerCase().contains('county')) {
        currentAddress = address.toLowerCase().replaceAll('county', '');
        print(currentAddress);
      } else if (address.toLowerCase().contains('governorate')) {
        currentAddress = address.toLowerCase().replaceAll('governorate', '');
        print(currentAddress);
      } else if (address.toLowerCase().contains('district')) {
        currentAddress = address.toLowerCase().replaceAll('district', '');
        print(currentAddress);
      } else {
        currentAddress = address.toLowerCase();
        print(currentAddress);
      }
      Navigator.pop(context,currentAddress);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : GoogleMap(
                mapType: MapType.terrain,
                compassEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(currentPosition.latitude, currentPosition.longitude),
                  zoom: 6,
                ),
                buildingsEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: onMapCreate,
                onTap: onMapTap,
              ));
  }
}
