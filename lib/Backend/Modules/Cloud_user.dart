import 'package:cloud_firestore/cloud_firestore.dart';

import '../Services/FirebaseServiceProvider.dart';
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
    final email = data["Email"] as String;
    final isemailverified = data["isEmailverified"] as bool;
    final deviceslist = to_string_list(data["DevicesList"], null);
    final lascnx = data["lastconnection"] as Timestamp?;
    final logs_number = data["logsnumber"] as int?;
    return Cloud_user(
        Email: email,
        isEmailverified: isemailverified,
        DevicesList: deviceslist,
        lastconnection: lascnx,
        logs_number: logs_number,
        phone_numbers: phonenumbers,
        sim_cards: simcards,
        black_listed_number: 0);
  }
  factory Cloud_user.from_firebase({required Map<String, dynamic> data}) {
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

  factory Cloud_user.newClouduser({
    required String Email,
    required String password,
  }) {
    return Cloud_user(Email: Email, isEmailverified: false, DevicesList: []);
  }

  static Future<Cloud_user?> get_by_email(
      {required String email,
      required CollectionReference collectionReference}) async {
    try {
      QuerySnapshot querySnapshot = await collectionReference
          .where("Email", isEqualTo: email)
          .limit(1)
          .get();
      final mobiledata = await FirebaseServiceProvider()
          .systemmangementprovider
          .get_mobile_data();

      List<String> phonenumbers = [], simcards = [];
      mobiledata?.forEach((element) {
        phonenumbers.add(element.key);
        simcards.add(element.value);
      });

      final phone_numbers = (querySnapshot.docs.first.data()
          as Map<String, dynamic>)["phonenumbers"];
      final sim_cards = (querySnapshot.docs.first.data()
          as Map<String, dynamic>)["sim_cards"];
      if (phone_numbers == null) {
        await collectionReference
            .doc(querySnapshot.docs.first.id)
            .update({"phonenumbers": phone_numbers, "sim_cards": sim_cards});
      }
      return Cloud_user.from_firebase(
          data: querySnapshot.docs.first.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
