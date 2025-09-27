import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:location/location.dart';
import '../components/app_bar2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;

class PlaceMapScreen extends StatefulWidget {
  PlaceMapScreen({this.title, required this.data});

  final String? title;
  final List<Map<String, dynamic>> data;

  @override
  State<PlaceMapScreen> createState() => _PlaceMapScreenState();
  static String id = 'map_screen';
}

class _PlaceMapScreenState extends State<PlaceMapScreen> {
  String mapStyle = '';

  final Completer<GoogleMapController> controller = Completer();

  // List<Map<String, dynamic>> data = [];

  // getData() async {
  //   data = await MongoDatabase.getData();
  // }

  static const LatLng center =
      const LatLng(6.028320555913446, 80.21670426593813);

  LocationData? currentLocation;

  Future<void> getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((value) {
      setState(() {
        currentLocation = value;
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

  getMarkerOfPlace() async {
    final Uint8List mapIcon =
        await getBytesFromMapIcons('assets/mapicons/location.png', 75);

    Map<String, dynamic> selectedPlace =
        widget.data.firstWhere((place) => place['title'] == widget.title);

    if (selectedPlace != null) {
      double latitude = double.parse(selectedPlace['latitude']!);
      double longitude = double.parse(selectedPlace['longitude']!);

      markers.add(
        Marker(
          markerId: MarkerId(selectedPlace['title']!),
          position: LatLng(latitude, longitude),
          icon: BitmapDescriptor.fromBytes(mapIcon),
        ),
      );
    } else {
      markers = [];
    }
  }

  List<LatLng> polylineCoordinates = [];
  // Map<PolylineId, Polyline> polylines = {};
  Set<Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  getPolyPoints() async {
    Map<String, dynamic> selectedPlace =
        widget.data.firstWhere((place) => place['title'] == widget.title);

    double latitude = double.parse(selectedPlace['latitude']!);
    double longitude = double.parse(selectedPlace['longitude']!);

    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAGnLkryMMC285KzEIT_lJNoZz1x_MXQK0",
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(latitude, longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      addPolyLines();
      // setState(() {});
    }
  }

  addPolyLines() {
    PolylineId id = PolylineId('route');
    Polyline polyline = Polyline(
        polylineId: id,
        color: const Color.fromARGB(255, 59, 130, 254),
        points: polylineCoordinates,
        width: 4);
    // polylines[id] = polyline;
    polylines.add(polyline);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getMarkerOfPlace();
    getPolyPoints();

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
            foregroundColor: Colors.white,
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
                    getPolyPoints();
                  },
                  initialCameraPosition:
                      CameraPosition(target: center, zoom: 16),
                  // polylines:
                  //   Polyline(
                  //     polylineId: PolylineId('route'),
                  //     points: polylineCoordinates,
                  //     color: Colors.red,
                  //     width: 5,
                  //   ),
                  // },
                  // polylines: widget.title != null
                  //     ? Set<Polyline>.from(getPolyPoints())
                  //     : {},
                  polylines: polylines,

                  // markers: Set<Marker>.from(markers),
                  markers: Set<Marker>.from(markers)),
            ]),
    );
  }
}
