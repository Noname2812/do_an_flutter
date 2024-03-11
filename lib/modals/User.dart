class User {
  String? phoneNumber, name, birthday, address, image;
  String email, id;
  User(
      {required this.email,
      required this.id,
      this.name,
      this.birthday,
      this.address,
      this.image,
      this.phoneNumber});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      birthday: json["birthday"],
      address: json["address"],
      image: json["image"],
      phoneNumber: json["phoneNumber"],
    );
  }
  factory User.init() {
    return User(email: "", id: "-1");
  }
}
