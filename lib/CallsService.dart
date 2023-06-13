import 'package:topcalls/Call.dart';
import 'package:call_log/call_log.dart';

class CallsService {
  Future<List<Contact>>? fetch_top_cotnact() async {
    try {
      Iterable<CallLogEntry> entries = await CallLog.get();
      entries = await CallLog.query();
      Map<String, Contact> callsmap = {};
      List<Contact> listcontact = [];
      entries.forEach((element) {
        Contact? c0 = callsmap[element.number ?? ""];
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(element.timestamp ?? 0);
        if (c0 != null) {
          if (dateTime.isBefore(c0.lastcall)) {
            dateTime = c0.lastcall;
          }
        }
        callsmap[element.number ?? ""] = Contact(element.number ?? "", dateTime,
            (c0?.totalduration ?? 0) + (element.duration ?? 0));
      });
      callsmap.forEach((key, value) {
        listcontact.add(value);
      });
      listcontact.sort((a, b) => b.totalduration.compareTo(a.totalduration));
      return listcontact;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
