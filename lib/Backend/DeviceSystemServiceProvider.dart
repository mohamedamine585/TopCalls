import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:topcalls/Backend/Consts.dart';

class DeviceSystemServiceProvider {
  Future<bool> check_connection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> Initiate() async {
    try {
      DEVICE_ID = (await DeviceInfoPlugin().androidInfo).androidId;
      FINGERPRINT = (await DeviceInfoPlugin().androidInfo).fingerprint;
    } catch (e) {
      print(e);
    }
  }
}
