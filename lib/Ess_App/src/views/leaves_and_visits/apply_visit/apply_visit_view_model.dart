import 'dart:async';
import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/visit_form_data.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class ApplyVisitViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {

  final Completer<GoogleMapController> controller =
  Completer<GoogleMapController>();
  DateTime toDateFormat = DateTime.now();
  TextEditingController employeeCode = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController visitReason = TextEditingController();
  TextEditingController visitLocation = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController lon = TextEditingController();

  init(BuildContext context) async {
    employeeCode.text = currentUser?.userId.toString() ?? "000000";
    _getCurrentPosition(context);
  }

  CameraPosition location = CameraPosition(
    target: LatLng(24.8365057, 67.0995728),
    zoom: 8.4746,
  );
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Marker marker = Marker(
    markerId: MarkerId("marker"),
    position: LatLng(24.8365057, 67.0995728),
    infoWindow: InfoWindow(title: "Your Visit Location", snippet: '*'),
  );

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Constants.customErrorSnack(context, "Location services are disabled. Please enable the services");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Constants.customErrorSnack(context, "Location permissions are denied");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Constants.customErrorSnack(context, "Location permissions are permanently denied, we cannot request permissions.");
      return false;
    }
    return true;
  }
  Future<void> _getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission){
      NavService.dashboard();
      Constants.customErrorSnack(context, "Kindly enable your location");
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
      lat.text = position.latitude.toString();
      lon.text = position.longitude.toString();
      print(lat.text);
      print(lon.text);
      CameraPosition _newLocation = CameraPosition(
        target: LatLng(double.parse(lat.text.toString()), double.parse(lon.text.toString())),
        zoom: 17.4746,
      );
      final GoogleMapController ctr = await controller.future;
      ctr.animateCamera(CameraUpdate.newCameraPosition(_newLocation));
      marker = Marker(
        markerId: MarkerId("marker"),
        position: LatLng(double.parse(lat.text.toString()), double.parse(lon.text.toString())),
        infoWindow: InfoWindow(title: "Your Visit Location", snippet: '*'),
      );
      markers[MarkerId("marker")] = marker;
      notifyListeners();
    }).catchError((e) {debugPrint(e);});
  }


  clear(){
    fromDate.clear();
    toDate.clear();
    visitReason.clear();
    visitLocation.clear();
    lat.clear();
    lon.clear();
  }

  apply(BuildContext context) async {
    if(m.Form.of(context).validate()) {
      await setVisitApplicationsData(context);
    }
  }

  setVisitApplicationsData(BuildContext context,) async {
    VisitFormData formData = VisitFormData(
      fromDate: fromDate.text,
      toDate: toDate.text,
      empCode: employeeCode.text,
      lat: lat.text,
      lon: lon.text,
      visitLocation: visitLocation.text,
      visitReason: visitReason.text
    );
    var newsResponse = await runBusyFuture(apiService.applyVisit(context,formData));
    newsResponse.when(success: (data) async {
      if (data == "Visit Successfully Submitted") {
        clear();
        Constants.customSuccessSnack(context, "Your Application Submitted Successfully");
        NavService.visits();
      } else {
        Constants.customErrorSnack(context, "Your Application Not Submit, Try Again");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}
