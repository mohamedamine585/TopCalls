import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:topcalls/Backend/Cloud_Contact.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';
import 'package:topcalls/Backend/Services/UsersMangementService.dart';

class NotificationsService {
  CollectionReference userscollection, notifactionscollection;
  NotificationsService(this.userscollection, this.notifactionscollection);
  Future<void> accept_share_number({required String notification_id}) async {
    try {
      DocumentReference not_doc =
          await notifactionscollection.doc(notification_id);
      await not_doc.update({
        "status": "accepted",
        "timestampofaccept": Timestamp.now(),
      });
      DocumentSnapshot documentSnapshot = await not_doc.get();
      await FirebaseServiceProvider().logsmangementservice.add_share_log(
          log: Cloud_Log(
              number: (documentSnapshot.data() as dynamic)["log"],
              name: (documentSnapshot.data() as dynamic)["name"],
              fromdevice: (documentSnapshot.data() as dynamic)["fromdevice"]),
          email: (documentSnapshot.data() as dynamic)["receiver"]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> send_share_log_not(
      {required String sender,
      required String receiver,
      required Cloud_Log log}) async {
    try {
      List<String> what_he_has = await FirebaseServiceProvider()
          .devicesMangementService
          .Load_data(Email: receiver);
      await notifactionscollection.add({
        "status": "sent",
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
