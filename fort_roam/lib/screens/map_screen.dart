import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/screens/place_map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';

class MapScreen extends StatefulWidget {
  MapScreen({required this.data});

  final List<Map<String, dynamic>> data;

  @override
  State<MapScreen> createState() => _MapScreenState();
  static String id = 'map_screen';
}

class _MapScreenState extends State<MapScreen> {
  String mapStyle = '';
  String selectedCategory = 'historical';

  CustomInfoWindowController? customInfoWindowController;

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

  loadMarkers() async {
    final Uint8List shop =
        await getBytesFromMapIcons('assets/mapicons/shop.png', 85);
    final Uint8List hotel =
        await getBytesFromMapIcons('assets/mapicons/hotel.png', 85);
    final Uint8List restuarant =
        await getBytesFromMapIcons('assets/mapicons/restuarant.png', 85);
    final Uint8List support =
        await getBytesFromMapIcons('assets/mapicons/support.png', 85);
    final Uint8List musuem =
        await getBytesFromMapIcons('assets/mapicons/museum.png', 85);
    final Uint8List activity =
        await getBytesFromMapIcons('assets/mapicons/activity.png', 85);
    final Uint8List parking =
        await getBytesFromMapIcons('assets/mapicons/parking.png', 85);
    final Uint8List bank =
        await getBytesFromMapIcons('assets/mapicons/bank.png', 85);
    final Uint8List taxi =
        await getBytesFromMapIcons('assets/mapicons/taxi.png', 85);
    final Uint8List school =
        await getBytesFromMapIcons('assets/mapicons/school.png', 85);
    final Uint8List post =
        await getBytesFromMapIcons('assets/mapicons/post.png', 85);

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
                  icon: BitmapDescriptor.fromBytes(hotel),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;
            case 'restaurant':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(restuarant),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;
            case 'shop':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(shop),
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
              icon: BitmapDescriptor.fromBytes(musuem),
              onTap: () => infoWindow(latitude, longitude, place),
            ),
          );
          break;

        case 'activities':
          placeMarkers.add(
            Marker(
              markerId: MarkerId(place['title']!),
              position: LatLng(latitude, longitude),
              icon: BitmapDescriptor.fromBytes(activity),
              onTap: () => infoWindow(latitude, longitude, place),
            ),
          );
          break;

        case 'services':
          switch (place['subtype']) {
            case 'police':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(support),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;
            case 'bank':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(bank),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;
            case 'school':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(school),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;
            case 'post':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(post),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;
            case 'parking':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(parking),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;

            case 'taxi':
              placeMarkers.add(
                Marker(
                  markerId: MarkerId(place['title']!),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.fromBytes(taxi),
                  onTap: () => infoWindow(latitude, longitude, place),
                ),
              );
              break;
          }
          break;

        default:
          break;
      }
      markers.addAll(placeMarkers);
    }
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
      else if (place['subtype'] == 'post' ||
          place['subtype'] == 'police' ||
          place['subtype'] == 'bank' ||
          place['subtype'] == 'parking' ||
          place['subtype'] == 'school' ||
          place['subtype'] == 'taxi')
        return selectedCategory == 'services';
      else
        return place['subtype'] == selectedCategory;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    selectedCategory = 'historical';
    getCurrentLocation();
    customInfoWindowController = CustomInfoWindowController();
    loadMarkers();
    getFilteredMarkers();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/theme.json')
        .then((value) {
      mapStyle = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Column(
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
                  child: Icon(
                    Icons.account_balance,
                    size: MediaQuery.of(context).size.height * 0.035,
                  ),
                  // label: 'Historical',
                  onTap: () {
                    setState(() {
                      selectedCategory = 'historical';
                    });
                  },
                ),
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(
                    Icons.restaurant,
                    size: MediaQuery.of(context).size.height * 0.035,
                  ),
                  // label: 'Restaurants',
                  onTap: () {
                    setState(() {
                      selectedCategory = 'restaurant';
                    });
                  },
                ),
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(
                    Icons.pedal_bike,
                    size: MediaQuery.of(context).size.height * 0.035,
                  ),
                  // label: 'Activities',
                  onTap: () {
                    setState(() {
                      selectedCategory = 'activity';
                    });
                  },
                ),
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(
                    Icons.shopping_cart,
                    size: MediaQuery.of(context).size.height * 0.035,
                  ),
                  // label: 'Shops',
                  onTap: () {
                    setState(() {
                      selectedCategory = 'shop';
                    });
                  },
                ),
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(
                    Icons.h_mobiledata_rounded,
                    size: MediaQuery.of(context).size.height * 0.05,
                  ),
                  // label: 'Hotels',
                  onTap: () {
                    setState(() {
                      selectedCategory = 'hotel';
                    });
                  },
                ),
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(
                    Icons.safety_check,
                    size: MediaQuery.of(context).size.height * 0.04,
                  ),
                  // label: 'Hotels',
                  onTap: () {
                    setState(() {
                      selectedCategory = 'services';
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
                child: Icon(
                  Icons.my_location,
                  size: MediaQuery.of(context).size.height * 0.035,
                ),
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
                  customInfoWindowController!.googleMapController = controller;
                  loadMarkers();
                },
                initialCameraPosition: CameraPosition(target: center, zoom: 16),
                // markers: Set<Marker>.from(markers),
                markers: Set<Marker>.from(getFilteredMarkers()),
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
