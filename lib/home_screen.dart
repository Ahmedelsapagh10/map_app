import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_app/map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getLatLong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.location_on_outlined),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapScreen()));
          }),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cheebo Location'),
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('latitude : ${lat ?? '-'}'),
            Text('longitude : ${lat ?? '-'}'),
            Text('address : ${address ?? '-'}'),
            ElevatedButton(
                onPressed: getLatLong, child: const Text('get my location'))
          ],
        ),
      ),
    );
  }

  String? address;
  double? lat;
  double? lang;

  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) async {
      print("value $value");
      setState(() {
        lat = value.latitude;
        lang = value.longitude;
      });

      await getAddress(lat: value.latitude, lang: value.longitude);
    }).catchError((error) {
      print("Error $error");
    });
  }

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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  getAddress({required double lat, required double lang}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lang);
    setState(() {
      address =
          "${placemarks[0].street!} ${placemarks[0].locality!} ${placemarks[0].country!}";
    });

    for (int i = 0; i < placemarks.length; i++) {
      print("INDEX $i ${placemarks[i]}");
    }
  }
}
