import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:topcalls/Backend/CacheService.dart';
import 'package:topcalls/Backend/Cloud_user.dart';

class AuthService {
  AuthService() {}

  late final CollectionReference collectionReference;

  Cloud_user? cloud_user;

  Future<void> initialize_Cloud_and_Cache(
      {required CollectionReference collectionReference}) async {
    try {
      String? Email = await CacheService().ProoveUserAuthentication("Email");
      if (Email != null && Email != "") {
        QuerySnapshot querySnapshot =
            await collectionReference.where("Email", isEqualTo: Email).get();
        cloud_user = Cloud_user(
            Email: Email,
            password: querySnapshot.docs.single.data()["password"],
            Contact_number: (querySnapshot.docs.single.data()["data"]).length,
            isEmailverified:
                querySnapshot.docs.single.data()["isEmailverified"]);
      } else {
        cloud_user = null;
      }
    } catch (e) {
      cloud_user = null;
      print(e);
    }
  }

  Future<void> Logout() async {
    try {
      CacheService().ConfirmuserAction("Email", "");
    } catch (e) {
      print(e);
    }
  }

  Future<void> Login({
    required CollectionReference collectionReference,
    required String Email,
    required String password,
  }) async {
    try {
      QuerySnapshot querySnapshot = await collectionReference
          .where("Email", isEqualTo: Email)
          .where("password", isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        cloud_user = Cloud_user(
            Email: Email,
            password: password,
            Contact_number: (querySnapshot.docs.first.data()["data"]).length,
            isEmailverified:
                querySnapshot.docs.single.data()["isEmailverified"]);
        CacheService().ConfirmuserAction("Email", Email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> Change_password(
      {required collectionReference,
      required String oldpassword,
      required String newpassword}) async {
    try {
      if (cloud_user?.password == oldpassword) {
        QuerySnapshot querySnapshot = await collectionReference
            .where("password", isEqualTo: oldpassword)
            .where("Email", isEqualTo: cloud_user?.Email)
            .get();
        await collectionReference
            .doc(querySnapshot.docs.single.id)
            .update({"password": newpassword});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> Register({
    required CollectionReference collectionReference,
    required String deviceid,
    required String Email,
    required String password,
  }) async {
    try {
      QuerySnapshot querySnapshot0 = await collectionReference
          .where("deviceid", isEqualTo: deviceid)
          .get();

      QuerySnapshot querySnapshot1 =
          await collectionReference.where("Email", isEqualTo: Email).get();
      if (querySnapshot1.docs.isEmpty) {
        await collectionReference.doc(querySnapshot0.docs.first.id).update(
            {"Email": Email, "password": password, "isEmailverified": false});
        cloud_user = Cloud_user(
            Email: Email,
            password: password,
            Contact_number: (querySnapshot0.docs.first.data()["data"]).length,
            isEmailverified: false);
        CacheService().ConfirmuserAction("Email", Email);
      } else {}
    } catch (e) {
      print(e);
    }
  }
}
