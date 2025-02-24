import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/utils/colors.dart';
import '../core/contants.dart';
import '../core/cubit/get_loction/get_loction_cubit.dart';
import '../core/cubit/route/route_cubit.dart';

class FlutterMapBuilder extends StatefulWidget {
  const FlutterMapBuilder({
    super.key,
    required this.points,
  });

  final List<LatLng> points;

  @override
  State<FlutterMapBuilder> createState() => _FlutterMapBuilderState();
}

class _FlutterMapBuilderState extends State<FlutterMapBuilder> {
  double zoom = 15;

  @override
  Widget build(BuildContext context) {
    var getLoctionCubit = context.read<GetLoctionCubit>();
    var routeCubit = context.read<RouteCubit>();
    var markers = context.read<GetLoctionCubit>().markers;
    double midLatitude = getLoctionCubit.currentLocation!.latitude;
    double midLongitude = getLoctionCubit.currentLocation!.longitude;
    return Stack(
      children: [
        FlutterMap(
          mapController: getLoctionCubit.mapController,
          options: MapOptions(
            initialCenter: LatLng(
              getLoctionCubit.currentLocation!.latitude,
              getLoctionCubit.currentLocation!.longitude,
            ),
            initialZoom: zoom,
            minZoom: 2.6,
            maxZoom: 20,
            onTap: (tapPosition, point) async {
              await routeCubit.getDestinationRoute(
                getLoctionCubit.currentLocation!,
                point,
                markers,
                getLoctionCubit.mapController,
              );

              midLatitude =
                  (getLoctionCubit.currentLocation!.latitude + point.latitude) /
                      2;
              midLongitude = (getLoctionCubit.currentLocation!.longitude +
                      point.longitude) /
                  2;

              getLoctionCubit.mapController.move(
                LatLng(midLatitude, midLongitude),
                zoom,
              );
            },
          ),
          children: [
            TileLayer(
              urlTemplate: urlTemplate,
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: markers,
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: widget.points,
                  strokeWidth: 3.0,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  InkWell(
                    child: Container(
                      width: 45.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.primary,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        color: AppColors.offWhite,
                        size: 50,
                      ),
                    ),
                    onTap: () {
                      if (zoom <= 20) {
                        zoom += 0.5;
                        getLoctionCubit.mapController.move(
                          LatLng(midLatitude, midLongitude),
                          zoom,
                        );
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(children: [
                InkWell(
                  child: Container(
                    width: 45.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.primary,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.remove,
                      color: AppColors.offWhite,
                      size: 50,
                    ),
                  ),
                  onTap: () {
                    if (zoom > 2.5) {
                      zoom -= 0.5;
                      getLoctionCubit.mapController.move(
                        LatLng(midLatitude, midLongitude),
                        zoom,
                      );
                    }
                    setState(() {});
                  },
                ),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
