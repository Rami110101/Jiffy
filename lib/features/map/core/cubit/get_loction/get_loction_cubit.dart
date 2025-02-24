import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../shared_preferences_manager.dart';

part 'get_loction_state.dart';

class GetLoctionCubit extends Cubit<GetLoctionState>
    with WidgetsBindingObserver {
  GetLoctionCubit() : super(GetLoctionInitial()) {
    WidgetsBinding.instance.addObserver(this);
  }

  final MapController mapController = MapController();

  Position? currentLocation;
  List<Marker> markers = [];

  @override
  Future<void> close() async {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getCurrentLocation(forceCheck: true);
    }
  }

  Future<void> getCurrentLocation({bool forceCheck = false}) async {
    if (forceCheck) {
      emit(GetLoctionInitial());
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(GetLoctionError());
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(GetLoctionError());
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(GetLoctionError());
      return;
    }

    try {
      Position userLocation = await Geolocator.getCurrentPosition();
      currentLocation = userLocation;

      markers.clear();

      markers.add(
        Marker(
          point: LatLng(userLocation.latitude, userLocation.longitude),
          child: const Icon(
            Icons.my_location,
            color: Colors.blue,
            size: 30.0,
          ),
        ),
      );

      emit(GetLoctionSuccess());
    } catch (e) {
      print("Error getting location: $e");
      emit(GetLoctionError());
    }
  }

  Future<void> openLocationSettings() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
  }

  Future<Placemark?> getLocationName(LatLng position) async {
    try {
      if (position.latitude.isNaN || position.longitude.isNaN) {
        throw Exception("Invalid coordinates");
      }

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        return placemarks.first;
      } else {
        throw Exception("No placemarks found");
      }
    } catch (e) {
      print("Error in getLocationName: $e");
      return null;
    }
  }

  String viewDistance(distanceRoute) {
    if (distanceRoute > 1000) {
      return 'المسافة: ${(distanceRoute / 1000).toStringAsFixed(1)} كم';
    }
    return 'المسافة: ${(distanceRoute).toStringAsFixed(0)} متر';
  }

  String viewDuration(durationRoute) {
    if (durationRoute > 60) {
      if (durationRoute > 3600) {
        return 'المدة: ${(durationRoute / 3600).toStringAsFixed(1)} ساعة';
      }
      return 'المدة: ${(durationRoute / 60).toStringAsFixed(1)} دقيقة';
    }
    return 'المدة: ${(durationRoute).toStringAsFixed(0)} ثانية';
  }

  Future<void> loadStoredMarkers() async {
    markers.clear();

    final senderCoordsString =
        await SharedPreferencesManager.getData(key: 'sender_coordinates');
    final recipientCoordsString =
        await SharedPreferencesManager.getData(key: 'recipient_coordinates');

    List<dynamic>? senderCoords;
    List<dynamic>? recipientCoords;

    try {
      senderCoords = senderCoordsString != null
          ? List<dynamic>.from(senderCoordsString)
          : null;
      recipientCoords = recipientCoordsString != null
          ? List<dynamic>.from(recipientCoordsString)
          : null;
    } catch (e) {
      debugPrint(' Error Parsing Coordinates: $e');
    }

    if (senderCoords != null && senderCoords.length == 2) {
      final lat = senderCoords[0] as double;
      final lng = senderCoords[1] as double;
      markers.add(
        Marker(
          point: LatLng(lat, lng),
          child: const Icon(Icons.location_on, color: Colors.red, size: 40),
        ),
      );
      debugPrint(' Sender Marker Loaded: LatLng($lat, $lng)');
    } else {
      debugPrint('️ No Sender Marker Found');
    }

    if (recipientCoords != null && recipientCoords.length == 2) {
      final lat = recipientCoords[0] as double;
      final lng = recipientCoords[1] as double;
      markers.add(
        Marker(
          point: LatLng(lat, lng),
          child: const Icon(Icons.location_on, color: Colors.green, size: 40),
        ),
      );
      debugPrint(' Recipient Marker Loaded: LatLng($lat, $lng)');
    } else {
      debugPrint(' No Recipient Marker Found');
    }

    if (markers.isNotEmpty) {
      debugPrint(' Moving Map to First Marker: ${markers.first.point}');
      mapController.move(markers.first.point, 15.0);
    } else {
      debugPrint('️ No Markers Found After Loading!');
    }

    emit(GetLoctionSuccess());
  }

  double calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371e3; // in meters
    final double lat1 = start.latitude * (pi / 180);
    final double lon1 = start.longitude * (pi / 180);
    final double lat2 = end.latitude * (pi / 180);
    final double lon2 = end.longitude * (pi / 180);

    final double dLat = lat2 - lat1;
    final double dLon = lon2 - lon1;

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Distance in meters
  }

  String formatDuration(double distanceMeters) {
    const double walkingSpeed = 5.0; // km/h
    final double hours = (distanceMeters / 1000) / walkingSpeed;
    final int minutes = (hours * 60).toInt();
    return '$minutes دقيقة';
  }
}
