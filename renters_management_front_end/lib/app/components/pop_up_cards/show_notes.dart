import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/buttons.dart';
import 'package:renters_management_front_end/app/components/text_field.dart';

import '../../controllers/show_notes_controller.dart';
import '../../globals.dart';
import '../custom_text.dart';

class PopUpShowNotesCard extends GetView<ShowNotesController> {
  const PopUpShowNotesCard({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put<ShowNotesController>(ShowNotesController());
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Hero(
          tag: "PopUpShowNotesCard",
          child: Material(
            color: AppColors.mainCardColor,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(
                  color: AppColors.inverseCardColor,
                  width: 3,
                )),
            child: SizedBox(
                height: Get.height * 0.49,
                width: Get.width,
                child: SafeArea(
                    minimum: const EdgeInsets.all(12),
                    child: Form(
                      key: controller.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Obx(()=>Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // SecText("Notes",
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.sticky_note_2,color:AppColors.inverseMainTextColor,),
                              MainText("Notes",
                                  textColor: AppColors.inverseMainTextColor,),
                              IconButton(
                                  onPressed: controller.toggleEditState,
                                  icon: Icon(controller.editIcon,color: AppColors.inverseMainTextColor,))
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: CustomTextFormField(
                                controller: controller.noteController,
                                minLines: 10,
                                enable: controller.enable.value,
                                keyboardType: TextInputType.text,
                                labelText: "Notes",
                                onFieldSubmitted: (e) {
                                  // controller.addPhone();
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onPress: () {
                                  Get.back(result: controller.changed);
                                },
                                text: "Close",
                              ),
                            ],
                          ),
                        ],
                      )),
                    ))),
          ),
        ),
      ),
    );
  }
}
