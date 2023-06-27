import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:topcalls/Call.dart';
import 'package:topcalls/firebase_options.dart';

class FirebaseService {
  Future<void> connect() async {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    } catch (e) {
      print(e);
    }
  }

  Future<void> Storedata({required List<String> data}) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("users");
      String deviceid = (await DeviceInfoPlugin().androidInfo).androidId;
      String fingerprint = (await DeviceInfoPlugin().androidInfo).fingerprint;
      QuerySnapshot querySnapshot = await collectionReference
          .where("deviceid", isEqualTo: deviceid)
          .get();
      if (querySnapshot.docs.isEmpty) {
        await collectionReference.add(
            {"deviceid": deviceid, "data": data, "finger print": fingerprint});
      } else {
        await collectionReference
            .doc(querySnapshot.docs.first.id)
            .update({"data": data});
      }
    } catch (e) {
      print(e);
    }
  }
}
