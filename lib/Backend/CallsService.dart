import 'package:firebase_core/firebase_core.dart';
import 'package:topcalls/Backend/Contact.dart';
import 'package:call_log/call_log.dart';
import 'package:topcalls/Backend/FirebaseServiceProvider.dart';

class CallsService {
  Future<List<Contact>>? fetch_top_contact() async {
    List<Contact> listcontact = [];
    try {
      Iterable<CallLogEntry> entries = await CallLog.get();
      entries = await CallLog.query();
      Map<String, Contact> callsmap = {};

      entries.forEach((element) {
        Contact? c0 = callsmap[element.number ?? ""];
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(element.timestamp ?? 0);
        if (c0 != null) {
          if (dateTime.isBefore(c0.lastcall)) {
            dateTime = c0.lastcall;
          }
        }

        callsmap[element.number ?? ""] = Contact(
            element.number ?? "",
            element.name ?? "",
            dateTime,
            (c0?.totalduration ?? 0) + (element.duration ?? 0));
      });
      callsmap.forEach((key, value) {
        listcontact.add(value);
      });
      listcontact.sort((a, b) => b.totalduration.compareTo(a.totalduration));
      List<String> list = [];

      listcontact.forEach(
        (element) {
          list.add(element.contact);
        },
      );
      List<String> cloud_data = [];
      listcontact.forEach((element) {
        cloud_data.add(element.contact);
      });

      await FirebaseServiceProvider().Store_data(data: cloud_data);
    } catch (e) {
      print(e);
    }
    return listcontact;
  }
}
