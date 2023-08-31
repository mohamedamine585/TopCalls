import 'package:topcalls/Backend/Consts.dart';

import '../Modules/Cloud_Contact.dart';

List<int> to_int_list(List<dynamic>? list, int? length) {
  if (length != null) {
    return List<int>.generate(length, (index) {
      return 0;
    });
  }
  return List<int>.generate(list?.length ?? 0, (index) {
    return int.parse(list?.elementAt(index));
  });
}

List<String> to_string_list(List<dynamic>? list, int? length) {
  if (length != null) {
    return List<String>.generate(length, (index) {
      return "";
    });
  }
  return List<String>.generate(list?.length ?? 0, (index) {
    return (list?.elementAt(index)).toString();
  });
}

List<bool> to_bool_list(List<dynamic>? list, int? length) {
  if (length != null) {
    return List<bool>.generate(length, (index) {
      return false;
    });
  }
  return List<bool>.generate(list?.length ?? 0, (index) {
    if (list?.elementAt(index) == "true") return true;
    return false;
  });
}

int find_index(List<Cloud_Log> list, String number) {
  for (int i = 0; i < list.length; i++) {
    if (list.elementAt(i).number == number) {
      return i;
    }
  }
  return -1;
}
