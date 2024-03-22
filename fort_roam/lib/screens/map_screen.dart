import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/navigation_bar.dart';
import 'package:fort_roam/dbHelper/mongodb.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import '../components/app_bar2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';

class MapScreen extends StatefulWidget {
  MapScreen({this.title, required this.data});

  final String? title;
  final List<Map<String, dynamic>> data;

  @override
  State<MapScreen> createState() => _MapScreenState();
  static String id = 'map_screen';
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  String mapStyle = '';

  Uint8List? markerIcon;
  Uint8List? currentlocationmarkerAnimation;

  late final AnimationController animationController;
  late final Animation<double> markerAnimation;

  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

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

  infoWindow(double latitude, double longitude, Map<String, dynamic> place) {
    final UniqueKey titleHeroTag = UniqueKey();
    final UniqueKey imageHeroTag = UniqueKey();
    customInfoWindowController.addInfoWindow!(
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
                      image: Image.asset(place['image'].toString()).image,
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
                                image: place['image']!,
                                title: place['title']!,
                                titleHeroTag: titleHeroTag,
                                imageHeroTag: imageHeroTag,
                                onShowPlaceOnMap: true,
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
                                child: MapScreen(
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

  loadData() async {
    final Uint8List mapIcon1 =
        await getBytesFromMapIcons('assets/mapicons/shop.png', 75);
    final Uint8List mapIcon2 =
        await getBytesFromMapIcons('assets/mapicons/hotel.png', 75);
    final Uint8List mapIcon3 =
        await getBytesFromMapIcons('assets/mapicons/restuarant.png', 75);
    final Uint8List mapIcon4 =
        await getBytesFromMapIcons('assets/mapicons/support.png', 75);
    final Uint8List mapIcon5 =
        await getBytesFromMapIcons('assets/mapicons/museum.png', 75);
    final Uint8List mapIcon6 =
        await getBytesFromMapIcons('assets/mapicons/activity.png', 75);

    for (var place in widget.data) {
      List<Marker> placeMarkers = [];

      double latitude = double.parse(place['latitude']!);
      double longitude = double.parse(place['longitude']!);

      switch (place['type']) {
        case 'commercial':
          switch (place['subtype']) {
            case 'hotel':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(mapIcon2),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;
            case 'restaurant':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(mapIcon3),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;
            case 'shop':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(mapIcon1),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;
          }
          break;

        case 'historical':
          placeMarkers.add(
            Marker(
              markerId: MarkerId(place['title']!),
              position: LatLng(latitude, longitude),
              icon: BitmapDescriptor.fromBytes(mapIcon5),
              onTap: () => infoWindow(latitude, longitude, place),
            ),
          );
          break;

        case 'activities':
          placeMarkers.add(
            Marker(
              markerId: MarkerId(place['title']!),
              position: LatLng(latitude, longitude),
              icon: BitmapDescriptor.fromBytes(mapIcon6),
              onTap: () => infoWindow(latitude, longitude, place),
            ),
          );
          break;

        default:
          break;
      }

      markers.addAll(placeMarkers);
    }
    setState(() {});
  }

  String selectedCategory = 'historical';

  List<Marker> getMarkerOfPlace() {
    Map<String, dynamic> selectedPlace =
        widget.data.firstWhere((place) => place['title'] == widget.title);

    if (selectedPlace != null) {
      double latitude = double.parse(selectedPlace['latitude']!);
      double longitude = double.parse(selectedPlace['longitude']!);

      return [
        Marker(
          markerId: MarkerId(selectedPlace['title']!),
          position: LatLng(latitude, longitude),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () => infoWindow(latitude, longitude, selectedPlace),
        ),
      ];
    } else {
      return [];
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
      "AIzaSyD2wKv_Xj01cu7xfQ5Cf0Te5sroeB5K6iE",
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

  List<Marker> getFilteredMarkers() {
    return markers.where((marker) {
      Map<String, dynamic> place = widget.data.firstWhere(
        (place) => marker.markerId.value == place['title'],
      );
      if (place['subtype'] == 'museum' ||
          place['subtype'] == 'bastion' ||
          place['subtype'] == 'others')
        return selectedCategory == 'historical';
      else
        return place['subtype'] == selectedCategory;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    loadData();
    if (widget.title != null) {
      getPolyPoints();
    }
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/theme.json')
        .then((value) {
      mapStyle = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.title != null ? CustomAppBar() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: widget.title == null
          ? Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: SpeedDial(
                    // mini: true,
                    animatedIcon: AnimatedIcons.menu_close,
                    direction: SpeedDialDirection.down,
                    backgroundColor: kColor2,
                    overlayOpacity: 0,
                    children: [
                      SpeedDialChild(
                        foregroundColor: kColor1,
                        child: Icon(Icons.account_balance),
                        // label: 'Historical',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'historical';
                          });
                        },
                      ),
                      SpeedDialChild(
                        foregroundColor: kColor1,
                        child: Icon(Icons.restaurant),
                        // label: 'Restaurants',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'restaurant';
                          });
                        },
                      ),
                      SpeedDialChild(
                        foregroundColor: kColor1,
                        child: Icon(Icons.pedal_bike),
                        // label: 'Activities',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'activity';
                          });
                        },
                      ),
                      SpeedDialChild(
                        foregroundColor: kColor1,
                        child: Icon(Icons.shopping_cart),
                        // label: 'Shops',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'shop';
                          });
                        },
                      ),
                      SpeedDialChild(
                        foregroundColor: kColor1,
                        child: Icon(Icons.h_mobiledata_rounded),
                        // label: 'Hotels',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'hotel';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(bottom: 0),
                  child: FloatingActionButton(
                      mini: true,
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
              ],
            )
          : Container(
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
                  customInfoWindowController.googleMapController = controller;
                  getPolyPoints();
                },
                initialCameraPosition: CameraPosition(target: center, zoom: 16),
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
                markers: widget.title != null
                    ? Set<Marker>.from(getMarkerOfPlace())
                    : Set<Marker>.from(getFilteredMarkers()),
                onTap: (position) {
                  customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  customInfoWindowController.onCameraMove!();
                },
              ),
              CustomInfoWindow(
                controller: customInfoWindowController,
                height: 230,
                width: 200,
                offset: 50,
              )
            ]),
    );
  }
}
