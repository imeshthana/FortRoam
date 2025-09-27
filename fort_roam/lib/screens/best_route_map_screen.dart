import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/dbHelper/fav_places.dart';
import 'package:fort_roam/screens/place_map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import '../components/app_bar2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'dart:ui' as ui;
import 'dart:math' show cos, sqrt, asin;

class BestRouteMapScreen extends StatefulWidget {
  BestRouteMapScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;

  @override
  State<BestRouteMapScreen> createState() => _BestRouteMapScreenState();
  static String id = 'map_screen';
}

class _BestRouteMapScreenState extends State<BestRouteMapScreen> {
  String mapStyle = '';
  final FavPlaces db = FavPlaces();
  late List<String> favoritePlaces;
  late List<Map<String, dynamic>> places;

  final Completer<GoogleMapController> controller = Completer();
  CustomInfoWindowController? customInfoWindowController;

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

    for (var place in places) {
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
  }

  List<PointLatLng> placesOrder = [];

  getPlaceOrder() async {
    PointLatLng previousPoint = initialPosition;
    PointLatLng closedPoint = initialPosition;

    for (int i = 0; i < numberOfPlaces; i++) {
      double distance = 100000000000.0;

      for (var place in places) {
        double latitude = double.parse(place['latitude']!);
        double longitude = double.parse(place['longitude']!);

        PointLatLng currentPoint = PointLatLng(latitude, longitude);

        double distanceBetween = calculateDistance(
            previousPoint.latitude,
            previousPoint.longitude,
            currentPoint.latitude,
            currentPoint.longitude);

        if (distanceBetween < distance) {
          distance = distanceBetween;
          closedPoint = currentPoint;
        } else {
          continue;
        }
      }
      places.removeWhere((element) =>
          element['latitude'] == closedPoint.latitude.toString() &&
          element['longitude'] == closedPoint.longitude.toString());
      previousPoint = closedPoint;
      placesOrder.add(closedPoint);
    }
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  getPolyPoints() async {
    if (currentLocation != null) {
      polylineCoordinates.clear();
      polylines.clear();

      PointLatLng previousPoint = initialPosition;

      for (var place in placesOrder) {
        // double latitude = double.parse(place['latitude']!);
        // double longitude = double.parse(place['longitude']!);

        PointLatLng currentPoint = PointLatLng(place.latitude, place.longitude);

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
      "AIzaSyAGnLkryMMC285KzEIT_lJNoZz1x_MXQK0",
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

  infoWindow(double latitude, double longitude, Map<String, dynamic> place) {
    final UniqueKey titleHeroTag = UniqueKey();
    final UniqueKey imageHeroTag = UniqueKey();

    customInfoWindowController?.addInfoWindow!(
      Container(
        height: 400,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: const Color.fromRGBO(226, 94, 62, 1), width: 2),
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
              SizedBox(
                height: 10,
              ),
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
              SizedBox(
                height: 5,
              ),
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
              SizedBox(
                height: 10,
              ),
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
                                // image: place['image']!,
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
                            ));
                      },
                      height: 2,
                      child: Text(
                        'More Info',
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
                                reverseDuration: Duration(milliseconds: 500)));
                      },
                      child: Icon(
                        Icons.directions,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              )
            ]),
      ),
      LatLng(latitude, longitude),
    );
  }

  @override
  void initState() {
    super.initState();
    favoritePlaces = db.getFavoritePlaces();
    places = widget.data
        .where((place) => favoritePlaces.contains(place['title']))
        .toList();
    polylineCoordinates = [];
    polylines = {};
    getCurrentLocation();
    getMarkersOfPlaces();
    customInfoWindowController = CustomInfoWindowController();
    getPlaceOrder();
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
                  numberOfPlaces = places.length;
                  customInfoWindowController!.googleMapController = controller;
                  getPlaceOrder();
                  getPolyPoints();
                },
                initialCameraPosition: CameraPosition(target: center, zoom: 16),
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
              )
            ]),
    );
  }
}
