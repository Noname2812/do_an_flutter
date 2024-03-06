class Category {
  String title, image, id;
  Category({required this.title, required this.image, required this.id});
  factory Category.fromJson(Map<String, dynamic> data) {
    return Category(image: data['image'], id: data['_id'], title: data['name']);
  }
}
