import 'package:cloud_firestore/cloud_firestore.dart';

import '../functions/usefulfunctions.dart';

class Cloud_user {
  String Email;
  int? logs_number;
  int? black_listed_number;
  Timestamp? lastconnection;
  bool isEmailverified;
  List<String> DevicesList;
  List<String>? phone_numbers;
  List<String>? sim_cards;

  Cloud_user(
      {required this.Email,
      required this.isEmailverified,
      required this.DevicesList,
      this.logs_number,
      this.black_listed_number,
      this.lastconnection,
      this.sim_cards,
      this.phone_numbers});
  factory Cloud_user.from_firebase_first_time(
      {required dynamic data,
      required List<String> phonenumbers,
      required List<String> simcards}) {
    final email = data["Eamil"] as String;
    final isemailverified = data["isEmailverified"] as bool;
    final deviceslist = to_string_list(data["DeviecsList"], null);
    final lascnx = data["lastconnection"] as Timestamp?;
    final black_listed = data["blacklisted"] as int?;
    final logs_number = data["logsnumber"] as int?;
    return Cloud_user(
      Email: email,
      isEmailverified: isemailverified,
      DevicesList: deviceslist,
      lastconnection: lascnx,
      black_listed_number: black_listed,
      logs_number: logs_number,
      phone_numbers: phonenumbers,
      sim_cards: simcards,
    );
  }
  factory Cloud_user.from_firebase({required dynamic data}) {
    final email = data["Email"] as String;
    final isemailverified = data["isEmailverified"] as bool;
    final deviceslist = to_string_list(data["DevicesList"], null);

    final lascnx = data["lastconnection"] as Timestamp?;
    final black_listed = data["blacklisted"] as int?;
    final logs_number = data["logsnumber"] as int?;
    final phone_numbers = to_string_list(data["phonenumbers"], null);
    final sim_cards = to_string_list(data["sim_cards"], null);

    return Cloud_user(
        Email: email,
        isEmailverified: isemailverified,
        DevicesList: deviceslist,
        lastconnection: lascnx,
        black_listed_number: black_listed,
        logs_number: logs_number,
        sim_cards: sim_cards,
        phone_numbers: phone_numbers);
  }

  factory Cloud_user.newClouduser(
      {required String Email, required String password}) {
    return Cloud_user(Email: Email, isEmailverified: false, DevicesList: []);
  }
}
