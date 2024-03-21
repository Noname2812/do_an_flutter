class NotificationUser {
  String? body, title, createdAt;
  NotificationUser({this.body, this.title, this.createdAt});
  factory NotificationUser.fromMap(Map<String, dynamic> map) {
    return NotificationUser(
      createdAt: map['createdAt'],
      body: map['body'],
      title: map['title'],
    );
  }
}
