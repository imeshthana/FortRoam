import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import '../components/app_bar2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:math' show cos, sqrt, asin;

class CustomRouteMapScreen extends StatefulWidget {
  CustomRouteMapScreen({required this.data});

  final List<Map<String, dynamic>> data;

  @override
  State<CustomRouteMapScreen> createState() => _CustomRouteMapScreenState();
  static String id = 'map_screen';
}

class _CustomRouteMapScreenState extends State<CustomRouteMapScreen> {
  String mapStyle = '';

  final Completer<GoogleMapController> controller = Completer();

  // List<Map<String, dynamic>> data = [];

  // getData() async {
  //   data = await MongoDatabase.getData();
  // }

  static const LatLng center =
      const LatLng(6.028320555913446, 80.21670426593813);

  LocationData? currentLocation;
  late PointLatLng initialPosition;

  late int numberOfPlaces;
  late List<LatLng> polylineCoordinates;
  // Map<PolylineId, Polyline> polylines = {};
  late Set<Polyline> polylines;
  PolylinePoints polylinePoints = PolylinePoints();

  Future<void> getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((value) {
      setState(() {
        currentLocation = value;
        initialPosition = PointLatLng(value.latitude!, value.longitude!);
      });
    });
  }

  Future<Uint8List> getBytesFromMapIcons(String path, int size) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: size, targetWidth: size);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  List<Marker> markers = [];

  getMarkersOfPlaces() async {
    final Uint8List mapIcon =
        await getBytesFromMapIcons('assets/mapicons/location.png', 75);

    for (var place in widget.data) {
      double latitude = double.parse(place['latitude']!);
      double longitude = double.parse(place['longitude']!);

      markers.add(
        Marker(
          markerId: MarkerId(place['title']!),
          position: LatLng(latitude, longitude),
          icon: BitmapDescriptor.fromBytes(mapIcon),
        ),
      );
    }
  }

  List<PointLatLng> placesOrder = [];

  getPolyPoints() async {
    if (currentLocation != null) {
      polylineCoordinates.clear();
      polylines.clear();

      PointLatLng previousPoint = initialPosition;

      for (var place in widget.data) {
        double latitude = double.parse(place['latitude']!);
        double longitude = double.parse(place['longitude']!);

        PointLatLng currentPoint = PointLatLng(latitude, longitude);

        PolylineResult result =
            await createPolylines(previousPoint, currentPoint);

        if (result.points.isNotEmpty) {
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        }
        previousPoint = currentPoint;
      }

      setState(() {
        polylines.add(Polyline(
          polylineId: PolylineId('route'),
          points: polylineCoordinates,
          width: 4,
          color: Colors.blue,
        ));
      });
    }
  }

  Future<PolylineResult> createPolylines(
      PointLatLng start, PointLatLng end) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyD2wKv_Xj01cu7xfQ5Cf0Te5sroeB5K6iE",
      PointLatLng(
        start.latitude,
        start.longitude,
      ),
      PointLatLng(
        end.latitude,
        end.longitude,
      ),
    );
    return result;
  }

  @override
  void initState() {
    super.initState();
    polylineCoordinates = [];
    polylines = {};
    getCurrentLocation();
    getMarkersOfPlaces();
    // getPolyPoints();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/theme.json')
        .then((value) {
      mapStyle = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
            // mini: true,
            backgroundColor: kColor2,
            child: Icon(Icons.my_location),
            onPressed: currentLocation == null
                ? () {}
                : () async {
                    GoogleMapController currentcontroller =
                        await controller.future;
                    currentcontroller.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(currentLocation!.latitude!,
                                currentLocation!.longitude!),
                            zoom: 16)));
                    setState(() {});
                  }),
      ),
      body: currentLocation == null
          ? Center(
              child: CircularProgressIndicator(
              color: kColor1,
            ))
          : Stack(children: [
              GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(mapStyle);
                    this.controller.complete(controller);
                    numberOfPlaces = widget.data.length;
                    getPolyPoints();
                  },
                  initialCameraPosition:
                      CameraPosition(target: center, zoom: 16),
                  polylines: polylines,
                  markers: Set<Marker>.from(markers)),
            ]),
    );
  }
}
