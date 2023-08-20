import 'package:topcalls/Backend/Cloud_Contact.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:call_log/call_log.dart';

class LogsService {
  Future<List<Cloud_Log>> fetch_top_contact() async {
    List<Cloud_Log> listcontact = [];
    try {
      Iterable<CallLogEntry> entries = await CallLog.get();
      entries = await CallLog.query();
      Map<String, Cloud_Log> callsmap = {};

      entries.forEach((element) {
        callsmap[element.number ?? ""] = Cloud_Log(
            number: element.number ?? "",
            name: element.name ?? "",
            fromdevice: DEVICE_ID ?? "");
      });
      callsmap.forEach((key, value) {
        listcontact.add(value);
      });

      List<Cloud_Log> cloud_data = [];
      listcontact.forEach((element) {
        cloud_data.add(Cloud_Log(
            number: element.number,
            name: element.name,
            fromdevice: element.name));
      });
    } catch (e) {
      print(e);
    }
    return listcontact;
  }
}
