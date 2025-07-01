import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:evhub/features/stations_map/data/models/evstation_model.dart';
import 'package:evhub/features/stations_map/data/models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';

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
  final LatLng _initialLocation = const LatLng(30.0444, 31.2357); // Default location (Cairo)
  Set<Marker> markers = {};
  LatLng? _currentLocation;

  String? _mapStyle;
  Station? selectedStation;  // Store the selected station details
  Map<String, String>? travelInfo;
  Set<Polyline> polylines = {};

  List<Station> stations = []; // List to store fetched stations

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _loadCustomMarker();
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/map_style.json');
  }

  Future<void> _loadCustomMarker() async {
    final bitmap = await getMarkerIconFromAsset('images/png/Group 94.png');
    setState(() {
      customMarkerIcon = bitmap;
    });
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
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLocationLoading = false;
      });

      fetchEVStations(position.latitude, position.longitude); // Fetch stations after getting location
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
      'https://evhubtl.com/wp-json/wp/v2/stations', // API to fetch stations
    );

    // تحقق من وجود response.data والـ statusCode
    if (response.statusCode == 200 && response.data != null) {
      final List results = response.data is List ? response.data : [];
      print("Fetched Stations: $results");

      setState(() {
        isLoading = false;
        markers.clear();  // Clear previous markers
        stations = results.map((json) => Station.fromJson(json)).toList(); // Map API data to Station model

        // Add markers for each station
        for (var station in stations) {
          final String? mapL = station.acf.mapL;
          final String? mapE = station.acf.mapE;

          // تحقق إذا كانت الإحداثيات موجودة وصحيحة
          final double lat = (mapL != null && mapL.isNotEmpty) ? double.parse(mapL) : 0.0;
          final double lng = (mapE != null && mapE.isNotEmpty) ? double.parse(mapE) : 0.0;

          // طباعة الإحداثيات للتأكد من صحتها
          print("Adding marker for station: ${station.title.rendered}, Lat: $lat, Lng: $lng");

          if (lat != 0.0 && lng != 0.0) {
            markers.add(
              Marker(
                markerId: MarkerId(station.id.toString()),
                position: LatLng(lat, lng),  // Use the parsed latitude and longitude
                icon: customMarkerIcon ?? BitmapDescriptor.defaultMarker,
                onTap: () {
                  setState(() {
                    selectedStation = station;  // Set selected station
                    travelInfo = null;  // Reset travel info
                  });
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
    print("Error fetching data: $e");  // طباعة الأخطاء إذا حدثت
  }
}
double _getValidCoordinate(String? coordinate) {
  // تحويل الإحداثيات إلى double إذا كانت القيمة صالحة، وإذا كانت غير صالحة نعيد 0.0
  if (coordinate != null && coordinate.isNotEmpty) {
    try {
      final double value = double.parse(coordinate);
      return value.isFinite ? value : 0.0; // التحقق من القيمة النهائية
    } catch (e) {
      return 0.0;  // إذا كانت القيمة غير قابلة للتحويل إلى double نعيد 0.0
    }
  }
  return 0.0;  // إعادة قيمة افتراضية إذا كانت القيمة فارغة أو null
}
String _buildCustomAddress(Station station) {
    // Since there's no addressComponents, we display the station's name instead
    return station.title.rendered;  // Just using the title as the address
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
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
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
            ),
          ),
          // App Bar, Station Card, etc...
          if (selectedStation != null)
          Positioned(
  bottom: 90,
  left: 16,
  right: 16,
  child: Container(
    height: 130,
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xDD063A34), // نفس اللون بنسبة 87%
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان + الوقت والمسافة
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedStation!.title.rendered,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: '10 min ',
                    style: TextStyle(
                      color: Color(0xFF00FFD1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '(3 km)',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 4),
        Text(
          _buildCustomAddress(selectedStation!),
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade300,
          ),
        ),
        const Spacer(),
        // نوع الشاحن
        Row(
          children: const [
            Icon(Icons.bolt, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              'Type 2',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(width: 8),
            Text(
              '22kW AC',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ],
    ),
  ),
)
    ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: _isLocationLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.my_location),
      ),
    );
  }
}
