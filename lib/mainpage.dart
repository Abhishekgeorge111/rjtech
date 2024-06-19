import 'dart:async';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:rjtech/global/globalvar.dart';
import 'package:rjtech/searchdest.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final Completer<GoogleMapController> googleMapCompleterController =
      Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  double bottomMapPadding = 0;
  Position? currentPositionOfUser;
  double searchContainerHeight = 276;

  // String? mapStyle;

  // @override
  // void initState() {
  //   super.initState();
  //   getJsonFileFromThemes("themes/standard_style.json").then((value) {
  //     setState(() {
  //       mapStyle = value;
  //     });
  //   });
  // }

  // Future<String> getJsonFileFromThemes(String mapStylePath) async {
  //   ByteData byteData = await rootBundle.load(mapStylePath);
  //   var list = byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
  //   return utf8.decode(list);
  // }

  getCurrentLiveLocationOfUser() async {
    Position positionOfUser = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositionOfUser = positionOfUser;

    LatLng positionOfUserInLatLng = LatLng(
        currentPositionOfUser!.latitude, currentPositionOfUser!.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: positionOfUserInLatLng, zoom: 15);
    controllerGoogleMap!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(top: 26, bottom: bottomMapPadding),
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            initialCameraPosition: googleplexInitialPosition,
            onMapCreated: (GoogleMapController mapController) {
              controllerGoogleMap = mapController;
              googleMapCompleterController.complete(controllerGoogleMap);
              setState(() {
                bottomMapPadding = 300;
              });
              getCurrentLiveLocationOfUser();
            },
          ),
          Positioned(
            top: 50,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                getCurrentLiveLocationOfUser();
              },
              child: Icon(Icons.my_location),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -80,
            child: Container(
              height: searchContainerHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => SearchDestinationPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24)),
                    child: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24)),
                    child: const Icon(
                      Icons.work,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
