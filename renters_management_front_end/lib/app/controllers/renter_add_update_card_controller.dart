import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RenterAddUpdateCardController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController entryYearController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode nameFocus = FocusNode();
  FocusNode rentFocus = FocusNode();
  FocusNode activityFocus = FocusNode();
  FocusNode entryYearFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  RxString mode = "Add".obs;

  @override
  void onClose() {
    nameController.dispose();
    rentController.dispose();
    activityController.dispose();
    entryYearController.dispose();
    phoneController.dispose();
    nameFocus.dispose();
    rentFocus.dispose();
    activityFocus.dispose();
    entryYearFocus.dispose();
    phoneFocus.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    Map<String, String>? data ;
    if(Get.arguments != null){
      mode.value = Get.arguments['mode']??"Add";
      data = Get.arguments['data'];
    }

    if (data != null) {
      nameController.text = data["name"] ?? "";
      rentController.text = data["rent"] ?? "";
      activityController.text = data["activity"] ?? "";
      entryYearController.text = data["entryYear"] ?? "";
      phoneController.text = data["phone"]??"";
    }
  }

  String? validateName(String? name) {
    if (name == "" || name == null) {
      return "required name";
    } else if (GetUtils.isLengthGreaterThan(name, 50)) {
      return "name len can't be greater than 50";
    }
    return null;
  }

  String? validatePhone(String? phone) {
    if (!GetUtils.isLengthEqualTo(phone, 0)&&!GetUtils.isLengthEqualTo(phone, 9)) {
      return "Number should be 9 digits";
    }
    return null;
  }

  String? validateRent(String? rent) {
    if (rent == "" || rent == null) {
      return "required Rent";
    } else if (!GetUtils.isNum(rent)) {
      return "rent most be number";
    }
    return null;
  }

  String? validateEntryYear(String? entryYear) {
    if (entryYear == "" || entryYear == null) {
      return "required entryYear";
    } else if (!GetUtils.isNum(entryYear)) {
      return "entryYear most be Year (ex:2024)";
    }
    return null;
  }

  void submit() {
    Map<String, dynamic> jsData = {};
    rentController.text = double.parse(rentController.text).toStringAsFixed(2);
    if (formKey.currentState!.validate()) {
      (nameController.text.isNotEmpty && nameController.text != "Unknown".tr)
          ? jsData["name"] = nameController.text
          : null;
      (rentController.text.isNotEmpty && rentController.text != "Unknown".tr)
          ? jsData["rent"] = double.parse(rentController.text)
          : null;
      (activityController.text.isNotEmpty && activityController.text != "Unknown".tr)
          ? jsData["job_domain"] = activityController.text
          : null;
      (entryYearController.text.isNotEmpty && entryYearController.text != "Unknown".tr)
          ? jsData["entery_year"] = entryYearController.text
          : null;
      (phoneController.text.isNotEmpty && phoneController.text != "Unknown".tr )
          ? jsData["phones"] = [phoneController.text]
          : null;
      Get.back(result: jsData);
    }
  }

}
