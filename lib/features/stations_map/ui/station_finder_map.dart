import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:evhub/features/stations_map/data/models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:url_launcher/url_launcher.dart';

class EVStationFinder extends StatefulWidget {
  const EVStationFinder({super.key});

  @override
  _EVStationFinderState createState() => _EVStationFinderState();
}

class _EVStationFinderState extends State<EVStationFinder> {
  final String apiKey = "AIzaSyAGMmXcsZm2wBqNW9A7xuTF3eTOxTU6_Co";
  bool isLoading = false;
  bool _isLocationLoading = false;
  String errorMessage = "";
  BitmapDescriptor? customMarkerIcon;

  GoogleMapController? mapController;
  final LatLng _initialLocation = const LatLng(30.0444, 31.2357); // Default: Cairo
  Set<Marker> markers = {};
  LatLng? _currentLocation;
  Set<Polyline> polylines = {};

  String? _mapStyle;
  Station? selectedStation;
  Map<String, String>? travelInfo;
  List<Station> stations = [];

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _getCurrentLocation();
    _loadCustomMarker();
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/map_style.json');
  }

  Future<void> _loadCustomMarker() async {
    final bitmap = await getMarkerIconFromAsset('images/png/Group 94.png');
    setState(() => customMarkerIcon = bitmap);
  }

  Future<BitmapDescriptor> getMarkerIconFromAsset(String path, {int width = 100}) async {
    final ByteData byteData = await rootBundle.load(path);
    final Uint8List imageData = byteData.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(imageData, targetWidth: width);
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ByteData? resizedByteData = await fi.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedImageData = resizedByteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedImageData);
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLocationLoading = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception("Location services are disabled.");

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permissions are denied.");
        }
      }

      Position position = await Geolocator.getCurrentPosition();
      final LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentLocation = currentLatLng;
        _isLocationLoading = false;
      });

      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(currentLatLng, 14.0),
      );

      fetchEVStations(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _isLocationLoading = false;
        errorMessage = "Failed to get current location: $e";
      });
    }
  }

  Future<void> fetchEVStations(double latitude, double longitude) async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    try {
      final response = await Dio().get(
        'https://evhubtl.com/wp-json/wp/v2/stations',
      );

      if (response.statusCode == 200 && response.data != null) {
        final List results = response.data is List ? response.data : [];

        setState(() {
          isLoading = false;
          markers.clear();
          stations = results.map((json) => Station.fromJson(json)).toList();

          for (var station in stations) {
            final double lat = _getValidCoordinate(station.acf.mapL);
            final double lng = _getValidCoordinate(station.acf.mapE);

            if (lat != 0.0 && lng != 0.0) {
              markers.add(
                Marker(
                  markerId: MarkerId(station.id.toString()),
                  position: LatLng(lat, lng),
                  icon: customMarkerIcon ?? BitmapDescriptor.defaultMarker,
                  onTap: () async {
                    setState(() {
                      selectedStation = station;
                      travelInfo = null;
                      polylines.clear();
                    });

                    if (_currentLocation != null) {
                      await _getTravelInfo(_currentLocation!, LatLng(lat, lng));
                    }
                  },
                ),
              );
            }
          }
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = "Error: ${response.data['error_message'] ?? response.data['status']}";
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "An error occurred: $e";
      });
    }
  }

  double _getValidCoordinate(String? coordinate) {
    if (coordinate != null && coordinate.isNotEmpty) {
      try {
        final double value = double.parse(coordinate);
        return value.isFinite ? value : 0.0;
      } catch (_) {
        return 0.0;
      }
    }
    return 0.0;
  }

  Future<void> _getTravelInfo(LatLng origin, LatLng destination) async {
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

    try {
      final response = await Dio().get(url);
      final data = response.data;

      if (data['status'] == 'OK') {
        final route = data['routes'][0];
        final leg = route['legs'][0];

        setState(() {
          travelInfo = {
            'duration': leg['duration']['text'],
            'distance': leg['distance']['text'],
          };
          polylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: _decodePolyline(route['overview_polyline']['points']),
              color: Colors.blue,
              width: 4,
            ),
          );
        });
      }
    } catch (e) {
      print("Travel info error: $e");
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  String _buildCustomAddress(Station station) {
    return station.title.rendered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
                if (_mapStyle != null) {
                  mapController!.setMapStyle(_mapStyle);
                }
              },
              initialCameraPosition: CameraPosition(
                target: _currentLocation ?? _initialLocation,
                zoom: 12.0,
              ),
              markers: markers,
              polylines: polylines,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
            ),
          ),
          if (selectedStation != null)Positioned(
          bottom: 90,
          left: 16,
          right: 16,
          child: Container(
          // The height can now be adjusted or be determined by its children
          // height: 250.h, // You might want to remove or adjust this
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
          color: const Color(0xDD063A34),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
          BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8.r,
          offset: const Offset(0, 4),
    ),
    ],
    ),
    child: Row( // <-- Changed from Column to Row for side-by-side layout
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // All the text information is wrapped in an Expanded widget
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min, // To make the column fit its content
    children: [
    // Title + travel info
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Expanded(
    child: Text(
    selectedStation!.title.rendered,
    style: TextStyle(
    overflow: TextOverflow.ellipsis,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),
    ),
    RichText(
    text: TextSpan(
    children: [
    TextSpan(
    text: travelInfo?['duration'] ?? '--',
    style: TextStyle(
    color: const Color(0xFF00FFD1),
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    ),
    ),
    TextSpan(
    text: ' (${travelInfo?['distance'] ?? '--'})',
    style: TextStyle(
    color: Colors.grey.shade300,
    fontSize: 14.sp,
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    SizedBox(height: 4.h),
    Text(
    _buildCustomAddress(selectedStation!),
    style: TextStyle(
    fontSize: 13.sp,
    color: Colors.grey.shade300,
    ),
    ),
    SizedBox(height: 12.h),

    // 🔌 Connector Info
    Wrap(
    spacing: 12.w,
    runSpacing: 6.h,
    children: selectedStation!.connectorStatus.map((connector) {
    return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
    const Icon(Icons.bolt, color: Colors.white, size: 16),
    SizedBox(width: 4.w),
    Text(
    connector.name,
    style: const TextStyle(color: Colors.white),
    ),
    ],
    );
    }).toList(),
    ),
    ],
    ),
    ),
    SizedBox(width: 16.w), // <-- Adds spacing between text and button

    // 🟢 NEW Circle Navigate Button
    FloatingActionButton(
    onPressed: () async {
    if (_currentLocation != null && selectedStation != null) {
    final lat = double.tryParse(selectedStation!.acf.mapL) ?? 0.0;
    final lng = double.tryParse(selectedStation!.acf.mapE) ?? 0.0;

    final googleMapsUrl =
    "https://www.google.com/maps/dir/?api=1&origin=${_currentLocation!.latitude},${_currentLocation!.longitude}&destination=$lat,$lng&travelmode=driving";

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
    await launchUrl(Uri.parse(googleMapsUrl),
    mode: LaunchMode.externalApplication);
    } else {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
    content: Text('Could not launch Google Maps')),
    );
    }
    }
    print('Start Trip to ${selectedStation!.title.rendered}');
    },
    backgroundColor: const Color(0xFF00FFD1), // Same vibrant color
    foregroundColor: Colors.black, // Same icon/foreground color
    elevation: 4.0,
    heroTag: null, // Set to null to avoid Hero animation issues
    child: const Icon(Icons.navigation),
    ),
    ],
    ),
    ),
    ) ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _getCurrentLocation,
      //   child: _isLocationLoading
      //       ? const CircularProgressIndicator(color: Colors.white)
      //       : const Icon(Icons.my_location),
      // ),
    );
  }
}
