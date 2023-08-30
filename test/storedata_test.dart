import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';

void main() async {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });
  test('connect', () async {
    await FirebaseServiceProvider().connect();
  });
}
