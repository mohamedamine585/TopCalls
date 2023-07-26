import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:topcalls/Backend/Services/DeviceSystemServiceProvider.dart';
import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Backend/Services/DevicesMangement.dart';
import 'package:topcalls/Backend/Services/LogsMangementService.dart';
import 'package:topcalls/Backend/Services/UsersMangementService.dart';
import 'package:topcalls/Backend/firebase_options.dart';

class FirebaseServiceProvider {
  late CollectionReference userscollection, devicescollection;

  LogsMangementService get logsmangementservice =>
      LogsMangementService(userscollection, devicescollection);

  DevicesMangementService get devicesMangementService =>
      DevicesMangementService(userscollection, devicescollection);

  UsersMangementService get usersMangementService =>
      UsersMangementService(userscollection, devicescollection);

  static final FirebaseServiceProvider _instance = FirebaseServiceProvider._();

  FirebaseServiceProvider._();
  factory FirebaseServiceProvider() => _instance;

  Future<void> connect() async {
    try {
      Authservice authService = Authservice();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
      devicescollection = FirebaseFirestore.instance.collection("devices");
      userscollection = FirebaseFirestore.instance.collection("users");
      await DeviceSystemServiceProvider().Initiate();
      await authService.initialize_from_Cloud_and_Cache(
          collectionReference: userscollection);
    } catch (e) {
      print(e);
    }
  }
}
