import 'dart:io';

import 'package:e_commerce_admin/Providers/FireStoreProvider.dart';
import 'package:e_commerce_admin/Routers/AppRouter.dart';
import 'package:e_commerce_admin/Screens/LoadingSpinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/Product.dart';

class EditProduct extends StatelessWidget {
  Product product;
  EditProduct({Key? key, required this.product}) : super(key: key);

  getImage2() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    Provider.of<FireStoreProvider>(AppRouter.navKey.currentContext!)
        .selectedImage = File(file!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
      ),
      body: Consumer<FireStoreProvider>(builder: (context, provider, x) {
        return Stack(
          children: [
            Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: provider.addProductForm,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          validator: (value) => provider.emptyValidation(value),
                          controller: provider.nameProductControllerEdit,
                          decoration: InputDecoration(hintText: "Product Name"),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          validator: (value) => provider.emptyValidation(value),
                          controller: provider.descriptionProductControllerEdit,
                          decoration:
                              InputDecoration(hintText: "Product description"),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          validator: (value) =>
                              provider.priceAndQuantityValidation(value),
                          keyboardType: TextInputType.number,
                          controller: provider.priceProductControllerEdit,
                          decoration:
                              InputDecoration(hintText: "Product price"),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          validator: (value) =>
                              provider.priceAndQuantityValidation(value),
                          keyboardType: TextInputType.number,
                          controller: provider.quantityProductControllerEdit,
                          decoration:
                              InputDecoration(hintText: "Product quantity"),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              provider.updateProduct(product);
                            },
                            child: Text("Edit Product")),
                      ),
                    ]),
              ),
            )),
            !provider.loading
                ? Center(child: LoadingSpinner())
                : SizedBox(
                    height: 0,
                    width: 0,
                  ),
          ],
        );
      }),
    );
  }
}
