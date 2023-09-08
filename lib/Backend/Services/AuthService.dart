import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:crypto/crypto.dart';
import 'package:topcalls/Backend/Modules/Cloud_user.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';
import 'package:topcalls/Backend/Services/CacheService.dart';

class Authservice {
  static final Authservice _instance = Authservice._();
  Authservice._();

  factory Authservice() => _instance;

  late final CollectionReference collectionReference;
  Cloud_user? user;

  Future<void> initialize_from_Cloud_and_Cache(
      {required CollectionReference collectionReference}) async {
    try {
      String? Email = await CacheService().ProoveAction("Email");
      if (Email != null && Email != "") {
        user = await Cloud_user.get_by_email(
            email: Email, collectionReference: collectionReference);
      } else {
        user = null;
      }
    } catch (e) {
      user = null;
      print(e);
    }
  }

  void Logout() async {
    try {
      CacheService().ConfirmuserAction("Email", "");
      user = null;
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
      QuerySnapshot? querySnapshot0 = await collectionReference
          .where("Email", isEqualTo: Email)
          .where("password", isEqualTo: hash_it(to_be_hashed: password))
          .get();
      await FirebaseServiceProvider()
          .usersMangementService
          .link_device_and_user(Email: Email);
      user = Cloud_user.from_firebase(
          data: querySnapshot0.docs.first.data() as Map<String, dynamic>);

      CacheService().ConfirmuserAction("Email", Email);
    } catch (e) {
      print(e);
      user = null;
    }
  }

  Future<void> Register({
    required String Email,
    required String password,
  }) async {
    try {
      ////
      ////// get mobile_data
      ///

      final mobiledata = await FirebaseServiceProvider()
          .systemmangementprovider
          .get_mobile_data();
      List<String> phonenumbers = [], simcards = [];
      mobiledata?.forEach((element) {
        phonenumbers.add(element.key);
        simcards.add(element.value);
      });

      ///
      ////
      ///
      ///
      ///

      ////
      ///// create a doc for a user and may be it will be only assigned
      ///
      QuerySnapshot? querySnapshot0 = await FirebaseServiceProvider()
          .usersMangementService
          .adduserdoc(
              Email: Email,
              password: hash_it(to_be_hashed: password),
              phonenumbers: phonenumbers,
              simcards: simcards);

      ////
      ///
      ///
      ///  Store Email in cache for auto future login

      CacheService().ConfirmuserAction("Email", Email);

      ////
      ///
      ///// we have a new cloud_user
      ///
      if (querySnapshot0 != null) {
        user = Cloud_user.from_firebase_first_time(
            data: querySnapshot0.docs.first,
            phonenumbers: phonenumbers,
            simcards: simcards);

        ////
      } else {
        user = null;
      }
    } catch (e) {
      print(e);
    }
  }

  String hash_it({required String to_be_hashed}) {
    return Crypt.sha256(to_be_hashed).hash;
  }
}
