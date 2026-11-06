
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
import '../../data/model/categoriesmodel.dart';


class CategoriesEditController extends GetxController{

  CategoriesData categoriesData = CategoriesData(Get.find());

  NotificationService notificationService = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  GlobalKey<FormState> formState = GlobalKey<FormState>();


  late TextEditingController name;

  late TextEditingController namear;

  CategoriesModel? categoriesModel;

  File? file ;

  chooseImage()async{
    file = await fileUploadGallery();
    update();
  }

  takeImage()async{
    file = await imageUploadCamera();
    update();
  }


  editData()async{

    if(formState.currentState!.validate()){
      statusRequest = StatusRequest.loading;

      update();

      Map data = {
        "name" : name.text ,
        "namear" : namear.text ,
        "imageold" : categoriesModel!.categoriesImage!,
        "id" : categoriesModel!.categoriesId!.toString(),
      };

      var response = await categoriesData.edit(data , file);

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
    categoriesModel = Get.arguments['categoriesModel'];
    name = TextEditingController();
    namear = TextEditingController();
    name.text = categoriesModel!.categoriesName!;
    namear.text = categoriesModel!.categoriesNameAr!;
    super.onInit();
  }

}