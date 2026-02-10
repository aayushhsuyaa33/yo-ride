import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:yo_ride/core/constants/app_colors.dart';
import 'package:yo_ride/core/routes/app_routes.dart';
import 'package:yo_ride/features/widget/custom_textfield.dart';
import 'package:yo_ride/features/widget/home/book%20screen/timeline_indicator.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> {
  TextEditingController pickupLocationController = TextEditingController();
  TextEditingController dropLocationController = TextEditingController();

  double selectedLat = 0;
  double selectedLng = 0;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission permanently denied");
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 100,
      ),
    );

    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark placemark = placeMarks.first;
    log(placemark.toString());
    String currentLocation =
        "${placemark.subLocality!.isEmpty ? placemark.thoroughfare : placemark.subLocality}, ${placemark.locality}";

    setState(() {
      pickupLocationController.text = currentLocation;
      selectedLat = position.latitude;
      selectedLng = position.longitude;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlackColor,
      appBar: AppBar(
        backgroundColor: AppColors.lightBlackColor,
        foregroundColor: AppColors.whiteColor,
        automaticallyImplyActions: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimelineIndicator(),
                SizedBox(width: 25.w),
                Expanded(
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: "Enter pickup point",
                        controller: pickupLocationController,
                        prefixIcon: Icons.my_location,
                        onMapTap: () async {
                          FocusScope.of(context).unfocus();

                          final result = await Navigator.pushNamed(
                            context,
                            AppRoutes.mapPickerScreen,
                            arguments: {
                              "selectedLng": selectedLng,
                              'selectedLat': selectedLat,
                              'title': "PickUp Address",
                              "address": pickupLocationController.text,
                            },
                          );
                          if (result != null) {
                            setState(() {
                              pickupLocationController.text = result.toString();
                            });
                          }
                        },
                      ),
                      SizedBox(height: 15.h),
                      CustomTextField(
                        hintText: "Where to?",
                        prefixIcon: Icons.location_on,
                        controller: dropLocationController,

                        onMapTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.mapPickerScreen,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
