import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class WeatherForecastMap extends StatefulWidget {
  @override
  WeatherForecastMapState createState() => WeatherForecastMapState();
}

class WeatherForecastMapState extends State<WeatherForecastMap> {
  GoogleMapController googleMapController;
  Position currentPosition;
  bool isLoading = true;
  String currentAddress = 'lahore';
  Set<Marker> markers = {};

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
        markers.add(Marker(
            markerId: MarkerId('Marker ${markers.length}'),
            position: LatLng(currentPosition.latitude, currentPosition.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(200),
            flat: true,
            onTap: () {
              onMapTap(LatLng(currentPosition.latitude, currentPosition.longitude));
            },
            infoWindow: InfoWindow(title: 'User Location')));
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

  /// Converts Coordinates to City name as string bu using geocoding package
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
      Navigator.pop(context, currentAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Map',style: TextStyle(color: Colors.grey),),
          backgroundColor: Color(0xFFE9F3F9).withOpacity(0.8),
          shadowColor: Colors.orange,
          centerTitle: true,
          automaticallyImplyLeading: false,
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
                markers: markers,
                onTap: onMapTap,
              ));
  }
}
