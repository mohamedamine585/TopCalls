import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:topcalls/Backend/Cloud_user.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';
import 'package:topcalls/Backend/Services/CacheService.dart';

class Authservice {
  static final Authservice _instance = Authservice._();
  Authservice._();

  factory Authservice() => _instance;

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
        ((querySnapshot.docs.single.data() as dynamic)["DevicesList"]
                as List<dynamic>)
            .forEach((element) {
          lists.add(element);
        });
        cloud_user = Cloud_user(
            Email: Email,
            DevicesList: lists,
            password: (querySnapshot.docs.single.data() as dynamic)["password"],
            Contacts_number: lists.length,
            isEmailverified: (querySnapshot.docs.single.data()
                as dynamic)["isEmailverified"]);
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

      await FirebaseServiceProvider()
          .usersMangementService
          .link_device_and_user(Email: Email);
      ((querySnapshot0.docs.single.data() as dynamic)["DevicesList"]
              as List<dynamic>)
          .forEach((element) {
        devices.add(element);
      });

      print("object");
      cloud_user = Cloud_user(
          Email: Email,
          password: password,
          DevicesList: devices,
          Contacts_number: devices.length,
          isEmailverified: (querySnapshot0.docs.single.data()
              as dynamic)["isEmailverified"]);
      CacheService().ConfirmuserAction("Email", Email);
    } catch (e) {
      print(e);
      cloud_user = null;
    }
  }

  Future<void> Register({
    required String Email,
    required String password,
  }) async {
    try {
      QuerySnapshot? querySnapshot0 = await FirebaseServiceProvider()
          .usersMangementService
          .adduserdoc(Email: Email, password: password);

      CacheService().ConfirmuserAction("Email", Email);

      List<String> devlist = [];
      ((querySnapshot0?.docs.single.data() as dynamic)["DevicesList"]
              as List<dynamic>)
          .forEach((element) {
        devlist.add(element);
      });

      if (querySnapshot0 != null) {
        List<String> his_logs = await FirebaseServiceProvider()
            .devicesMangementService
            .Load_data(Email: Email);
        cloud_user = Cloud_user(
            Email: Email,
            DevicesList: devlist,
            password: password,
            Contacts_number: devlist.length,
            isEmailverified: (querySnapshot0.docs.single.data()
                as dynamic)["isEmailverified"]);
      } else {
        cloud_user = null;
      }
    } catch (e) {
      print(e);
    }
  }
}
