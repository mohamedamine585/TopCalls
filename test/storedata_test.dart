import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:topcalls/Backend/AuthService.dart';
import 'package:topcalls/Backend/FirebaseServiceProvider.dart';
import 'package:topcalls/Backend/firebase_options.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await FirebaseServiceProvider().connect(authService: AuthService());
  });
  test('testing storing data', () async {
    List<String> logs =
        await FirebaseServiceProvider().Load_data(Email: "loxfox");
    print(logs);
  });
}
