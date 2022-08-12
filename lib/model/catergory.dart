class AppCategory {
  late String categoryID;
  late String name;

  AppCategory({required this.name});

  AppCategory.fromMap(Map json) {
    this.name = json['name'];
  }
  @override
  String toString() {
    // TODO: implement toString
    return "$categoryID--- $name";
  }
}
