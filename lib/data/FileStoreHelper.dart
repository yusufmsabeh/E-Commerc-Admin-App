import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/model/Product.dart';
import 'package:e_commerce_admin/model/catergory.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FireStorHelper {
  static FireStorHelper instance = FireStorHelper._();
  FireStorHelper._();

  readAllProduct() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection('products').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = data.docs;
    return docs.map((e) {
      Product product = Product.fromMap(e.data());
      product.id = e.id;
      return product;
    }).toList();
  }

  readAllCatergories() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection('category').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = data.docs;

    return docs.map((e) {
      AppCategory category = AppCategory.fromMap(e.data());
      category.categoryID = e.id;
      return category;
    }).toList();
  }

  addProductToFirebase(Product product) async {
    print(product);
    await FirebaseFirestore.instance
        .collection('products')
        .add(product.toMap());
  }

  uplaodFile(File file) async {
    String fileName = file.path.split('/').last;
    Reference reference = FirebaseStorage.instance.ref(fileName);

    TaskSnapshot uploadTask = await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  deleteProduct(String productId) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .delete();
  }

  updateProduct(Product product) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(product.id)
        .update(product.toMap());
  }
}
