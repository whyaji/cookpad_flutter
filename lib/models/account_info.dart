class AccountInfo {
  final String name;
  final String email;
  final String phoneNumber;
  int pulsa;

  AccountInfo(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.pulsa});

  String getName() {
    return name;
  }

  String getEmail() {
    return email;
  }

  String getPhoneNumber() {
    return phoneNumber;
  }

  int getPulsa() {
    return pulsa;
  }

  void setPulsa(int pulsa) {
    this.pulsa = pulsa;
  }

  void addPulsa(int pulsa) {
    this.pulsa += pulsa;
  }
}
