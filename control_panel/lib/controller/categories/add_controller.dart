
import 'dart:io';

import 'package:control_panel/controller/categories/view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/functions/uploadfile.dart';
import '../../core/services/NotificationService.dart';
import '../../data/datasource/remote/categories_data.dart';


class CategoriesADDController extends GetxController{

  CategoriesData categoriesData = CategoriesData(Get.find());

  NotificationService notificationService = Get.find();

   StatusRequest statusRequest = StatusRequest.none;

  GlobalKey<FormState> formState = GlobalKey<FormState>();


  late TextEditingController name;

  late TextEditingController namear;

  File? file ;

  chooseImage()async{
    file = await fileUploadGallery();
    update();
  }

  takeImage()async{
    file = await imageUploadCamera();
    update();
  }


  addData()async{

    if(formState.currentState!.validate()){
      if(file==null) {
        notificationService.showErrorNotification(title: "warning", message: "Please Choose Image First");
      }

      statusRequest = StatusRequest.loading;

      update();

      Map data = {
        "name" : name.text ,
        "namear" : namear.text ,
      };

      var response = await categoriesData.add(data , file!);

      print("========================================Controller  $response");
      statusRequest = handlingData(response);
      if(StatusRequest.success==statusRequest){
        if(response['status']=="success"){
          Get.offNamed(AppRoute.categoriesview);
          CategoriesController c =Get.find();
          c.getData();
        }
        else{
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }



  @override
  void onInit() {
    name = TextEditingController();
    namear = TextEditingController();
    super.onInit();
  }

}