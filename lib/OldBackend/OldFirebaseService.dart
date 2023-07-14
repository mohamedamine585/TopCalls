import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:topcalls/Backend/AuthService.dart';
import 'package:topcalls/Backend/CacheService.dart';
import 'package:topcalls/Backend/Cloud_user.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:topcalls/Backend/firebase_options.dart';

class OLDFirebaseService {
  static late CollectionReference collectionReference;

  Future<void> connect({required AuthService authService}) async {
    try {
      DEVICE_ID = (await DeviceInfoPlugin().androidInfo).androidId;
      FINGERPRINT = (await DeviceInfoPlugin().androidInfo).fingerprint;
      await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
      collectionReference = FirebaseFirestore.instance.collection("users");
      await authService.initialize_from_Cloud_and_Cache(
          collectionReference: collectionReference);
    } catch (e) {
      print(e);
    }
  }

  Future<void> Clear_all_related_data({required String deviceId}) async {
    try {
      QuerySnapshot querySnapshot = await collectionReference
          .where("deviceid", isEqualTo: deviceId)
          .where("Email", isEqualTo: "")
          .get();
      await collectionReference.doc(querySnapshot.docs.single.id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>> Load_data({required String Email}) async {
    List<String> contacts = [];
    try {
      QuerySnapshot querySnapshot =
          await collectionReference.where("Email", isEqualTo: Email).get();
      (querySnapshot.docs.forEach((element) {
        (element.data()["data"] as List<dynamic>).forEach((e) {
          contacts.add(e);
        });
      }));
    } catch (e) {
      print(e);
    }
    return contacts;
  }

  Future<void> Storedata({required List<String> data}) async {
    try {
      QuerySnapshot querySnapshot = await collectionReference
          .where(
            "deviceid",
            isEqualTo: DEVICE_ID,
          )
          .get();

      if (querySnapshot.docs.isEmpty) {
        await collectionReference.add({
          "deviceid": DEVICE_ID,
          "data": data,
          "finger print": FINGERPRINT,
          "Email": "",
          "lastconnection": Timestamp.now()
        });
      } else {
        DocumentSnapshot documentSnapshot =
            await collectionReference.doc(querySnapshot.docs.single.id).get();

        await collectionReference.add({
          "deviceid": DEVICE_ID,
          "data": data,
          "finger print": FINGERPRINT,
          "Email": ""
        });

        List<String> old_data = [];
        List<dynamic> old_data_d = documentSnapshot.data()["data"];
        old_data_d.forEach((element) {
          old_data.add(element);
        });

        data.forEach((element) {
          if (!old_data.contains(element)) {
            old_data.add(element);
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Cloud_user?> register_in_doc(
      {required QuerySnapshot querySnapshot0,
      required String Email,
      required String password}) async {
    try {
      if (querySnapshot0.docs.single.data()["Email"] != "") {
        await collectionReference.add({
          "Email": querySnapshot0.docs.single.data()["Eamil"],
          "data": querySnapshot0.docs.single.data()["data"],
          "lastconnection": querySnapshot0.docs.single.data()["lastconnection"],
          "fingerprint": querySnapshot0.docs.single.data()["fingerprint"]
        });
      }
      await collectionReference.doc(querySnapshot0.docs.single.id).update({
        "Email": Email,
        "password": password,
        "isEmailverified": false,
        "lastconnection": Timestamp.now()
      });
      CacheService().ConfirmuserAction("Email", Email);
      return Cloud_user(
          DevicesList: querySnapshot0.docs.single.data()["DevicesList"],
          Email: Email,
          password: password,
          Contact_number:
              (querySnapshot0.docs.single.data()["DevicesList"]).length,
          isEmailverified: false);
    } catch (e) {
      print(e);
    }
  }

  Future<void> Fuse_docs(
      {required QuerySnapshot querySnapshot, required String Email}) async {
    try {
      List<String> logs = [];
      List<String> fingerprints = [];
      List<String> device_ids = [];
      List<Timestamp> timestamps = [];
      querySnapshot.docs.forEach((element) async {
        if (element.data()["Eamil"] == Email &&
            element.data()["deviceid"] != DEVICE_ID) {
          List<String> data = element.data()["data"] as List<String>;
          logs.addAll(data);
          fingerprints.add(element.data()["fingerprint"]);
          device_ids.add(element.data()["deviceid"]);

          timestamps.add(element.data()["lastconnection"]);
          await collectionReference.doc(element.id).delete();
        } else if (element.data()["Eamil"] == Email &&
            element.data()["deviceid"] == DEVICE_ID) {
          logs.addAll(element.data()["data"]);
        }
      });
      await collectionReference
          .doc(querySnapshot.docs
              .firstWhere((element) => element.data()["Email"] == Email)
              .id)
          .update({
        "pre_devices_ids": device_ids,
        "pre_fingerprints": fingerprints,
        "pre_lastcalls": timestamps,
        "data": logs
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> check_phone_owner() async {
    try {
      QuerySnapshot querySnapshot = await collectionReference
          .where("deviceid", isEqualTo: DEVICE_ID)
          .get();
      DocumentSnapshot documentSnapshot = querySnapshot.docs.single;

      Timestamp lastconnection = documentSnapshot.data()["lastconnection"];
      DateTime lastconnectiondate = lastconnection.toDate();
      if (lastconnectiondate
          .add(const Duration(days: 3))
          .isBefore(DateTime.now())) {
        // ASK Auth ...
      } else {
        await collectionReference
            .doc(documentSnapshot.id)
            .update({"lastconnection": lastconnection});
      }
    } catch (e) {
      print(e);
    }
  }
}




// if(device is new)::
   // normal ...
// else
   // ask to authenticate so the firebase data stay untouched (every three days if Email is utilized)
      // if  auth :: normal and update "lastconnection"
      // else make "deviceid" = "" and isolate doc from his  physical device 
      
// if(someone registered in a new device)
    // transfer any linked data and link his device with his email 
    // search for all docs that are untitled with his email :

    // Fuse them in the newest one 
       // delete the others 