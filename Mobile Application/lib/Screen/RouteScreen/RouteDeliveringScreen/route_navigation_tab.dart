import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Common/Constants.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:url_launcher/url_launcher.dart';

class RouteNavigationTab extends StatefulWidget {
  final RouteLoaded routeLoaded;
  final String route_uuid;

  const RouteNavigationTab(
      {Key? key, required this.routeLoaded, required this.route_uuid})
      : assert(routeLoaded != null),
        assert(route_uuid != null),
        super(key: key);

  @override
  State<RouteNavigationTab> createState() =>
      _RouteNavigationTabState(routeLoaded, route_uuid);
}

class _RouteNavigationTabState extends State<RouteNavigationTab> {
  RouteLoaded routeLoaded;
  String route_uuid;

  // final Completer<GoogleMapController> _controller = Completer();
  late LatLng curLocation;
  late LatLng destLocation;
  late LatLng sourceLocation;
  Completer<GoogleMapController> _controller = Completer();

  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoor = [];
  Map<PolylineId, Polyline> polylines = {};

  _RouteNavigationTabState(this.routeLoaded, this.route_uuid);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if(state == AppLifecycleState.resumed){
      if(polylineCoor.isNotEmpty){
        polylineCoor.clear();
      }
      _getPolyline();
    }
  }

  void mapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
      _getPolyline(); //need fix it
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, OrderRoute> routes = widget.routeLoaded.routes;
    List<OrderStatus> orderStatus =
        widget.routeLoaded.status['delivering']!.values.toList();
    String? targetUuid = (orderStatus.isNotEmpty) ? orderStatus[0].uuid : null;
    OrderRoute? targetOrder = (targetUuid != null) ? routes[targetUuid] : null;

    void initLocation(GeolocationLoaded state) async {
      sourceLocation =
          LatLng(state.sourcePosition.latitude, state.sourcePosition.longitude);
      curLocation =
          LatLng(state.curPosition.latitude, state.curPosition.longitude);
      if (targetOrder != null) {
        destLocation = LatLng(targetOrder.lat, targetOrder.lng);
      }
    }

    void cameraTracking() async {
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(zoom: 18, target: curLocation)));
    }

    return BlocBuilder<GeolocationBloc, GeolocationState>(
        builder: (context, state) {
      if (state is GeolocationLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is GeolocationLoaded) {
        if (targetOrder != null) {
          initLocation(state);
          cameraTracking();
          return Stack(children: [
            GoogleMap(
              //use bloc to provide next stop
              // myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: curLocation,
              ),
              markers: {
                // Marker(
                //   markerId: const MarkerId('Source'),
                //   draggable: false,
                //   position: sourceLocation,
                // ),
                Marker(
                  markerId: const MarkerId('Current'),
                  draggable: false,
                  position: curLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure),
                ),
                Marker(
                  markerId: const MarkerId('Target'),
                  draggable: false,
                  position: destLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  infoWindow: InfoWindow(
                    title:
                        ('${targetOrder.first_name} ${targetOrder.last_name}'),
                    snippet:
                        ('${targetOrder.delivery1} ${targetOrder.delivery2}'),
                  ),
                )
              },
              polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: mapCreated,
              mapToolbarEnabled: false,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.4),
            ),
            Positioned(
              bottom: 15.0,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 80.0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                            // width: double.infinity * 0.7,
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: 'Name: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                          text:
                                              '${targetOrder.first_name} ${targetOrder.last_name}'),
                                    ],
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: 'Phone Number: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                          text: '${targetOrder.phone_number}'),
                                    ],
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: 'Destination: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        TextSpan(
                                          text:
                                              '${targetOrder.delivery1} ${targetOrder.delivery2}',
                                        ),
                                      ],
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Center(
                                child: IconButton(
                              onPressed: () async {
                                await launchUrl(Uri.parse(
                                    'google.navigation:q=${targetOrder.lat}, ${targetOrder.lng}&key=$google_api_key'));
                              },
                              icon: const Icon(Icons.navigation_outlined),
                            ))),
                      ],
                    ),
                  )),
            ),
          ]);
        }
      }
      return const Center(child: Text('Fail'));
    });
  }

  _addPolyline() {
    PolylineId id = const PolylineId('polyline');
    Polyline polyline =
        Polyline(polylineId: id, color: Colors.red, points: polylineCoor);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineId id = const PolylineId('polyline');
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(curLocation.latitude, curLocation.longitude),
        PointLatLng(destLocation.latitude, destLocation.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoor.add(LatLng(point.latitude, point.longitude)));
    }
    _addPolyline();
  }
}
