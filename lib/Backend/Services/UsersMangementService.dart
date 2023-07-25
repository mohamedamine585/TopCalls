import 'package:cloud_firestore/cloud_firestore.dart';

import '../Consts.dart';

class UsersMangementService {
  CollectionReference userscollection, devicescollection;
  UsersMangementService(this.userscollection, this.devicescollection);

  Future<void> unify_accounts(
      {required String email1,
      required String password1,
      required String email2,
      required String password2}) async {
    try {} catch (e) {
      print(e);
    }
  }

  Future<void> black_list_him({required String log}) async {
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

  Future<void> link_device_and_user({required String Email}) async {
    try {
      String email;
      QuerySnapshot queryuser =
          await userscollection.where("Email", isEqualTo: Email).get();

      QuerySnapshot querydevice =
          await devicescollection.where("Deviceid", isEqualTo: DEVICE_ID).get();

      if (querydevice.docs.first.data()["owner"] != Email &&
          querydevice.docs.first.data()["owner"] != "") {
        email = querydevice.docs.first.data()["owner"];
        DocumentReference newotherdoc = await devicescollection.add({
          "owner": email,
          "logs": querydevice.docs.first.data()["logs"],
          "names": querydevice.docs.first.data()["names"],
          "fromdevice": querydevice.docs.first.data()["fromdevice"],
          "Deviceid": "",
          "Deviceid2": DEVICE_ID
        });
        await userscollection
            .doc((await userscollection.where("Email", isEqualTo: email).get())
                .docs
                .single
                .id)
            .update({
          "DevicesList":
              (await userscollection.where("Email", isEqualTo: email).get())
                      .docs
                      .single
                      .data()["DevicesList"] +
                  [newotherdoc.id]
        });
        await remove_doc_from_user(
            Email: email,
            docs: queryuser.docs,
            deviceid: querydevice.docs.first.id,
            userscollection: userscollection);
      }
      List<String> DevicesList = [];
      (await queryuser.docs.first.data()["DevicesList"] as List<dynamic>)
          .forEach((element) {
        DevicesList.add(element);
      });
      List<dynamic> what_to_add;
      if (DevicesList.contains(querydevice.docs.first.id)) {
        what_to_add = [];
      } else {
        what_to_add = [querydevice.docs.first.id];
      }
      print(what_to_add);
      await userscollection.doc(queryuser.docs.first.id).update({
        "DevicesList": queryuser.docs.first.data()["DevicesList"] + what_to_add
      });
      await devicescollection
          .doc(querydevice.docs.first.id)
          .update({"owner": Email});
    } catch (e) {
      print(e);
    }
  }

  Future<void> remove_doc_from_user(
      {required String Email,
      required List<QueryDocumentSnapshot> docs,
      required String deviceid,
      required CollectionReference userscollection}) async {
    try {
      QueryDocumentSnapshot old_owner =
          (await userscollection.where("Email", isEqualTo: Email).get())
              .docs
              .single;

      List<dynamic> old_devices = old_owner.data()["DevicesList"];

      old_devices.removeWhere((element) => element == deviceid);
      print(deviceid);

      await userscollection
          .doc((await userscollection.where("Email", isEqualTo: Email).get())
              .docs
              .first
              .id)
          .update({"DevicesList": old_devices});
    } catch (e) {
      print(e);
    }
  }

  Future<QuerySnapshot?> adduserdoc({
    required String Email,
    required String password,
  }) async {
    try {
      QuerySnapshot queryusers =
          await userscollection.where("Email", isEqualTo: Email).get();

      QuerySnapshot querydevices =
          await devicescollection.where("Deviceid", isEqualTo: DEVICE_ID).get();

      if (querydevices.docs.isNotEmpty) {
        if (queryusers.docs.isEmpty) {
          await userscollection.add({
            "Email": Email,
            "password": password,
            "lastconnection": Timestamp.now(),
            "isEmailverified": false,
            "DevicesList": [querydevices.docs.first.id]
          });
        }
      }

      String otherowneremail = querydevices.docs.first.data()["owner"];
      if (otherowneremail != "") {
        await devicescollection.add({
          "Deviceid2": DEVICE_ID,
          "Deviceid": "",
          "owner": otherowneremail,
          "lastconnection": querydevices.docs.first.data()["lastconnection"],
          "logs": querydevices.docs.single.data()["logs"],
        });
        await devicescollection.doc(querydevices.docs.first.id).update({
          "Deviceid": DEVICE_ID,
          "owner": Email,
          "logs": [],
          "lastconnection": Timestamp.now()
        });
        await remove_doc_from_user(
            Email: otherowneremail,
            docs: (await userscollection.where("Email", isEqualTo: Email).get())
                .docs,
            deviceid: querydevices.docs.first.id,
            userscollection: userscollection);
      } else {
        await devicescollection
            .doc((await devicescollection
                    .where("Deviceid", isEqualTo: DEVICE_ID)
                    .get())
                .docs
                .single
                .id)
            .update({"owner": Email});
      }

      return await userscollection.where("Email", isEqualTo: Email).get();
    } catch (e) {
      print(e);
    }
    return null;
  }
}
