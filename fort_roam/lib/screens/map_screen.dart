import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/screens/place_map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;

  static String id = 'map_screen';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

enum Category { historical, restaurant, activity, shop, hotel, services }

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _mapController = Completer();
  final CustomInfoWindowController _infoCtrl = CustomInfoWindowController();

  static const LatLng _center = LatLng(6.028320555913446, 80.21670426593813);

  String _mapStyleJson = '';
  Category _selectedCategory = Category.historical;
  LocationData? _currentLocation;

  final Map<String, Map<String, dynamic>> _placeByMarkerId = {};
  final Set<Marker> _allMarkers = <Marker>{};
  final Map<String, Uint8List> _iconCache = {}; 

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadMapStyle();
  }

  @override
  void dispose() {
    _infoCtrl.dispose();
    super.dispose();
  }

  Future<void> _initAsync() async {
    await Future.wait([
      _ensureLocation(),
      _preloadMapIcons(),
    ]);

    _buildMarkersOnce(); 
    if (mounted) setState(() {});
  }

  Future<void> _ensureLocation() async {
    final location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) serviceEnabled = await location.requestService();

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (serviceEnabled &&
        (permissionGranted == PermissionStatus.granted ||
            permissionGranted == PermissionStatus.grantedLimited)) {
      _currentLocation = await location.getLocation();
    } else {
      _currentLocation = null; 
    }
  }

  Future<void> _loadMapStyle() async {
    if (_mapStyleJson.isNotEmpty) return;
    final json = await DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/theme.json');
    setState(() => _mapStyleJson = json);
  }

  Future<void> _preloadMapIcons() async {
    Future<Uint8List> load(String asset, int size) async {
      final data = await rootBundle.load(asset);
      final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: size,
        targetHeight: size,
      );
      final fi = await codec.getNextFrame();
      final bytes =
          (await fi.image.toByteData(format: ui.ImageByteFormat.png))!;
      return bytes.buffer.asUint8List();
    }

    if (_iconCache.isNotEmpty) return;

    const size = 85;
    _iconCache.addAll({
      'shop': await load('assets/mapicons/shop.png', size),
      'hotel': await load('assets/mapicons/hotel.png', size),
      'restaurant': await load('assets/mapicons/restuarant.png', size),
      'support': await load('assets/mapicons/support.png', size),
      'museum': await load('assets/mapicons/museum.png', size),
      'activity': await load('assets/mapicons/activity.png', size),
      'parking': await load('assets/mapicons/parking.png', size),
      'bank': await load('assets/mapicons/bank.png', size),
      'taxi': await load('assets/mapicons/taxi.png', size),
      'school': await load('assets/mapicons/school.png', size),
      'post': await load('assets/mapicons/post.png', size),
    });
  }

  void _buildMarkersOnce() {
    final uuid = const Uuid();

    for (final place in widget.data) {
      final lat = double.tryParse('${place['latitude']}');
      final lng = double.tryParse('${place['longitude']}');
      if (lat == null || lng == null) continue;

      final markerId =
          '${place['title']}_${place['latitude']}_${place['longitude']}';

      final icon = _iconFor(place);
      if (icon == null) continue;

      _placeByMarkerId[markerId] = place;

      _allMarkers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.fromBytes(icon),
          onTap: () => _showInfoWindow(lat, lng, place),
        ),
      );
    }
  }

  Uint8List? _iconFor(Map<String, dynamic> place) {
    final type = '${place['type']}'.trim().toLowerCase();
    final subtype = '${place['subtype']}'.trim().toLowerCase();

    switch (type) {
      case 'commercial':
        if (subtype == 'hotel') return _iconCache['hotel'];
        if (subtype == 'restaurant') return _iconCache['restaurant'];
        if (subtype == 'shop') return _iconCache['shop'];
        return null;

      case 'historical':
        return _iconCache['museum'];

      case 'activities':
        return _iconCache['activity'];

      case 'services':
        switch (subtype) {
          case 'police':
            return _iconCache['support'];
          case 'bank':
            return _iconCache['bank'];
          case 'school':
            return _iconCache['school'];
          case 'post':
            return _iconCache['post'];
          case 'parking':
            return _iconCache['parking'];
          case 'taxi':
            return _iconCache['taxi'];
          default:
            return null;
        }

      default:
        return null;
    }
  }

  Set<Marker> get _filteredMarkers {
    return _allMarkers.where((m) {
      final place = _placeByMarkerId[m.markerId.value];
      if (place == null) return false;

      final subtype = '${place['subtype']}'.toLowerCase();
      switch (_selectedCategory) {
        case Category.historical:
          return subtype == 'museum' ||
              subtype == 'bastion' ||
              subtype == 'others';
        case Category.services:
          return ['post', 'police', 'bank', 'parking', 'school', 'taxi']
              .contains(subtype);
        case Category.restaurant:
          return subtype == 'restaurant';
        case Category.activity:
          return subtype == 'activity';
        case Category.shop:
          return subtype == 'shop';
        case Category.hotel:
          return subtype == 'hotel';
      }
    }).toSet();
  }

  void _showInfoWindow(double lat, double lng, Map<String, dynamic> place) {
    final titleHeroTag = UniqueKey();
    final imageHeroTag = UniqueKey();

    _infoCtrl.addInfoWindow!(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: imageHeroTag,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                child: SizedBox(
                  width: 400,
                  height: 100,
                  child: Image.network(
                    '${place['image']}',
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.white),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image,
                          color: Colors.grey[600], size: 40),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Hero(
                tag: titleHeroTag,
                child: Text(
                  '${place['title']}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                '${place['subtype']}'.toUpperCase(),
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  color: kColor1,
                  borderRadius: BorderRadius.circular(50.0),
                  child: MaterialButton(
                    padding: const EdgeInsets.all(0.5),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: PlaceScreen(
                            title: '${place['title']}',
                            qrPlace: false,
                            titleHeroTag: titleHeroTag,
                            imageHeroTag: imageHeroTag,
                            data: widget.data,
                          ),
                          type: PageTransitionType.bottomToTop,
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 500),
                          reverseDuration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: const Text('More Info',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 6),
                Material(
                  color: kColor1,
                  shape: const CircleBorder(),
                  child: MaterialButton(
                    padding: const EdgeInsets.all(0.5),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: PlaceMapScreen(
                              title: '${place['title']}', data: widget.data),
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 500),
                          reverseDuration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: const Icon(Icons.directions,
                        color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      LatLng(lat, lng),
    );
  }

  Future<void> _animateTo(LatLng target, {double zoom = 16}) async {
    final ctrl = await _mapController.future;
    await ctrl.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoom)));
  }

  Future<void> _jumpToCenterAnd(Category category) async {
    _infoCtrl.hideInfoWindow!();
    await _animateTo(_center);
    if (!mounted) return;
    setState(() => _selectedCategory = category);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final loading = _currentLocation == null && _allMarkers.isEmpty;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              direction: SpeedDialDirection.down,
              backgroundColor: kColor2,
              foregroundColor: Colors.white,
              overlayOpacity: 0,
              children: [
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(Icons.account_balance,
                      size: MediaQuery.of(context).size.height * 0.035),
                  onTap: () => _jumpToCenterAnd(Category.historical),
                ),
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(Icons.restaurant,
                      size: MediaQuery.of(context).size.height * 0.035),
                  onTap: () => _jumpToCenterAnd(Category.restaurant),
                ),
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(Icons.pedal_bike,
                      size: MediaQuery.of(context).size.height * 0.035),
                  onTap: () => _jumpToCenterAnd(Category.activity),
                ),
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(Icons.shopping_cart,
                      size: MediaQuery.of(context).size.height * 0.035),
                  onTap: () => _jumpToCenterAnd(Category.shop),
                ),
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(Icons.h_mobiledata_rounded,
                      size: MediaQuery.of(context).size.height * 0.05),
                  onTap: () => _jumpToCenterAnd(Category.hotel),
                ),
                SpeedDialChild(
                  foregroundColor: kColor1,
                  child: Icon(Icons.safety_check,
                      size: MediaQuery.of(context).size.height * 0.04),
                  onTap: () => _jumpToCenterAnd(Category.services),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            child: FloatingActionButton(
              mini: true,
              backgroundColor: kColor2,
              foregroundColor: Colors.white,
              onPressed: _currentLocation == null
                  ? null
                  : () => _animateTo(LatLng(_currentLocation!.latitude!,
                      _currentLocation!.longitude!)),
              child: Icon(Icons.my_location,
                  size: MediaQuery.of(context).size.height * 0.035),
            ),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator(color: kColor1))
          : Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition:
                      const CameraPosition(target: _center, zoom: 16),
                  markers: _filteredMarkers,
                  onTap: (_) => _infoCtrl.hideInfoWindow!(),
                  onCameraMove: (_) => _infoCtrl.onCameraMove!(),
                  onMapCreated: (GoogleMapController ctrl) {
                    if (_mapStyleJson.isNotEmpty) {
                      ctrl.setMapStyle(_mapStyleJson);
                    }
                    if (!_mapController.isCompleted) {
                      _mapController.complete(ctrl);
                    }
                    _infoCtrl.googleMapController = ctrl;
                  },
                ),
                CustomInfoWindow(
                  controller: _infoCtrl,
                  height: 230,
                  width: 200,
                  offset: 50,
                ),
              ],
            ),
    );
  }
}
