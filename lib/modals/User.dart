// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  User copyWith({
    String? phoneNumber,
    name,
    birthday,
    address,
    image,
    password,
    email,
    id,
  }) {
    return User(
      email: email ?? this.email,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      image: image ?? this.image,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      id: id ?? this.id,
    );
  }
}
