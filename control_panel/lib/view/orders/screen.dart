

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../controller/orders/screen_controller.dart';
import '../../core/constant/color.dart';
import '../widget/orders/custombottomappbarhome.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderScreenControllerImp());
    return GetBuilder<OrderScreenControllerImp>(
      builder: (controller)=>
          Scaffold(
            appBar: AppBar(
              title: Text("Orders"),
              backgroundColor: AppColor.primaryColor,
            ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomAppBarHome(),
        body:  controller.listPage.elementAt(controller.currentPage),

      ),
    );
  }
}
