class UserSettings {
  String email;
  String password;

  UserSettings({this.email = "", this.password = ""});

  void updateEmail(String newEmail) => email = newEmail;
  void updatePassword(String newPassword) => password = newPassword;

  Future<void> save() async {
    // In a real app, save to SharedPreferences or DB
    print("Saved: Email=$email, Password=$password");
  }
}
