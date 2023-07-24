import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:topcalls/Backend/AuthService.dart';
import 'package:topcalls/Backend/Cloud_Contact.dart';
import 'package:topcalls/Backend/FirebaseServiceProvider.dart';
import 'package:topcalls/Backend/firebase_options.dart';

void main() async {
  setUpAll(() {
    {
      WidgetsFlutterBinding.ensureInitialized();
    }
  });
  await Firebase.initializeApp();

  test('testing storing data', () async {});
}
