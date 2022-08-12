import 'dart:io';

import 'package:e_commerce_admin/Screens/AddProduct.dart';
import 'package:e_commerce_admin/data/FileStoreHelper.dart';
import 'package:e_commerce_admin/model/Product.dart';
import 'package:e_commerce_admin/model/catergory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class FireStoreProvider extends ChangeNotifier {
  List<Product> products = [];
  List<AppCategory> categories = [];
  File? selectedImage;
  String? seletedItem;

  TextEditingController nameProductController = TextEditingController();
  TextEditingController descriptionProductController = TextEditingController();
  TextEditingController priceProductController = TextEditingController();
  TextEditingController quantityProductController = TextEditingController();
  TextEditingController categoryProductController = TextEditingController();

  TextEditingController nameProductControllerEdit = TextEditingController();
  TextEditingController descriptionProductControllerEdit =
      TextEditingController();
  TextEditingController priceProductControllerEdit = TextEditingController();
  TextEditingController quantityProductControllerEdit = TextEditingController();
  TextEditingController categoryProductControllerEdit = TextEditingController();

  File? selectedFile;

  FireStoreProvider() {
    fillData();
  }

  readAllProducts() async {
    products = await FireStorHelper.instance.readAllProduct();
    notifyListeners();
  }

  readAllCategories() async {
    categories = await FireStorHelper.instance.readAllCatergories();
    notifyListeners();
  }

  getImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(file!.path);
    notifyListeners();
  }

  changeSeleteditem(var value) {
    seletedItem = value;
    notifyListeners();
  }

  upLoadFile(File file) async {
    return await FireStorHelper.instance.uplaodFile(file);
  }

  AddProductToFireBase() async {
    Product product = Product(
        name: nameProductController.text,
        descraption: descriptionProductController.text,
        imagePath: await upLoadFile(selectedImage!),
        categoryId: seletedItem!,
        quantity: int.parse(quantityProductController.text),
        price: int.parse(priceProductController.text));

    await FireStorHelper.instance.addProductToFirebase(product);
    fillData();
  }

  deleteProduct(String productId) async {
    await FireStorHelper.instance.deleteProduct(productId);
    fillData();
  }

  updateProduct(Product product) async {
    product.name = nameProductControllerEdit.text;
    product.descraption = descriptionProductControllerEdit.text;
    product.price = int.parse(priceProductControllerEdit.text);
    product.quantity = int.parse(quantityProductControllerEdit.text);

    await FireStorHelper.instance.updateProduct(product);
    fillData();
  }

  fillEditcontrollers(Product product) {
    nameProductControllerEdit.text = product.name;
    descriptionProductControllerEdit.text = product.descraption;
    priceProductControllerEdit.text = product.price.toString();
    quantityProductControllerEdit.text = product.quantity.toString();
  }

  fillData() async {
    await readAllProducts();
    await readAllCategories();
  }
}
