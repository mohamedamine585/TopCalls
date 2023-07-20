import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:topcalls/Backend/AuthService.dart';
import 'package:topcalls/Backend/CacheService.dart';
import 'package:topcalls/Backend/Cloud_Contact.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:topcalls/Backend/DeviceSystemServiceProvider.dart';
import 'package:topcalls/Backend/firebase_options.dart';
import 'package:topcalls/Frontend/Sync&Cloud.dart';

class FirebaseServiceProvider {
  static late CollectionReference userscollection, devicescollection;

  Future<void> connect({required AuthService authService}) async {
    try {
      Firebase.initializeApp(options: DefaultFirebaseOptions.android);
      devicescollection = FirebaseFirestore.instance.collection("devices");
      userscollection = FirebaseFirestore.instance.collection("users");
      await DeviceSystemServiceProvider().Initiate();
      await authService.initialize_from_Cloud_and_Cache(
          collectionReference: userscollection);
    } catch (e) {
      print(e);
    }
  }

  // outdated
  Future<void> Store_data({required List<String> data}) async {
    try {
      QuerySnapshot querySnapshot =
          await devicescollection.where("Deviceid", isEqualTo: DEVICE_ID).get();
      if (querySnapshot.docs.isEmpty) {
        FirebaseServiceProvider().adddevicedoc(logs: data);
      } else {
        await devicescollection
            .doc(querySnapshot.docs.first.id)
            .update({"logs": data});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatedevicedoc(
      {required List<String> logs, required String docid}) async {
    try {
      await devicescollection
          .doc(docid)
          .update({"logs": logs, "lastconnection": Timestamp.now()});
    } catch (e) {
      print(e);
    }
  }

  Future<void> fuse_docs({required String Email}) async {
    // To complete
    try {
      QueryDocumentSnapshot queryDocumentSnapshot =
          (await userscollection.where("Email", isEqualTo: Email).get())
              .docs
              .single;
      List<String> alldocs =
          queryDocumentSnapshot.data()["DevicesList"] as List<String>;
    } catch (e) {
      print(e);
    }
  }

  Future<void> store_cloud_logs({required List<Cloud_Log> cloud_logs}) async {
    try {
      QuerySnapshot querydevice =
          await devicescollection.where("Deviceid", isEqualTo: DEVICE_ID).get();
      if (querydevice.docs.isEmpty) {
        await adddevicedoc(logs: logs);
      } else {
        await updatedevicedoc(logs: logs, docid: docid);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Cloud_Log>> load_cloud_logs({required String Email}) async {
    List<Cloud_Log> cloud_contacts = [];
    try {
      QuerySnapshot queryuser =
          await userscollection.where("Email", isEqualTo: Email).get();
      QueryDocumentSnapshot queryDocumentSnapshot;
      List<String> logs = [];
      (queryuser.docs.first.data()["logs"] as List<dynamic>).forEach((element) {
        logs.add(element);
      });
      List<String> names = [];
      (queryuser.docs.first.data()["names"] as List<dynamic>)
          .forEach((element) {
        names.add(element);
      });
      List<String> fromdev = [];
      (queryuser.docs.first.data()["fromDevice"] as List<dynamic>)
          .forEach((element) {
        fromdev.add(element);
      });
      for (int i = 0; i < logs.length; i++) {
        cloud_contacts.add(
            Cloud_Log(number: logs[i], name: names[i], fromdevice: fromdev[i]));
      }
    } catch (e) {
      print(e);
    }
    return cloud_contacts;
  }

  Future<List<String>> Load_data({required String Email}) async {
    List<String> contacts = [];
    try {
      QuerySnapshot querydevicesdocs =
          await userscollection.where("Email", isEqualTo: Email).get();
      DocumentSnapshot queryDocumentSnapshot;

      for (String Element in (querydevicesdocs.docs.first.data()["DevicesList"]
          as List<dynamic>)) {
        queryDocumentSnapshot = await devicescollection.doc(Element).get();
        List<dynamic>? devlist =
            (queryDocumentSnapshot.data()["logs"] as List<dynamic>?);

        if (devlist != null) {
          devlist.forEach((element) {
            if (!contacts.contains(element)) {
              contacts.add(element);
            }
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return contacts;
  }

  Future<void> adddevicedoc({
    required List<String> logs,
  }) async {
    try {
      QuerySnapshot queryDevice =
          await devicescollection.where("Deviceid", isEqualTo: DEVICE_ID).get();
      if (queryDevice.docs.isEmpty) {
        await devicescollection.add({
          "Deviceid": DEVICE_ID,
          "logs": logs,
          "lastconnection": Timestamp.now(),
          "owner": ""
        });
        CacheService().ConfirmuserAction("deviceincloud", "true");
      }
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
          "Deviceid": "",
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
