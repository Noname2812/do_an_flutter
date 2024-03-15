class User {
  String? phoneNumber, name, birthday, address, image, id, password, email;

  User(
      {this.email,
      this.id,
      this.password,
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
    return User();
  }
}
