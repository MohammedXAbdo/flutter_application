import 'package:flutter/cupertino.dart';
import 'package:latlong/latlong.dart';
import '../repository/settings_repository.dart' as settingsRepo;

class Distanc {
  BuildContext context;
  Distanc(this.context);
  int calculateDistance(lat2, lon2) {
    // try {
    lat2 = double.parse(lat2);
    lon2 = double.parse(lon2);
    double lat = settingsRepo.deliveryAddress.value.latitude ?? 0;
    //print(lat);
    double log = settingsRepo.deliveryAddress.value.longitude ?? 0;
    //print(log);
    final Distance distance = new Distance();
    // km = 423
    final double km = distance.as(
      LengthUnit.Kilometer,
      new LatLng(lat, log),
      new LatLng(lat2, lon2),
    );
    return km.toInt();
    // }catch(error){
    //   print('error here');
    //   print(error);
    //   print('error here2');
    //   throw(error);
    // }
  }
}
