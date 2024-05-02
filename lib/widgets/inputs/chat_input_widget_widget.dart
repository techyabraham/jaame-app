import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controller/dashboard/my_escrows/conversation_controller.dart';
import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';

class ChatInputWidget extends StatelessWidget {
 final ConversationController controller;

  const ChatInputWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () async{

            if(controller.haveFile.value){
              controller.haveFile.value = false;
            }
            else {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                controller.file = File(result.files.single.path!);
                debugPrint("Picked ${controller.file!.path}");
                controller.filePath.value = controller.file!.path;
                controller.haveFile.value = true;
              }
              else {
                // User canceled the picker
              }
            }
          },
          borderRadius: BorderRadius.circular(Dimensions.radius * 10),
          child: Obx(() => CircleAvatar(
            radius: Dimensions.iconSizeDefault * 1.3,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: Animate(
              effects: const [FadeEffect(), ScaleEffect()],
              child: Transform.rotate(
                  angle: controller.haveFile.value ? 0 : .7,
                  child: Icon(controller.haveFile.value ? Icons.close : Icons.attach_file, color: Theme.of(context).primaryColor)
              ),
            ),
          )),
        ),

        horizontalSpace(Dimensions.marginSizeHorizontal * .2),

        Expanded(
          child: TextFormField(
            maxLines: 1,
            style: CustomStyle.lightHeading4TextStyle.copyWith(
                color: Theme.of(context).primaryColor
            ),
            controller: controller.sendTextController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
              ),
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              contentPadding: const EdgeInsets.only(
                  left: 16, right: 10, top: 20, bottom: 10),
              hintText: Get.find<LanguageSettingController>().getTranslation(Strings.writeHere),
              hintStyle: Get.isDarkMode
                  ? CustomStyle.darkHeading3TextStyle.copyWith(
                      color: CustomColor.primaryDarkTextColor.withOpacity(0.2),
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.headingTextSize3,
                    )
                  : CustomStyle.lightHeading3TextStyle.copyWith(
                      color: CustomColor.primaryLightTextColor.withOpacity(0.2),
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.headingTextSize3,
                    ),
            ),
          ),
        ),

        horizontalSpace(Dimensions.marginSizeHorizontal * .2),

        InkWell(
          onTap: controller.sendText,
          borderRadius: BorderRadius.circular(Dimensions.radius * 10),
          child: CircleAvatar(
            radius: Dimensions.iconSizeDefault * 1.3,
            backgroundColor: Theme.of(context).primaryColor,
            child: Transform.rotate(
                angle: Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? .5:-.7,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 4,
                    left: Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 0: 4,
                    right: Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 4: 0,
                    top: 4
                  ),
                  child: const Icon(Icons.send, color: CustomColor.whiteColor),
                )
            ),
          ),
        ),

      ],
    );
  }
}
