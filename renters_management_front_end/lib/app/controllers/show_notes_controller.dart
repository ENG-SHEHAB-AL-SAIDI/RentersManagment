import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowNotesController extends GetxController {
  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode noteFocus = FocusNode();
  RxBool enable = false.obs;
  IconData editIcon = Icons.edit;
  String oldText = "";
  String changed = "";

  void toggleEditState() async {
    if (enable.value == true) {
      enable.value = false;
      editIcon = Icons.edit;
      if (noteController.text != oldText) {
        oldText = noteController.text;
        changed = noteController.text;
      }
    } else if (enable.value == false) {
      enable.value = true;
      editIcon = Icons.edit_off;
    }
  }

  @override
  void onInit() {
    noteController.text = Get.arguments['notes'] ?? "";
    oldText = Get.arguments['notes'] ?? "";
    super.onInit();
  }

  void close(){
    Get.back(result: changed);
  }
  @override
  void onClose() {
    noteController.dispose();
    noteFocus.dispose();
  }
  // void submit() {
  //   Map<String, dynamic> jsData = {};
  //   if (formKey.currentState!.validate()) {
  //     (noteController.text.isNotEmpty && noteController.text != "Unknown".tr)
  //         ? jsData["enter_date"] = noteController.text
  //         : null;
  //     Get.back(result: jsData);
  //   }
  // }
}
