import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceSystemServiceProvider {
  Future<List<MapEntry<String, String>>?> get_mobile_data() async {
    List<MapEntry<String, String>> sim_data = [];
    try {
      await MobileNumber.requestPhonePermission;
      final has_perm = await MobileNumber.hasPhonePermission;
      if (has_perm) {
        FirebaseServiceProvider()
            .cacheservice
            .ConfirmuserAction("phonenumbergiven", "yes");
        final sim_cards = await MobileNumber.getSimCards;
        if (sim_cards != null) {
          for (SimCard one in sim_cards) {
            sim_data
                .add(MapEntry(one.number ?? "NULL", one.carrierName ?? "NULL"));
          }
        }
      } else {
        FirebaseServiceProvider()
            .cacheservice
            .ConfirmuserAction("phonenumbergiven", "no");
        return null;
      }
    } catch (e) {
      print(e);
    }
    return sim_data;
  }

  sync_logs_automatically({required bool sync}) {
    try {
      if (sync) {
        FirebaseServiceProvider()
            .cacheservice
            .ConfirmuserAction("sync", sync.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> logs_sync() async {
    try {
      final sync =
          await FirebaseServiceProvider().cacheservice.ProoveAction("sync");
      if (sync == "true") {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  stay_signed_in({required bool stay}) {
    try {
      FirebaseServiceProvider()
          .cacheservice
          .ConfirmuserAction("stay_signed_in", stay.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<bool> is_stayed_signed_in() async {
    try {
      final stay = await FirebaseServiceProvider()
          .cacheservice
          .ProoveAction("stay_signed_in");
      if (stay == "true") {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

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
