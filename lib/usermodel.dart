class usermodel {
  final String? id;
  final String name;
  final String email;
  final String phoneNumber;
  final String lattitude;
  final String longitude;
  final String expertise;
  final String password;

  const usermodel(
      {this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.lattitude,
      required this.longitude,
      required this.expertise,
      required this.password});

  toJason() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "lattitude": lattitude,
      "longitude": longitude,
      "expertise": expertise,
      "password": password,
    };
  }
}
