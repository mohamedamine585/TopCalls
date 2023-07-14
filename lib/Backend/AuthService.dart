import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:topcalls/Backend/CacheService.dart';
import 'package:topcalls/Backend/Cloud_user.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:topcalls/Backend/FirebaseServiceProvider.dart';
import 'package:topcalls/OldBackend/OldFirebaseService.dart';

class AuthService {
  late final CollectionReference collectionReference;

  Cloud_user? cloud_user;

  Future<void> initialize_from_Cloud_and_Cache(
      {required CollectionReference collectionReference}) async {
    try {
      String? Email = await CacheService().ProoveUserAuthentication("Email");
      if (Email != null && Email != "") {
        QuerySnapshot querySnapshot =
            await collectionReference.where("Email", isEqualTo: Email).get();
        List<String> lists = [];
        (querySnapshot.docs.single.data()["DevicesList"] as List<dynamic>)
            .forEach((element) {
          lists.add(element);
        });
        cloud_user = Cloud_user(
            Email: Email,
            DevicesList: lists,
            password: querySnapshot.docs.single.data()["password"],
            Contact_number: lists.length,
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
      QuerySnapshot querySnapshot0 = await collectionReference
          .where("Email", isEqualTo: Email)
          .where("password", isEqualTo: password)
          .get();
      List<String> devices = [];

      await FirebaseServiceProvider().link_device_and_user(Email: Email);
      (querySnapshot0.docs.single.data()["DevicesList"] as List<dynamic>)
          .forEach((element) {
        devices.add(element);
      });

      print("object");
      cloud_user = Cloud_user(
          Email: Email,
          password: password,
          DevicesList: devices,
          Contact_number: devices.length,
          isEmailverified:
              querySnapshot0.docs.single.data()["isEmailverified"]);
      CacheService().ConfirmuserAction("Email", Email);
    } catch (e) {
      print(e);
      cloud_user = null;
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
    required String Email,
    required String password,
  }) async {
    try {
      QuerySnapshot? querySnapshot0 = await FirebaseServiceProvider()
          .adduserdoc(Email: Email, password: password);

      CacheService().ConfirmuserAction("Email", Email);

      if (querySnapshot0 != null) {
        cloud_user = Cloud_user(
            Email: Email,
            DevicesList: querySnapshot0.docs.single.data()["DevicesList"],
            password: password,
            Contact_number:
                (querySnapshot0.docs.single.data()["DevicesList"]).length,
            isEmailverified:
                querySnapshot0.docs.single.data()["isEmailverified"]);
      } else {
        cloud_user = null;
      }
    } catch (e) {
      print(e);
    }
  }
}
