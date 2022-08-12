import 'package:e_commerce_admin/Routers/AppRouter.dart';
import 'package:e_commerce_admin/Screens/AddProduct.dart';
import 'package:e_commerce_admin/Screens/AllProductsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin App'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                    onPressed: () {
                      AppRouter.pushWidget(AddProduct());
                    },
                    child: const Text("Add Product"))),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                    onPressed: () {
                      AppRouter.pushWidget(AllProductsScreen());
                    },
                    child: const Text("Edit & Delete Product"))),
          ]),
        ),
      ),
    );
  }
}
