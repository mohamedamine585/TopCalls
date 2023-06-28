class Cloud_user {
  final String Email;
  final String password;
  final int Contact_number;
  final bool isEmailverified;

  Cloud_user(
      {required this.Email,
      required this.password,
      required this.Contact_number,
      required this.isEmailverified});

  factory Cloud_user.newClouduser(
      {required String Email, required String password}) {
    return Cloud_user(
        Email: Email,
        password: password,
        Contact_number: 0,
        isEmailverified: false);
  }
}
