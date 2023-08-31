import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:topcalls/Backend/Modules/Cloud_user.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';

class AccountMangementService {
  Cloud_user? user;
  CollectionReference userscollection, devicescollection;
  static final AccountMangementService _instance = AccountMangementService._(
      FirebaseServiceProvider().userscollection,
      FirebaseServiceProvider().devicescollection);
  AccountMangementService._(this.userscollection, this.devicescollection);
  factory AccountMangementService() => _instance;
  /* Future<void> change_password(
      {required String oldpassword, required String newpassword}) async {
    try {
      if (user?.password == oldpassword) {
        QuerySnapshot querySnapshot = await userscollection
            .where("password", isEqualTo: oldpassword)
            .where("Email", isEqualTo: user?.Email)
            .get();
        await userscollection
            .doc(querySnapshot.docs.single.id)
            .update({"password": newpassword});
      }
    } catch (e) {
      print(e);
    }
  }
*/
  Future<void> verify_email() async {}

  Future<void> delete_account() async {
    try {
      DocumentSnapshot userdoc =
          (await userscollection.where("Email", isEqualTo: user?.Email).get())
              .docs
              .first;
      if (userdoc.exists) {
        await userscollection.doc(userdoc.id).delete();
      }
    } catch (e) {
      print(e);
    }
  }
/*
  Future<List<String>> who_have_my_number() async {
    List<String> who_have_ur_number = [];
    try {
      if (user?.phonenumber != null) {
        QuerySnapshot queryusers = await userscollection.get();

        List<String> his_logs = [];
        queryusers.docs.forEach((User) async {
          his_logs = await FirebaseServiceProvider()
              .devicesMangementService
              .Load_data(Email: (User.data() as dynamic)["Email"]);
          if (his_logs.contains(user?.phonenumber)) {
            who_have_ur_number.add((User.data() as dynamic)["Email"]);
          }
        });
      } else {
        Exception("No phonesnumber");
      }
    } catch (e) {
      print(e);
    }
    return who_have_ur_number;
  }*/
}
