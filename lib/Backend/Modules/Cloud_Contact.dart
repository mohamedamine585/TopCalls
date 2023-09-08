import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topcalls/Backend/functions/usefulfunctions.dart';

class Cloud_Log {
  String number;
  String name;
  String fromdevice;
  bool? is_saved;
  int? total_call_duration;
  Timestamp? lastcall;
  bool? is_blacklisted;

  Cloud_Log(
      {required this.number,
      required this.name,
      required this.fromdevice,
      this.is_saved,
      this.total_call_duration,
      this.lastcall,
      this.is_blacklisted});

  static List<Cloud_Log>? gather_logs({required dynamic data}) {
    try {
      final logs = to_string_list(data["logs"], null);
      final names = to_string_list(data["names"], null);
      final fromdev = to_string_list(data["fromdevice"], null);
      final issaved = to_bool_list(data["issaved"], logs.length);
      final totaldur = to_int_list(data["totalcallduration"], logs.length);
      List<Cloud_Log> list = [];
      for (int i = 0; i < logs.length; i++) {
        list.add(Cloud_Log(
            number: logs[i],
            name: names[i],
            fromdevice: fromdev[i],
            is_saved: (issaved[i]),
            total_call_duration: totaldur[i]));
      }
      return list;
    } catch (e) {
      print(e);
    }
  }

  factory Cloud_Log.from_firebase({required dynamic data}) {
    final number = data["log"];
    final name = data["name"];
    final fromdev = data["fromdevice"];
    final total = data["totalcallduration"];
    final issaved = data["issaved"];
    final is_black = data["black_list"];

    return Cloud_Log(
        number: number,
        name: name,
        fromdevice: fromdev,
        is_saved: issaved,
        total_call_duration: total,
        is_blacklisted: is_black);
  }
}
