import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/screens/place_map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import '../components/app_bar2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;

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
  CustomInfoWindowController? customInfoWindowController;

  static const LatLng center = LatLng(6.028320555913446, 80.21670426593813);

  LocationData? currentLocation;
  late PointLatLng initialPosition;

  late int numberOfPlaces;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};
  List<Marker> markers = [];

  late PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
    customInfoWindowController = CustomInfoWindowController();
    initializeMapData();

    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/theme.json')
        .then((value) {
      mapStyle = value;
    });
  }

  Future<void> initializeMapData() async {
    await getCurrentLocation();
    await getMarkersOfPlaces();
  }

  Future<void> getCurrentLocation() async {
    try {
      Location location = Location();

      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return;
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      final locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
        initialPosition =
            PointLatLng(locationData.latitude!, locationData.longitude!);
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<Uint8List> getBytesFromMapIcons(String path, int size) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: size,
      targetWidth: size,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> getMarkersOfPlaces() async {
    try {
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
            onTap: () => infoWindow(latitude, longitude, place),
          ),
        );
      }
      setState(() {});
    } catch (e) {
      print('Error creating markers: $e');
    }
  }

  Future<void> getPolyPoints() async {
    if (currentLocation == null || widget.data.isEmpty) {
      print('Cannot get polylines: location or data is empty');
      return;
    }

    try {
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
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
        } else if (result.errorMessage != null) {
          print('Route error: ${result.errorMessage}');
        }

        previousPoint = currentPoint;
      }

      if (polylineCoordinates.isNotEmpty) {
        setState(() {
          polylines.add(Polyline(
            polylineId: PolylineId('custom_route'),
            points: polylineCoordinates,
            width: 5,
            color: const Color.fromARGB(255, 59, 130, 254),
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            jointType: JointType.round,
          ));
        });
      }
    } catch (e) {
      print('Error in getPolyPoints: $e');
    }
  }

  Future<PolylineResult> createPolylines(
      PointLatLng start, PointLatLng end) async {
    try {
      polylinePoints =
          PolylinePoints(apiKey: apiKey);

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: start,
          destination: end,
          mode: TravelMode.driving,
        ),
      );

      return result;
    } catch (e) {
      print('Error creating polyline: $e');
      return PolylineResult(errorMessage: e.toString());
    }
  }

  void infoWindow(
      double latitude, double longitude, Map<String, dynamic> place) {
    final UniqueKey titleHeroTag = UniqueKey();
    final UniqueKey imageHeroTag = UniqueKey();

    customInfoWindowController?.addInfoWindow!(
      Container(
        height: 400,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromRGBO(226, 94, 62, 1),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: imageHeroTag,
              child: Container(
                width: 400,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(place['image']!.toString()),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Hero(
                tag: titleHeroTag,
                child: Text(
                  place['title']!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                place['subtype']!.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  color: kColor1,
                  borderRadius: BorderRadius.circular(50.0),
                  child: MaterialButton(
                    padding: EdgeInsets.all(0.5),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: PlaceScreen(
                            title: place['title']!,
                            qrPlace: false,
                            titleHeroTag: titleHeroTag,
                            imageHeroTag: imageHeroTag,
                            data: widget.data,
                          ),
                          type: PageTransitionType.bottomToTop,
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 500),
                          reverseDuration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                    height: 2,
                    child: Text(
                      'More Info',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 0),
                Material(
                  color: kColor1,
                  shape: CircleBorder(),
                  child: MaterialButton(
                    padding: EdgeInsets.all(0.5),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: PlaceMapScreen(
                            title: place['title']!,
                            data: widget.data,
                          ),
                          type: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 500),
                          reverseDuration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.directions,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      LatLng(latitude, longitude),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          backgroundColor: kColor2,
          foregroundColor: Colors.white,
          child: Icon(Icons.my_location),
          onPressed: currentLocation == null
              ? null
              : () async {
                  GoogleMapController currentController =
                      await controller.future;
                  currentController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                          currentLocation!.latitude!,
                          currentLocation!.longitude!,
                        ),
                        zoom: 16,
                      ),
                    ),
                  );
                },
        ),
      ),
      body: currentLocation == null
          ? Center(
              child: CircularProgressIndicator(color: kColor1),
            )
          : Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController mapController) async {
                    mapController.setMapStyle(mapStyle);
                    controller.complete(mapController);
                    customInfoWindowController!.googleMapController =
                        mapController;

                    numberOfPlaces = widget.data.length;
                    await getPolyPoints();
                  },
                  initialCameraPosition: CameraPosition(
                    target: currentLocation != null
                        ? LatLng(
                            currentLocation!.latitude!,
                            currentLocation!.longitude!,
                          )
                        : center,
                    zoom: 13,
                  ),
                  polylines: polylines,
                  markers: Set<Marker>.from(markers),
                  onTap: (position) {
                    customInfoWindowController!.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    customInfoWindowController!.onCameraMove!();
                  },
                ),
                CustomInfoWindow(
                  controller: customInfoWindowController!,
                  height: 230,
                  width: 200,
                  offset: 50,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.refresh, color: kColor2),
                    onPressed: () async {
                      await getCurrentLocation();
                      await getPolyPoints();
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
