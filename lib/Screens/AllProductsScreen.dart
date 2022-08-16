import 'package:e_commerce_admin/Providers/FireStoreProvider.dart';
import 'package:e_commerce_admin/widgets/ProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'LoadingSpinner.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Product"),
        centerTitle: true,
      ),
      body: Consumer<FireStoreProvider>(builder: (context, provider, x) {
        return Stack(
          children: [
            ListView.builder(
                itemCount: provider.products.length,
                itemBuilder: (context, index) => ProductWidget(
                      product: provider.products[index],
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
