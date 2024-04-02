import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as goa;
import 'dart:async';


class LocationService {

  late Location _location;
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;

  LocationService() {
    _location = Location();
  }

  Future<bool> _checkPermission() async {
    if(await _checkService()){
      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
      }
      return _permissionGranted == PermissionStatus.granted;
    } else {
      return false;
    }
  }

  Future<bool> _checkService() async {
    try{
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
      }
    } on PlatformException catch(error) {
      print ("error: ${error.message} ${error.code}");
      _serviceEnabled = false;
      await _checkService();
    }
    return _serviceEnabled;
  }

  Future<LocationData?> getLocation() async {
  if (await _checkPermission()) {
    try {
      final locationData = await _location.getLocation(); // Add await here
      print("Location Data: ${locationData.latitude}, ${locationData.longitude}");
      return locationData;
    } catch (e) {
      print("Failed to get location: $e");
      return null;
    }
  } else {
    print("Location service permission not granted or service not enabled");
    return null;
  }
}


  Future<goa.Placemark?> getPlaceMark({required LocationData locationData}) async {
    //print("i get here");
    try {
    
    //print("i get here 2");
    
    List<goa.Placemark> placemarks = await goa.placemarkFromCoordinates(locationData.latitude!, locationData.longitude!);
    //print("i get here 3");
    //print (placemarks);
    if (placemarks.isNotEmpty) {
      //print("i get here 3");
      print("Geocoding success: Country - ${placemarks[0].country}, Admin Area - ${placemarks[0].administrativeArea}");
      return placemarks[0];
    } else {
       return null;
    }
  } catch (e) {
  print("An error occurred: $e");
  return null;}
  }
}