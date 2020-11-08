import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import '../repository/settings_repository.dart' as settingsRepo;

class DistanceController {
  Future calculate() async {
    Location location = new Location();

      await location.getLocation().then((currentLocation) async {
        print(currentLocation.latitude);
        print(currentLocation.longitude);
        settingsRepo.deliveryAddress.value.latitude = currentLocation.latitude;
        settingsRepo.deliveryAddress.value.longitude =
            currentLocation.longitude;
        final coordinates = new Coordinates(
            currentLocation.latitude, currentLocation.longitude);
        var addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        //print(' ${addresses.first.locality}, ${addresses.first.adminArea},${addresses.first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
        settingsRepo.deliveryAddress.value.address =
            addresses.first.addressLine;
      });

  }
}
