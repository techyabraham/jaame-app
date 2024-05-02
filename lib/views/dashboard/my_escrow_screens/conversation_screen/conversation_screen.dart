import 'dart:io';

import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/views/dashboard/my_escrow_screens/conversation_screen/message_model.dart';

import '../../../../backend/models/conversation/conversation_model.dart';
import '../../../../controller/dashboard/my_escrows/conversation_controller.dart';
import '../../../../language/language_controller.dart';
import '../../../../widgets/buttons/text_button_with_bg_widget.dart';
import '../../../../widgets/inputs/chat_input_widget_widget.dart';
import '../../../../widgets/list_tile/conversation_tile_widget.dart';
import '../../../../widgets/list_tile/message_widget.dart';
import '../../../../widgets/others/custom_loading_widget.dart';
import '../../../../widgets/others/custom_upload_file_widget.dart';

class ConversationScreen extends GetView<ConversationController> {
  ConversationScreen({super.key});

  final arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller.i = 0;
        controller.isFirst.value = false;
        controller.isStreamStart.value = false;
        return true;
      },
      child: SafeArea(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .26,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.radius * 3),
                      bottomRight: Radius.circular(Dimensions.radius * 3),
                    )),
              ),
              ResponsiveLayout(
                mobileScaffold: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: PrimaryAppBar(
                      title: controller.escrowData.title,
                      onTap: () {
                        controller.isStreamStart.value = false;
                        Get.back();
                      },
                    ),
                    body: Column(
                      children: [
                        _escrowInfoWidget(context),

                        verticalSpace(Dimensions.paddingSizeVertical),
                        _stream(context),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _escrowInfoWidget(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            verticalSpace(Dimensions.marginSizeVertical * .3),
            EscrowTileWidget(
              data: controller.escrowData,
            ),
            verticalSpace(Dimensions.marginSizeVertical * .4),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeHorizontal * .8),
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: controller.status.value == 1,
                        child: Row(
                          children: [
                            TextButtonWithBGWidget(
                              isLoading: controller.isLoading2,
                              onTap: () => controller.disputeProcess(),
                              text: Strings.disputed,
                            ),
                            controller.escrowData.role == "buyer"
                                ? TextButtonWithBGWidget(
                                    isLoading: controller.isLoading,
                                    onTap: () =>
                                        controller.releasePaymentProcess(),
                                    text: Strings.releasePayment,
                                    colorCode: 2,
                                  )
                                : TextButtonWithBGWidget(
                                    isLoading: controller.isLoading,
                                    onTap: () =>
                                        controller.requestPaymentProcess(),
                                    text: Strings.requestPayment,
                                    colorCode: 3),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TitleHeading3Widget(
                            text: Strings.myRole,
                            fontSize: Dimensions.headingTextSize3 * .8,
                            color: Theme.of(context).primaryColor,
                          ),
                          TitleHeading3Widget(
                            text: ": ",
                            fontSize: Dimensions.headingTextSize3 * .8,
                            color: Theme.of(context).primaryColor,
                          ),
                          TitleHeading4Widget(
                            text: controller.escrowData.role,
                            fontSize: Dimensions.headingTextSize4 * .8,
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _stream(BuildContext context) {
    return Expanded(
      flex: 4,
      child: StreamBuilder<ConversationModel>(
        stream: controller.getConversationStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something is wrong!"));
          }
          if (snapshot.hasData) {
            return _chattingWidget(context, snapshot);
          }
          return const Align(
              alignment: Alignment.center, child: CustomLoadingWidget());
        },
      ),
    );
  }

  _chattingWidget(
      BuildContext context, AsyncSnapshot<ConversationModel> snapshot) {
    var data = snapshot.data!.data.escrowConversations;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * .85,
        vertical: Dimensions.paddingSizeHorizontal * .85,
      ),
      decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.radius * 3),
            topLeft: Radius.circular(Dimensions.radius * 3),
          )),
      child: Column(
        children: [
          Expanded(
              child: ListView(
            controller: controller.scrollController,
            reverse: false,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: List.generate(
                data.length,
                (index) => MessageWidget(
                      message: MessageModel(
                          attachments: data[index].attachments,
                          message: data[index].message,
                          messageType: data[index].messageSender == "own"
                              ? MessageType.own
                              : data[index].messageSender == "admin"
                                  ? MessageType.admin
                                  : MessageType.opposite),
                      imagePath: data[index].profileImg,
                    )),
          )),
          verticalSpace(Dimensions.marginSizeVertical * .2),
          Obx(() => Visibility(
              visible: controller.haveFile.value,
              child: Align(
                alignment: Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Alignment.centerRight: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: isImage(File(controller.filePath.value))
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            File(controller.filePath.value),
                            fit: BoxFit.fill,
                            width: 60,
                            alignment: Alignment.centerLeft,
                            height: 100,
                          ),
                        )
                      : Text(
                          getFileNameFromPath(
                            File(controller.filePath.value),
                          ),
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ))),
          ChatInputWidget(
            controller: controller,
          )
        ],
      ),
    );
  }
}
