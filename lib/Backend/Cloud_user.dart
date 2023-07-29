class Cloud_user {
  final String Email;
  final String password;
  final int Contacts_number;
  final bool isEmailverified;
  final List<String> DevicesList;
  late final String? phonenumber;
  Cloud_user(
      {required this.Email,
      required this.password,
      required this.Contacts_number,
      required this.isEmailverified,
      required this.DevicesList});

  factory Cloud_user.newClouduser(
      {required String Email, required String password}) {
    return Cloud_user(
        Email: Email,
        password: password,
        Contacts_number: 0,
        isEmailverified: false,
        DevicesList: []);
  }
}
