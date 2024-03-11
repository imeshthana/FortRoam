import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/navigation_bar.dart';
import 'package:location/location.dart';
import '../components/app_bar1.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';

class MapScreen extends StatefulWidget {
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

  static const LatLng center =
      const LatLng(6.028781529705348, 80.21649439316992);

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAGnLkryMMC285KzEIT_lJNoZz1x_MXQK0",
      PointLatLng(7.2908125249864995, 80.6330677699703),
      PointLatLng(7.284171810907195, 80.62633006135113),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

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

  infoWindow(double latitude, double longitude, Map<String, String> place) {
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
              Container(
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
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  place['title']!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
                height: 5,
              ),
            ]),
      ),
      LatLng(latitude, longitude),
    );
  }

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

    for (var place in places) {
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

    // if (currentLocation != null) {
    //   markers.add(
    //     Marker(
    //       markerId: MarkerId("currentlocation"),
    //       position:
    //           LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(
    //         BitmapDescriptor.hueAzure,
    //       ),
    //     ),
    //   );
    // }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    loadData();
    // getPolyPoints();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/theme.json')
        .then((value) {
      mapStyle = value;
    });
  }

  final GlobalKey avatarGlowKey = GlobalKey();

  Future<Uint8List> getBytesFromMicIcon() async {
    final avatarGlow = AvatarGlow(
      key: avatarGlowKey,
      glowRadiusFactor: 0.7,
      animate: true,
      duration: Duration(milliseconds: 1000),
      repeat: true,
      glowColor: kColor1,
      startDelay: Duration(milliseconds: 1000),
      child: Icon(
        Icons.mic,
        color: kColor1,
        size: 30,
      ),
    );

    final avatarGlowImage = await _captureImage(avatarGlow);

    return Uint8List.fromList(avatarGlowImage);
  }

  Future<Uint8List> _captureImage(Widget widget) async {
    final RenderRepaintBoundary boundary = RenderRepaintBoundary();
    final RenderBox renderBox = (widget.key as GlobalKey)
        .currentContext!
        .findRenderObject() as RenderBox;
    final ui.Image img = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await img.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return uint8List;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 252, 125, 93),
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
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle(mapStyle);
                  this.controller.complete(controller);
                  customInfoWindowController.googleMapController = controller;
                },
                initialCameraPosition: CameraPosition(target: center, zoom: 16),
                // polylines: {
                //   Polyline(
                //     polylineId: PolylineId('route'),
                //     points: polylineCoordinates,
                //     color: Colors.red,
                //     width: 5,
                //   ),
                // },
                markers: Set<Marker>.from(markers),
                onTap: (position) {
                  customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  customInfoWindowController.onCameraMove!();
                },
              ),
              CustomInfoWindow(
                controller: customInfoWindowController,
                height: 160,
                width: 150,
                offset: 50,
              )
            ]),
    );
  }
}
