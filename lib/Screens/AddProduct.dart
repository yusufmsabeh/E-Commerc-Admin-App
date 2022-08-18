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

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

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
            SingleChildScrollView(
              child: Center(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                margin: EdgeInsets.symmetric(vertical: 15.h),
                child: Form(
                  key: provider.addProductForm,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: provider.getImage,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 238, 235, 235),
                                borderRadius: BorderRadius.circular(20)),
                            height: 300,
                            width: double.infinity,
                            child: provider.selectedImage == null
                                ? Icon(
                                    Icons.add,
                                    size: 40,
                                  )
                                : Image.file(
                                    provider.selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) =>
                                provider.emptyValidation(value),
                            controller: provider.nameProductController,
                            decoration:
                                InputDecoration(hintText: "Product Name"),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) =>
                                provider.emptyValidation(value),
                            controller: provider.descriptionProductController,
                            decoration: InputDecoration(
                                hintText: "Product description"),
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
                            controller: provider.priceProductController,
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
                            controller: provider.quantityProductController,
                            decoration:
                                InputDecoration(hintText: "Product quantity"),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(89, 86, 233, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<dynamic>(
                            dropdownColor: Color.fromRGBO(89, 86, 233, 1),
                            value: provider.seletedItem,
                            onChanged: (value) {
                              provider.changeSeleteditem(value);
                            },
                            items: provider.categories.map((e) {
                              return DropdownMenuItem(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.w),
                                  child: Text(
                                    e.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                value: e.categoryID,
                              );
                            }).toList(),
                          )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                provider.AddProductToFireBase();
                              },
                              child: Text("Add Product")),
                        ),
                      ]),
                ),
              )),
            ),
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
