import 'package:cloud_firestore/cloud_firestore.dart';

import 'CacheService.dart';
import '../Cloud_Contact.dart';
import '../Consts.dart';

class DevicesMangementService {
  CollectionReference userscollection, devicescollection;

  DevicesMangementService(this.userscollection, this.devicescollection);

  Future<void> Store_data({required List<String> data}) async {
    try {
      QuerySnapshot querySnapshot =
          await devicescollection.where("Deviceid", isEqualTo: DEVICE_ID).get();
      if (querySnapshot.docs.isEmpty) {
        adddevicedoc(logs: data);
      } else {
        await devicescollection
            .doc(querySnapshot.docs.first.id)
            .update({"logs": data});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> update_devicedoc(
      {required List<String> logs,
      required List<String> names,
      required List<String> fromdevice,
      required String docid}) async {
    try {
      await devicescollection.doc(docid).update({
        "logs": logs,
        "names": names,
        "fromdevice": fromdevice,
        "lastconnection": Timestamp.now()
      });
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

  Future<List<Cloud_Log>> load_black_list({required String email}) async {
    List<Cloud_Log> black_logs = [];
    try {
      QuerySnapshot queryuser =
          await userscollection.where("Email", isEqualTo: email).get();
      List<dynamic> devices = queryuser.docs.first.data()["Devicesid"];
      DocumentSnapshot documentSnapshot;
      for (dynamic device in devices) {
        documentSnapshot = await devicescollection.doc(device).get();
        List<dynamic> b_logs = documentSnapshot.data()["black list logs"];
        List<dynamic> b_names = documentSnapshot.data()["black list names"];
        List<dynamic> b_fromdev = documentSnapshot.data()["black list fromdev"];
        for (int i = 0; i < b_logs.length; i++) {
          black_logs.add(Cloud_Log(
              number: b_logs[i], name: b_names[i], fromdevice: b_fromdev[i]));
        }
      }
    } catch (e) {
      print(e);
    }
    return black_logs;
  }

  Future<void> store_cloud_logs({required List<Cloud_Log> cloud_logs}) async {
    try {
      QuerySnapshot querydevice =
          await devicescollection.where("Deviceid", isEqualTo: DEVICE_ID).get();
      List<dynamic> current_logs = await querydevice.docs.first.data()["logs"];
      List<String> logs, names, fromdevice;
      logs = [];
      names = [];
      fromdevice = [];
      cloud_logs.forEach((element) {
        if (!current_logs.contains(element)) {
          logs.add(element.number);
          names.add(element.name);
          fromdevice.add(DEVICE_ID ?? "");
        }
      });
      if (querydevice.docs.isEmpty) {
        await add_devicedoc(logs: logs, names: names, fromdevice: fromdevice);
      } else {
        await update_devicedoc(
            logs: logs,
            names: names,
            fromdevice: fromdevice,
            docid: querydevice.docs.first.id);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Cloud_Log>> load_cloud_logs({required String Email}) async {
    List<Cloud_Log> cloud_contacts = [];
    try {
      userscollection = FirebaseFirestore.instance.collection("users");
      QuerySnapshot queryuser =
          await userscollection.where("Email", isEqualTo: Email).get();
      List<dynamic> logs = [];
      List<dynamic> names = [];
      List<dynamic> fromdev = [];
      for (dynamic Element
          in (queryuser.docs.first.data()["DevicesList"] as List<dynamic>)) {
        DocumentSnapshot documentSnapshot =
            await devicescollection.doc(Element).get();
        logs.addAll(documentSnapshot.data()["logs"] as List<dynamic>);
        names.addAll(documentSnapshot.data()["names"] as List<dynamic>);
        fromdev.addAll(documentSnapshot.data()["fromdevice"] as List<dynamic>);
      }
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
      userscollection = FirebaseFirestore.instance.collection("users");
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

  Future<void> add_devicedoc(
      {required List<String> logs,
      required List<String> names,
      required List<String> fromdevice}) async {
    try {
      QuerySnapshot querydevice =
          await devicescollection.where("deviceid", isEqualTo: DEVICE_ID).get();
      if (querydevice.docs.isEmpty) {
        await devicescollection.add({
          "Deviceid": DEVICE_ID,
          "logs": logs,
          "fromdevice": fromdevice,
          "names": names,
          "lastconnection": Timestamp.now(),
          "owner": ""
        });
        CacheService().ConfirmuserAction("deviceincloud", "true");
      }
    } catch (e) {
      print(e);
    }
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
}
