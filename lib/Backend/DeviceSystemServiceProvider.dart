import 'package:device_info/device_info.dart';
import 'package:topcalls/Backend/Consts.dart';

class DeviceSystemServiceProvider {
  Future<void> Initiate() async {
    try {
      DEVICE_ID = (await DeviceInfoPlugin().androidInfo).androidId;
      FINGERPRINT = (await DeviceInfoPlugin().androidInfo).fingerprint;
    } catch (e) {
      print(e);
    }
  }
}
