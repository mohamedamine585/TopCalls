import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceSystemServiceProvider {
  Future<void> make_call({required String phoneNumber}) async {
    try {
      final url = 'tel:$phoneNumber';

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

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
