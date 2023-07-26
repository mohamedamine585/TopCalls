import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topcalls/Backend/Services/DevicesMangement.dart';

import '../Cloud_Contact.dart';
import '../Consts.dart';

class LogsMangementService {
  CollectionReference userscollection, devicescollection;
  LogsMangementService(this.userscollection, this.devicescollection);

  Future<void> share_it_with(
      {required Cloud_Log log, required String email}) async {
    try {
      QuerySnapshot querySnapshot =
          await userscollection.where("Email", isEqualTo: email).get();

      bool is_in = false;
      List<Cloud_Log> his_logs =
              await DevicesMangementService(userscollection, devicescollection)
                  .load_cloud_logs(Email: email),
          his_black_logs =
              await DevicesMangementService(userscollection, devicescollection)
                  .load_black_list(email: email);

      // look if he already has it
      for (Cloud_Log Log in his_logs) {
        if (Log.number == log.number) {
          is_in = true;
        }
      }
      // if he hasn't already the log and if he didn't black list it
      if (is_in == false && !his_black_logs.contains(log)) {
        QuerySnapshot query_device = await devicescollection
            .where("owner", isEqualTo: email)
            .where("Deviceid", isEqualTo: "")
            .get();

        List<dynamic>? importedlogs =
            query_device.docs.first.data()["imported logs index"];
        await devicescollection.doc(query_device.docs.first.id).update({
          "logs": query_device.docs.first.data()["logs"] + [log.number],
          "names": query_device.docs.first.data()["names"] + [log.name],
          "fromdev":
              query_device.docs.first.data()["fromdev"] + [log.fromdevice],
          "imported logs index": (importedlogs != null)
              ? importedlogs +
                  [
                    (query_device.docs.first.data()["logs"] as List<dynamic>)
                        .length
                  ]
              : [
                  (query_device.docs.first.data()["logs"] as List<dynamic>)
                      .length
                ]
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> black_list_it({required String log}) async {
    try {
      QuerySnapshot querydevicedoc =
          await devicescollection.where("Deviceid", isEqualTo: DEVICE_ID).get();
      DocumentSnapshot devicedoc = querydevicedoc.docs.first;
      List<dynamic> current_logs = devicedoc.data()["logs"];
      List<dynamic> current_names = devicedoc.data()["names"];
      List<dynamic> current_fromdev = devicedoc.data()["fromdev"];
      int index = current_logs.indexWhere((element) => element == log);
      String name = current_names.elementAt(index),
          fromdev = current_fromdev.elementAt(index);

      current_logs.remove(log);
      current_names.removeAt(index);
      current_fromdev.removeAt(index);
      List<dynamic>? black_list_logs =
          devicedoc.data()["black list logs"] as List<dynamic>?;
      List<dynamic>? black_list_names =
          devicedoc.data()["black list names"] as List<dynamic>?;
      List<dynamic>? black_list_fromdev =
          devicedoc.data()["black list fromdev"] as List<dynamic>?;
      if (black_list_logs == null) {
        black_list_logs = [];
        black_list_fromdev = [];
        black_list_names = [];
      }
      await devicescollection.doc(devicedoc.id).update({
        "logs": current_logs,
        "names": current_names,
        "fromdev": current_fromdev,
        "black list logs": black_list_logs + [log],
        "black list names": black_list_names! + [name],
        "black list fromdev": black_list_fromdev! + [fromdev],
      });
    } catch (e) {
      print(e);
    }
  }
}
