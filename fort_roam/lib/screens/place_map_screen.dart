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

  static const LatLng center =
      const LatLng(6.028320555913446, 80.21670426593813);

  LocationData? currentLocation;
  List<Marker> markers = [];
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};

  late PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
    polylinePoints =
        PolylinePoints(apiKey: apiKey);

    getMarkerOfPlace();
    initializeMap();

    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/theme.json')
        .then((value) {
      mapStyle = value;
    });
  }

  Future<void> initializeMap() async {
    await getCurrentLocation();
    if (currentLocation != null) {
      await getPolyPoints();
    }
  }

  Future<void> getCurrentLocation() async {
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
    });
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

  Future<void> getMarkerOfPlace() async {
    try {
      final Uint8List mapIcon =
          await getBytesFromMapIcons('assets/mapicons/location.png', 75);

      Map<String, dynamic>? selectedPlace = widget.data.firstWhere(
        (place) => place['title'] == widget.title,
        orElse: () => {},
      );

      if (selectedPlace.isNotEmpty) {
        double latitude = double.parse(selectedPlace['latitude']!);
        double longitude = double.parse(selectedPlace['longitude']!);

        setState(() {
          markers.add(
            Marker(
              markerId: MarkerId(selectedPlace['title']!),
              position: LatLng(latitude, longitude),
              icon: BitmapDescriptor.fromBytes(mapIcon),
              infoWindow: InfoWindow(title: selectedPlace['title']),
            ),
          );
        });
      }
    } catch (e) {
      print('Error creating marker: $e');
    }
  }

  Future<void> getPolyPoints() async {
    try {
      if (currentLocation == null) {
        print('Current location is null');
        return;
      }

      Map<String, dynamic>? selectedPlace = widget.data.firstWhere(
        (place) => place['title'] == widget.title,
        orElse: () => {},
      );

      if (selectedPlace.isEmpty) {
        print('Selected place not found');
        return;
      }

      double latitude = double.parse(selectedPlace['latitude']!);
      double longitude = double.parse(selectedPlace['longitude']!);

      print(
          'Getting route from (${currentLocation!.latitude}, ${currentLocation!.longitude}) to ($latitude, $longitude)');

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: PointLatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          ),
          destination: PointLatLng(latitude, longitude),
          mode: TravelMode.driving,
        ),
      );

      if (result.points.isNotEmpty) {
        print('Route found with ${result.points.length} points');
        polylineCoordinates.clear();

        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }

        addPolyLines();
      } else if (result.errorMessage != null) {
        print('Error getting route: ${result.errorMessage}');
        _showError('Unable to get route: ${result.errorMessage}');
      } else {
        print('No route found');
        _showError('No route found between locations');
      }
    } catch (e) {
      print('Exception in getPolyPoints: $e');
      _showError('Error getting route: $e');
    }
  }

  void addPolyLines() {
    PolylineId id = PolylineId('route');
    Polyline polyline = Polyline(
      polylineId: id,
      color: const Color.fromARGB(255, 59, 130, 254),
      points: polylineCoordinates,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
    );

    setState(() {
      polylines.clear();
      polylines.add(polyline);
    });
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _animateToCurrentLocation() async {
    if (currentLocation == null) return;

    GoogleMapController mapController = await controller.future;
    mapController.animateCamera(
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
          onPressed: currentLocation == null ? null : _animateToCurrentLocation,
        ),
      ),
      body: currentLocation == null
          ? Center(
              child: CircularProgressIndicator(
                color: kColor1,
              ),
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

                    if (currentLocation != null) {
                      await getPolyPoints();
                    }
                  },
                  initialCameraPosition: CameraPosition(
                    target: currentLocation != null
                        ? LatLng(
                            currentLocation!.latitude!,
                            currentLocation!.longitude!,
                          )
                        : center,
                    zoom: 14,
                  ),
                  polylines: polylines,
                  markers: Set<Marker>.from(markers),
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
