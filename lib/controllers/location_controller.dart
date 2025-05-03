import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../helpers/prefs_helpers.dart';
import '../helpers/route.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_constants.dart';

class LocationController extends GetxController {
  var locationNameController = TextEditingController();
  var setLocationLoading = false.obs;
  var submitLocationLoading = false.obs;

  //=====================================> Set Location <==============================
  Future<void> setLocation() async {
    try {
      PermissionStatus permission = await Permission.location.status;
      if (permission.isDenied || permission.isPermanentlyDenied) {
        permission = await Permission.location.request();
        if (permission.isDenied || permission.isPermanentlyDenied) {
          permission = await Permission.location.request();
          Fluttertoast.showToast(msg: "Location permission is required to set your location.");
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      String latitude = position.latitude.toString();
      String longitude = position.longitude.toString();

      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '${place.subLocality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}';
        locationNameController.text = address;

        var body = {
          "latitude": latitude,
          "longitude": longitude,
          "locationName": address,
        };

        String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        };

        setLocationLoading(true);

        var response = await ApiClient.postData(
          ApiConstants.setLocationEndPoint,
          jsonEncode(body),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          await PrefsHelper.setBool(AppConstants.hasUpdateGallery, true);
          Fluttertoast.showToast(msg: "Your location is set successfully");
          Get.offAllNamed(AppRoutes.homeScreen);
        } else {
          ApiChecker.checkApi(response);
        }
      } else {
        throw "No placemarks found";
      }
    } catch (e) {
      String errorMessage = e.toString();
      print("Error: $errorMessage");
    } finally {
      setLocationLoading(false);
    }
  }
  //=====================================> Submit Picked Location <==============================
  Future<void> submitPickedLocation({
    required double lat,
    required double lng,
    required String locationName,
  }) async {
    submitLocationLoading(true);
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isEmpty) {
        Fluttertoast.showToast(msg: "No placemarks found for this location.");
        return;
      }
      Placemark place = placemarks[0];
      final fullAddress = locationName.isNotEmpty
          ? locationName
          : [
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.country
      ].where((part) => part != null && part!.trim().isNotEmpty).join(', ');
      locationNameController.text = fullAddress;
      final body = {
        "latitude": lat.toString(),
        "longitude": lng.toString(),
        "locationName": fullAddress,
      };
      final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      };
      final response = await ApiClient.postData(
        ApiConstants.setLocationEndPoint,
        jsonEncode(body),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        submitLocationLoading(false);
        await PrefsHelper.setBool(AppConstants.hasUpdateGallery, true);
        Fluttertoast.showToast(msg: "Your location has been submitted successfully");
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint("Error submitting picked location: $e");
    } finally {
      submitLocationLoading(false);
    }
  }

}
