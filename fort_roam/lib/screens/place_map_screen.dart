import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../components/app_bar2.dart';

class PlaceMapScreen extends StatefulWidget {
  const PlaceMapScreen({super.key, this.title, required this.data});

  final String? title;
  final List<Map<String, dynamic>> data;

  static String id = 'map_screen';

  @override
  State<PlaceMapScreen> createState() => _PlaceMapScreenState();
}

class _PlaceMapScreenState extends State<PlaceMapScreen> {
  static const LatLng _fallbackCenter =
      LatLng(6.028320555913446, 80.21670426593813);

  final Completer<GoogleMapController> _mapCtrl = Completer();
  String _mapStyleJson = '';

  LocationData? _currentLocation;
  Map<String, dynamic>? _selectedPlace;
  final Set<Marker> _markers = <Marker>{};
  final Set<Polyline> _polylines = <Polyline>{};
  final List<LatLng> _polylineCoordinates = <LatLng>[];

  Uint8List? _placeIconBytes;

  late final PolylinePoints _polylinePoints = PolylinePoints(apiKey: apiKey);

  @override
  void initState() {
    super.initState();
    _selectedPlace = _findSelectedPlace();
    _initAsync();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadMapStyleOnce();
  }

  @override
  void dispose() {
    () async {
      if (_mapCtrl.isCompleted) {
        final ctrl = await _mapCtrl.future;
        ctrl.dispose();
      }
    }();
    super.dispose();
  }

  Future<void> _initAsync() async {
    await Future.wait([
      _ensureLocation(),
      _loadPlaceIcon(),
    ]);

    _buildSelectedPlaceMarker();
    await _buildRouteIfPossible();

    if (mounted) setState(() {});
  }

  Map<String, dynamic>? _findSelectedPlace() {
    if (widget.title == null) return null;
    try {
      return widget.data.firstWhere(
        (p) => (p['title'] ?? '').toString() == widget.title,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _loadMapStyleOnce() async {
    if (_mapStyleJson.isNotEmpty) return;
    final json = await DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/theme.json');
    if (mounted) setState(() => _mapStyleJson = json);
  }

  Future<void> _loadPlaceIcon() async {
    if (_placeIconBytes != null) return;
    _placeIconBytes =
        await _decodePngToBytes('assets/mapicons/location.png', 75);
  }

  Future<Uint8List> _decodePngToBytes(String assetPath, int size) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: size,
      targetWidth: size,
    );
    final frame = await codec.getNextFrame();
    final bytes =
        (await frame.image.toByteData(format: ui.ImageByteFormat.png))!;
    return bytes.buffer.asUint8List();
  }

  // ---------- Helpers: location & camera ----------
  Future<void> _ensureLocation() async {
    final location = Location();

    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    var perm = await location.hasPermission();
    if (perm == PermissionStatus.denied) {
      perm = await location.requestPermission();
      if (perm != PermissionStatus.granted &&
          perm != PermissionStatus.grantedLimited) return;
    }

    _currentLocation = await location.getLocation();
  }

  Future<void> _animateTo(LatLng target, {double zoom = 16}) async {
    if (!_mapCtrl.isCompleted) return;
    final ctrl = await _mapCtrl.future;
    await ctrl.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoom)));
  }

  Future<void> _animateToCurrentLocation() async {
    final loc = _currentLocation;
    if (loc == null) return;
    await _animateTo(LatLng(loc.latitude!, loc.longitude!));
  }

  // ---------- Markers & polylines ----------
  void _buildSelectedPlaceMarker() {
    final place = _selectedPlace;
    final icon = _placeIconBytes;

    if (place == null || icon == null) return;

    final lat = double.tryParse('${place['latitude']}');
    final lng = double.tryParse('${place['longitude']}');
    if (lat == null || lng == null) return;

    _markers
      ..clear()
      ..add(
        Marker(
          markerId: MarkerId('${place['title']}'),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.fromBytes(icon),
          infoWindow: InfoWindow(title: '${place['title']}'),
        ),
      );
  }

  Future<void> _buildRouteIfPossible() async {
    final loc = _currentLocation;
    final place = _selectedPlace;
    if (loc == null || place == null) return;

    final destLat = double.tryParse('${place['latitude']}');
    final destLng = double.tryParse('${place['longitude']}');
    if (destLat == null || destLng == null) return;

    try {
      final result = await _polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: PointLatLng(loc.latitude!, loc.longitude!),
          destination: PointLatLng(destLat, destLng),
          mode: TravelMode.driving,
        ),
      );

      if (result.points.isNotEmpty) {
        _polylineCoordinates
          ..clear()
          ..addAll(result.points.map((p) => LatLng(p.latitude, p.longitude)));

        _addPolyline();
      } else if (result.errorMessage != null) {
        _toastError('Unable to get route: ${result.errorMessage}');
      } else {
        _toastError('No route found between locations');
      }
    } catch (e) {
      _toastError('Error getting route: $e');
    }
  }

  void _addPolyline() {
    final polyline = Polyline(
      polylineId: const PolylineId('route'),
      color: const Color.fromARGB(255, 59, 130, 254),
      points: List<LatLng>.unmodifiable(_polylineCoordinates),
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
    );

    _polylines
      ..clear()
      ..add(polyline);
    if (mounted) setState(() {});
  }

  void _toastError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final initialTarget = _currentLocation != null
        ? LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)
        : _fallbackCenter;

    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          backgroundColor: kColor2,
          foregroundColor: Colors.white,
          onPressed:
              _currentLocation == null ? null : _animateToCurrentLocation,
          child: const Icon(Icons.my_location),
        ),
      ),
      body: _currentLocation == null && _selectedPlace == null
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
                      CameraPosition(target: initialTarget, zoom: 16),
                  markers: _markers,
                  polylines: _polylines,
                  onMapCreated: (GoogleMapController ctrl) async {
                    if (_mapStyleJson.isNotEmpty) {
                      ctrl.setMapStyle(_mapStyleJson);
                    }
                    if (!_mapCtrl.isCompleted) {
                      _mapCtrl.complete(ctrl);
                    }
                    await _buildRouteIfPossible();
                  },
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      await _ensureLocation();
                      await _buildRouteIfPossible();
                      if (mounted) setState(() {});
                    },
                    child: Icon(Icons.refresh, color: kColor2),
                  ),
                ),
              ],
            ),
    );
  }
}
