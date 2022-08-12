class Product {
  String? id;
  late String name;
  late String descraption;
  late String imagePath;
  late String categoryId;
  late int quantity;
  late int price;
  Product(
      {required this.name,
      required this.descraption,
      required this.imagePath,
      required this.categoryId,
      required this.quantity,
      required this.price});

  Product.fromMap(Map<String, dynamic> json) {
    this.name = json['name'];
    this.descraption = json['description'];
    this.price = json['price'];
    this.quantity = json['quantity'];
    this.categoryId = json['categoryId'];
    this.imagePath = json['imagePath'] ?? 'assets/products/p1.jpg';
  }

  toMap() => {
        'name': this.name,
        'description': this.descraption,
        'price': this.price,
        'quantity': this.quantity,
        'imagePath': this.imagePath,
        'categoryId': this.categoryId
      };

  @override
  String toString() {
    // TODO: implement toString
    return "$name ==== $descraption ====== $imagePath ======== $price ======= $quantity ======== $categoryId";
  }
}
