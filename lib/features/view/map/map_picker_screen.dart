import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:yo_ride/core/constants/app_colors.dart';
import 'package:yo_ride/core/theme/style.dart';

class MapPickerScreen extends StatefulWidget {
  final double selectedLat;
  final double selectedLng;
  final String? title;
  final String? address;

  const MapPickerScreen({
    super.key,
    required this.selectedLat,
    required this.selectedLng,
    this.title,
    this.address,
  });

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late LatLng selectedLatLng;
  late String localAddress;
  bool isShifting = false;

  @override
  void initState() {
    super.initState();
    localAddress = widget.address ?? "Ghorahi 15, Dang";
    selectedLatLng = LatLng(widget.selectedLat, widget.selectedLng);
  }

  Future<void> getLocationWhenMapDragged() async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      selectedLatLng.latitude,
      selectedLatLng.longitude,
    );
    Placemark placemark = placeMarks.first;
    log(placemark.toString());

    String currentLocation =
        "${placemark.subLocality!.isEmpty ? placemark.thoroughfare : placemark.subLocality}, ${placemark.locality}";

    log(currentLocation);

    setState(() {
      localAddress = currentLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.whiteColor,
        title: Text(
          "Swipe to move map",
          style: w6f16p(color: AppColors.whiteColor),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: selectedLatLng,
              initialZoom: 17,
              maxZoom: 18,
              onTap: (context, latLong) async {
                setState(() {
                  log(latLong.toString());
                  isShifting = true;
                  selectedLatLng = latLong;
                });

                await getLocationWhenMapDragged();
                isShifting = false;
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.yoride.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    rotate: true,
                    point: selectedLatLng,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Positioned(
            bottom: 210,
            right: 20,

            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkBlackColor.withAlpha(150),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    selectedLatLng = LatLng(
                      widget.selectedLat,
                      widget.selectedLng,
                    );
                  });
                },
                icon: Icon(Icons.my_location),
                color: AppColors.whiteColor,
              ),
            ),
          ),

          if (!isShifting)
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: MyModelBottomSheet(
                title: widget.title ?? "PickUp Address",
                address: localAddress,
                onConfirmPressed: () {
                  Navigator.pop(context, localAddress);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class MyModelBottomSheet extends StatelessWidget {
  final String title;
  final String address;
  final VoidCallback onConfirmPressed;

  const MyModelBottomSheet({
    super.key,
    required this.title,
    required this.address,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: w6f20p(color: AppColors.darkBlackColor)),
            Divider(thickness: 0.5, color: AppColors.darkBlackColor),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_city),
                SizedBox(width: 7),
                Text(address, style: w6f16p(color: AppColors.darkBlackColor)),
              ],
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 182, 53, 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  onPressed: onConfirmPressed,

                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Confirm Location",
                      style: w6f14p(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
