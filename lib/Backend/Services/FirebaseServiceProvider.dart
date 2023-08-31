import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:topcalls/Backend/Services/AccountMangementService.dart';
import 'package:topcalls/Backend/Services/CacheService.dart';

import 'package:topcalls/Backend/Services/DeviceSystemServiceProvider.dart';
import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Backend/Services/DevicesMangement.dart';
import 'package:topcalls/Backend/Services/LogsMangementService.dart';
import 'package:topcalls/Backend/Services/NotificationService.dart';
import 'package:topcalls/Backend/Services/UsersMangementService.dart';
import 'package:topcalls/Backend/firebase_options.dart';

class FirebaseServiceProvider {
  late CollectionReference userscollection,
      devicescollection,
      notificationscollection;

  CacheService get cacheservice => CacheService();

  DeviceSystemServiceProvider get systemmangementprovider =>
      DeviceSystemServiceProvider();
  LogsMangementService get logsmangementservice =>
      LogsMangementService(userscollection, devicescollection);

  DevicesMangementService get devicesMangementService =>
      DevicesMangementService();

  UsersMangementService get usersMangementService =>
      UsersMangementService(userscollection, devicescollection);

  AccountMangementService get accountmangementservice =>
      AccountMangementService();
  NotificationsService get notificationsservice =>
      NotificationsService(userscollection, notificationscollection);

  static final FirebaseServiceProvider _instance = FirebaseServiceProvider._();

  FirebaseServiceProvider._();
  factory FirebaseServiceProvider() => _instance;

  Future<bool?> connect() async {
    try {
      Authservice authService = Authservice();
      if (await systemmangementprovider.check_connection()) {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
        devicescollection = FirebaseFirestore.instance.collection("devices");
        userscollection = FirebaseFirestore.instance.collection("users");
        notificationscollection =
            FirebaseFirestore.instance.collection("notifications");

        await DeviceSystemServiceProvider().Initiate();
        await authService.initialize_from_Cloud_and_Cache(
            collectionReference: userscollection);
        return true;
      } else {
        authService.user = null;
        return false;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
