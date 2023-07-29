import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topcalls/Backend/Cloud_Contact.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';
import 'package:topcalls/Backend/Services/UsersMangementService.dart';

class NotificationsService {
  CollectionReference userscollection, notifactionscollection;
  NotificationsService(this.userscollection, this.notifactionscollection);
  Future<void> send_share_log_not(
      {required String sender,
      required String receiver,
      required Cloud_Log log}) async {
    try {
      List<String> what_he_has = await FirebaseServiceProvider()
          .devicesMangementService
          .Load_data(Email: receiver);
      await notifactionscollection.add({
        "sender": sender,
        "receiver": receiver,
        "topic": "share_log",
        "log": log.number,
        "name": log.name,
        "timestamp": Timestamp.now(),
        "fromdevice": DEVICE_ID,
        "alreadyhas": what_he_has.contains(log.number),
        "nameifhas": (what_he_has.contains(log.number)) ? log.name : null
      });
    } catch (e) {
      print(e);
    }
  }
}
