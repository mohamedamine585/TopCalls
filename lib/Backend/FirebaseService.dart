import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:topcalls/Backend/Call.dart';
import 'package:topcalls/Backend/firebase_options.dart';

class FirebaseService {
  static CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");
  Future<void> connect() async {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>> Load_data({required String Email}) async {
    List<String> contacts = [];
    try {
      QuerySnapshot querySnapshot =
          await collectionReference.where("Email", isEqualTo: Email).get();
      (querySnapshot.docs.single.data()["data"] as List<String>)
          .forEach((element) {
        contacts.add(element);
      });
    } catch (e) {
      print(e);
    }
    return contacts;
  }

  Future<void> Storedata({required List<String> data}) async {
    try {
      String deviceid = (await DeviceInfoPlugin().androidInfo).androidId;
      String fingerprint = (await DeviceInfoPlugin().androidInfo).fingerprint;
      QuerySnapshot querySnapshot = await collectionReference
          .where("deviceid", isEqualTo: deviceid)
          .get();
      if (querySnapshot.docs.isEmpty) {
        await collectionReference.add(
            {"deviceid": deviceid, "data": data, "finger print": fingerprint});
      } else {
        DocumentSnapshot documentSnapshot =
            await collectionReference.doc(querySnapshot.docs.first.id).get();
        List<String> old_data = documentSnapshot.data()["data"];
        data.forEach((element) {
          if (!old_data.contains(element)) {
            old_data.add(element);
          }
        });
        await collectionReference
            .doc(querySnapshot.docs.first.id)
            .update({"data": old_data});
      }
    } catch (e) {
      print(e);
    }
  }
}
