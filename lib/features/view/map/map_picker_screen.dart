import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:yo_ride/core/constants/app_colors.dart';
import 'package:yo_ride/core/theme/style.dart';

class MapPickerScreen extends StatefulWidget {
  final double selectedLat;
  final double selectedLng;

  const MapPickerScreen({
    super.key,
    required this.selectedLat,
    required this.selectedLng,
  });

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late LatLng selectedLatLng;

  @override
  void initState() {
    super.initState();
    selectedLatLng = LatLng(widget.selectedLat, widget.selectedLng);
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
      body: FlutterMap(
        options: MapOptions(
          initialCenter: selectedLatLng,
          initialZoom: 17,
          maxZoom: 18,
          onTap: (context, latLong) {
            setState(() {
              selectedLatLng = latLong;
            });
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
      floatingActionButton: MyModelBottomSheet(title: '', address: ''),
    );
  }
}

class MyModelBottomSheet extends StatefulWidget {
  final String title;
  final String address;

  const MyModelBottomSheet({
    super.key,
    required this.title,
    required this.address,
  });

  @override
  State<MyModelBottomSheet> createState() => _MyModelBottomSheetState();
}

class _MyModelBottomSheetState extends State<MyModelBottomSheet> {
  @override
  void initState() {
    super.initState();

    // Show bottom sheet automatically when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.address,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Confirm Location",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Nothing in main UI
  }
}
