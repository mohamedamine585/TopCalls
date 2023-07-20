import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:topcalls/Backend/AuthService.dart';
import 'package:topcalls/Backend/FirebaseServiceProvider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  test('testing storing data', () async {
    await FirebaseServiceProvider().connect(authService: AuthService());

    await FirebaseServiceProvider().Load_data(Email: "loxfox");
  });
}
