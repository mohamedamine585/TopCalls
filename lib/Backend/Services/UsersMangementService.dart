import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topcalls/Backend/Modules/Cloud_user.dart';

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

  Future<void> link_device_and_user({required String Email}) async {
    try {
      String email;
      QuerySnapshot queryuser =
          await userscollection.where("Email", isEqualTo: Email).get();

      QuerySnapshot querydevice =
          await devicescollection.where("Deviceid", isEqualTo: DEVICE_ID).get();

      if ((querydevice.docs.first.data() as dynamic)["owner"] != Email &&
          (querydevice.docs.first.data() as dynamic)["owner"] != "") {
        email = (querydevice.docs.first.data() as dynamic)["owner"];
        DocumentReference newotherdoc = await devicescollection.add({
          "owner": email,
          "logs": (querydevice.docs.first.data() as dynamic)["logs"],
          "names": (querydevice.docs.first.data() as dynamic)["names"],
          "fromdevice":
              (querydevice.docs.first.data() as dynamic)["fromdevice"],
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
              ((await userscollection.where("Email", isEqualTo: email).get())
                      .docs
                      .single
                      .data() as dynamic)["DevicesList"] +
                  [newotherdoc.id]
        });
        await remove_doc_from_user(
            Email: email,
            docs: queryuser.docs,
            deviceid: querydevice.docs.first.id,
            userscollection: userscollection);
      }
      List<String> DevicesList = [];
      (await (queryuser.docs.first.data() as dynamic)["DevicesList"]
              as List<dynamic>)
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
        "DevicesList": (queryuser.docs.first.data() as dynamic)["DevicesList"] +
            what_to_add
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
      Cloud_user? old_owner = await Cloud_user.get_by_email(
          email: Email, collectionReference: userscollection);

      List<String> old_devices = old_owner!.DevicesList;

      old_devices.removeWhere((element) => element == deviceid);

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
    List<String>? phonenumbers,
    List<String>? simcards,
  }) async {
    try {
      QuerySnapshot queryusers =
          await userscollection.where("Email", isEqualTo: Email).get();

      QuerySnapshot querydevices =
          await devicescollection.where("Deviceid", isEqualTo: DEVICE_ID).get();

      if (querydevices.docs.isNotEmpty) {
        if (queryusers.docs.isEmpty) {
          final logs = (querydevices.docs.first.data() as dynamic)["logs"]
              as List<dynamic>;

          await userscollection.add({
            "Email": Email,
            "password": password,
            "lastconnection": Timestamp.now(),
            "isEmailverified": false,
            "DevicesList": [querydevices.docs.first.id],
            "logsnumber": logs.length,
            "phonenumbers": phonenumbers,
            "simcards": simcards
          });
        }
      }

      String otherowneremail =
          (querydevices.docs.first.data() as dynamic)["owner"];
      if (otherowneremail != "") {
        final logs = (querydevices.docs.first.data() as dynamic)["logs"];
        final names = (querydevices.docs.first.data() as dynamic)["names"];
        final fromdevice =
            (querydevices.docs.first.data() as dynamic)["fromdevice"];
        await devicescollection.add({
          "Deviceid2": DEVICE_ID,
          "Deviceid": "",
          "owner": otherowneremail,
          "lastconnection":
              (querydevices.docs.first.data() as dynamic)["lastconnection"],
          "logs": logs,
          "names": names,
          "fromdevice": fromdevice
        });

        await devicescollection.doc(querydevices.docs.first.id).update({
          "Deviceid": DEVICE_ID,
          "owner": Email,
          "logs": [],
          "names": [],
          "fromdevice": [],
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
