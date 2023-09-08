import 'package:flutter_test/flutter_test.dart';

import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';

void main() async {
  test('connect', () async {
    await FirebaseServiceProvider().connect();
  });
}
