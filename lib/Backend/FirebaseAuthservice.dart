import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topcalls/Backend/CacheService.dart';
import 'package:topcalls/Backend/Cloud_user.dart';

class AuthService {
  late final CollectionReference collectionReference;
  Cloud_user? cloud_user;
  AuthService() {
    _initialize();
  }
  Future<void> _initialize() async {
    try {
      String? Email = await CacheService().GetConfirmation("Email");
      if (Email != null && Email != "") {
        QuerySnapshot querySnapshot =
            await collectionReference.where("Email", isEqualTo: Email).get();
        cloud_user = Cloud_user(
            Email: Email,
            password: querySnapshot.docs.single.data()["password"],
            Contact_number:
                (querySnapshot.docs.single.data()["data"] as List<String>)
                    .length,
            isEmailverified:
                querySnapshot.docs.single.data()["isEmailverified"]);
      }
    } catch (e) {
      print(e);
    }
    cloud_user = null;
  }

  Future<void> Logout() async {
    try {
      CacheService().ConfirmUserAction("Email", "");
    } catch (e) {
      print(e);
    }
  }

  Future<void> Login({
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
            Contact_number:
                (querySnapshot.docs.first.data()["data"] as List<String>)
                    .length,
            isEmailverified:
                querySnapshot.docs.single.data()["isEmailverified"]);
        CacheService().ConfirmUserAction("Email", Email);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> Register(
      {required String deviceid,
      required String Email,
      required String password,
      required CollectionReference collectionReference}) async {
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
            Contact_number:
                (querySnapshot0.docs.first.data()["data"] as List<String>)
                    .length,
            isEmailverified: false);
        CacheService().ConfirmUserAction("Email", Email);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
