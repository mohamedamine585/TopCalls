import 'package:topcalls/Backend/Modules/Cloud_Contact.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:call_log/call_log.dart';
import 'package:topcalls/Backend/functions/usefulfunctions.dart';

class LogsService {
  Future<List<Cloud_Log>> fetch_top_contact() async {
    List<Cloud_Log> listcontact = [];
    try {
      Iterable<CallLogEntry> entries = await CallLog.get();
      entries = await CallLog.query();

      entries.forEach((element) {
        final index = find_index(listcontact, element.number ?? "");
        if (index == -1) {
          listcontact.add(Cloud_Log(
              number: element.number ?? "",
              name: element.name ?? "",
              fromdevice: DEVICE_ID ?? "",
              is_saved: false,
              total_call_duration: element.duration));
        } else {
          listcontact[index].total_call_duration =
              listcontact[index].total_call_duration! + (element.duration ?? 0);
        }
      });
    } catch (e) {
      print(e);
    }
    return listcontact;
  }
}
