import 'dart:io';

import 'package:e_commerce_admin/Providers/FireStoreProvider.dart';
import 'package:e_commerce_admin/Routers/AppRouter.dart';
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
        return SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  controller: provider.nameProductController,
                  decoration: InputDecoration(hintText: "Product Name"),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: provider.descriptionProductController,
                  decoration: InputDecoration(hintText: "Product description"),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: provider.priceProductController,
                  decoration: InputDecoration(hintText: "Product price"),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: provider.quantityProductController,
                  decoration: InputDecoration(hintText: "Product quantity"),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<dynamic>(
                  value: provider.seletedItem,
                  onChanged: (value) {
                    provider.changeSeleteditem(value);
                  },
                  items: provider.categories.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.name),
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
          )),
        );
      }),
    );
  }
}