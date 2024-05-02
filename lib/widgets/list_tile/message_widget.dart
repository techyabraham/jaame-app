import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../views/dashboard/my_escrow_screens/conversation_screen/image_viewer.dart';
import '../../views/dashboard/my_escrow_screens/conversation_screen/message_model.dart';
import '../../views/dashboard/my_escrow_screens/conversation_screen/pdf_viewer.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key, required this.message, required this.imagePath});

  final MessageModel message;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        message.messageType == MessageType.own
            ? SizedBox(width: Dimensions.iconSizeDefault * 2.5)
            : _chatImage(context),
        _chatting(context),
        message.messageType == MessageType.own
            ? _chatImage(context)
            : SizedBox(width: Dimensions.iconSizeDefault * 2.5),
      ],
    );
  }

  _chatting(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: message.messageType == MessageType.own
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: message.message.isNotEmpty ||
              (message.attachments.isNotEmpty &&
                  !message.attachments.first.fileType.contains("image")),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .5,
                vertical: Dimensions.paddingSizeVertical * .5),
            margin: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .3,
                vertical: Dimensions.paddingSizeVertical * .3),
            alignment: message.messageType == MessageType.own
                ? Alignment.topRight
                : Alignment.topLeft,
            decoration: BoxDecoration(
              color: message.messageType == MessageType.own
                  ? Theme.of(context).primaryColor
                  : message.messageType == MessageType.opposite
                      ? Theme.of(context).scaffoldBackgroundColor
                      : CustomColor.orangeColor,
              borderRadius: BorderRadius.circular(Dimensions.radius * .5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: message.message.isNotEmpty,
                  child: Align(
                    alignment: message.messageType == MessageType.own
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: TitleHeading3Widget(
                      text: message.message,
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.headingTextSize3 * .85,
                      textAlign: message.messageType == MessageType.own
                          ? TextAlign.right
                          : TextAlign.left,
                      color: message.messageType == MessageType.opposite
                          ? null
                          : CustomColor.whiteColor,
                    ),
                  ),
                ),
                verticalSpace(Dimensions.paddingSizeVertical * .2),
                message.attachments.isNotEmpty
                    ? Align(
                        alignment: Alignment.center,
                        child: message.attachments.first.fileType
                                .contains("image")
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  Expanded(
                                    child: TitleHeading4Widget(
                                      text: message.attachments.first.fileName,
                                      opacity: .5,
                                      color: message.messageType == MessageType.opposite
                                          ? null
                                          : CustomColor.whiteColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      debugPrint("PDF Path");
                                      debugPrint(
                                          "${message.attachments.first.filePath}/${message.attachments.first.fileName}");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PDFViewer(
                                            pdfUrl:
                                                "${message.attachments.first.filePath}/${message.attachments.first.fileName}",
                                            pdfName: message
                                                .attachments.first.fileName,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.note_rounded,
                                      color: ( message.messageType == MessageType.opposite
                                          ? Theme.of(context).primaryColor
                                          : CustomColor.whiteColor).withOpacity(.5),
                                    ),
                                  )
                                ],
                              ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
        (message.attachments.isNotEmpty &&
                message.attachments.first.fileType.contains("image"))
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewer(
                          name: message.attachments.first.fileName,
                          imageUrl:
                              "${message.attachments.first.filePath}/${message.attachments.first.fileName}"),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                    "${message.attachments.first.filePath}/${message.attachments.first.fileName}",
                    height: 200,
                    alignment: Alignment.center,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    ));
  }

  _chatImage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSizeVertical * .3),
      child: CircleAvatar(
        radius: Dimensions.iconSizeDefault * 1.2,
        backgroundColor: message.messageType == MessageType.own
            ? Theme.of(context).primaryColor.withOpacity(.6)
            : message.messageType == MessageType.opposite
                ? CustomColor.blueColor.withOpacity(.6)
                : CustomColor.orangeColor.withOpacity(.6),
        backgroundImage: NetworkImage(imagePath),
      ),
    );
  }
}
