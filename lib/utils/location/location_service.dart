import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../networks/toast_services/toast_services.dart';

class LocationService extends GetxController {
  static LocationService get instance => Get.find<LocationService>();
  
  // Location state
  final RxDouble _lat = 0.0.obs;
  final RxDouble _long = 0.0.obs;
  final RxBool _isLocationPermissionGranted = false.obs;
  final RxBool _isRequestingLocation = false.obs;
  final RxBool _isLocationServiceEnabled = false.obs;

  // Getters
  double get lat => _lat.value;
  double get long => _long.value;
  bool get isLocationPermissionGranted => _isLocationPermissionGranted.value;
  bool get isRequestingLocation => _isRequestingLocation.value;
  bool get isLocationServiceEnabled => _isLocationServiceEnabled.value;
  bool get hasValidLocation => _lat.value != 0.0 && _long.value != 0.0;
  bool get isReady => isLocationPermissionGranted && hasValidLocation && isLocationServiceEnabled;

  @override
  void onInit() {
    super.onInit();
    _checkLocationServiceStatus();
  }

  /// Check if location services are enabled
  Future<void> _checkLocationServiceStatus() async {
    _isLocationServiceEnabled.value = await Geolocator.isLocationServiceEnabled();
  }

  /// Request location permission with proper handling
  Future<bool> requestLocationPermission() async {
    if (_isRequestingLocation.value) return false;
    
    _isRequestingLocation.value = true;
    update();

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      _isLocationServiceEnabled.value = serviceEnabled;
      if (!serviceEnabled) {
        _showLocationServiceDialog();
        _isRequestingLocation.value = false;
        update();
        return false;
      }

      // Check current permission status
      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
      ToastServices.warning(
          'Location Permission Required',
          'This app needs location access to find nearby services',
        )  ;
        _isLocationPermissionGranted.value = false;
        _isRequestingLocation.value = false;
        update();
        return false;
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationPermissionDialog();
        _isLocationPermissionGranted.value = false;
        _isRequestingLocation.value = false;
        update();
        return false;
      }

      // Permission granted, get current location
      if (permission == LocationPermission.whileInUse || 
          permission == LocationPermission.always) {
        _isLocationPermissionGranted.value = true;
        await _getCurrentLocation();
        _isRequestingLocation.value = false;
        update();
        return true;
      }

      _isRequestingLocation.value = false;
      update();
      return false;

    } catch (e) {
      ToastServices.error('Location Error', 'Failed to get location: $e');
      _isRequestingLocation.value = false;
      update();
      return false;
    }
  }

  /// Enforce location permission: keep prompting until granted
  /// This shows blocking dialogs and loops until the user grants permission
  /// or enables the location service. Use carefully on entry screens.
  Future<void> enforceLocationPermission() async {
    // Prevent re-entrancy
    if (_isRequestingLocation.value) return;
    _isRequestingLocation.value = true;
    update();

    try {
      while (true) {
        // Ensure location services (GPS) are enabled
        final serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          // Proactively open device Location Settings
          await Geolocator.openLocationSettings();
          // Poll until service is enabled, showing a blocking guard
          await _waitUntilServiceEnabled();
          // Loop and re-check
          continue;
        }
        _isLocationServiceEnabled.value = true;

        // Check permission state
        LocationPermission permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          // Loop back to re-check state
          continue;
        }

        if (permission == LocationPermission.deniedForever) {
          // Proactively open app settings for permission
          await openAppSettings();
          // Show a blocking guard and wait before re-checking
          await _showBlockingInfo(
            title: 'Location Permission Required',
            message:
                'Please enable Location permission in App Settings to continue.',
          );

          continue;
        }

        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          _isLocationPermissionGranted.value = true;
          await _getCurrentLocation();
          break;
        }
      }
    } finally {
      _isRequestingLocation.value = false;
      update();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
      
      _lat.value = position.latitude;
      _long.value = position.longitude;
      
      debugPrint('Location obtained: ${_lat.value}, ${_long.value}');
    } catch (e) {
      debugPrint('Error getting location: $e');
      ToastServices.error('Location Error', 'Could not get current location');
    }
  }

  Future<void> _showBlockingInfo({
    required String title,
    required String message,
  }) async {
    await Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
  Future<void> _waitUntilServiceEnabled() async {
    // Optional informational dialog to guide the user
    if (Get.isDialogOpen != true) {
      await _showBlockingInfo(
        title: 'Enable Location',
        message: 'Please turn on Location (GPS) in device settings, then return.',
      );
    }
    while (true) {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (enabled) {
        if (Get.isDialogOpen == true) Get.back();
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void _showLocationServiceDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text(
          'Please enable location services (GPS) to use this feature. '
          'You can enable it from your device settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Geolocator.openLocationSettings();
              Get.back();
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  void _showLocationPermissionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'This app needs location permission to find nearby services. '
          'Please enable location permission from app settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Get.back();
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  bool checkLocationAvailability() {
    return hasValidLocation && isLocationPermissionGranted;
  }

  Future<void> refreshLocation() async {
    if (isLocationPermissionGranted) {
      await _getCurrentLocation();
    }
  }
 
  void resetLocation() {
    _lat.value = 0.0;
    _long.value = 0.0;
    _isLocationPermissionGranted.value = false;
    _isRequestingLocation.value = false;
    update();
  }
}
