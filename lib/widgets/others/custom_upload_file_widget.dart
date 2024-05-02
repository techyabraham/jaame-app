import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

import '../../utils/basic_widget_imports.dart';

class CustomUploadFileWidget extends StatefulWidget {
  const CustomUploadFileWidget({
    super.key,
    required this.labelText,
    required this.onTap,
    this.hint = "",
    this.optional = "",
  });

  final String labelText, optional, hint;
  final Function onTap;

  @override
  State<CustomUploadFileWidget> createState() => _CustomUploadFileWidgetState();
}

class _CustomUploadFileWidgetState extends State<CustomUploadFileWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleHeading4Widget(
              text: widget.labelText.tr,
              fontWeight: FontWeight.w600,
            ),
            horizontalSpace(Dimensions.widthSize * 0.5),
            Visibility(
              visible: widget.optional.isNotEmpty,
              child: TitleHeading4Widget(
                text: widget.optional.tr,
                opacity: .4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox * 1),
        InkWell(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              setState(() {
                file = File(result.files.single.path!);
                debugPrint("Picked ${file!.path}");
                // file.
                widget.onTap(file);
              });
            } else {
              // User canceled the picker
            }
          },
          child: Container(
            width: double.infinity,
            height: Dimensions.buttonHeight * 1.5,
            alignment: Alignment.center,
            decoration: DottedDecoration(
              shape: Shape.box,
              dash: const [3, 3],
              color: Theme.of(context).primaryColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(Dimensions.radius * .5),
            ),
            child: file == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Animate(
                        effects: const [FadeEffect(), ScaleEffect()],
                        child: Icon(
                          Icons.backup_outlined,
                          size: 30,
                          color:
                              CustomColor.primaryLightTextColor.withOpacity(.2),
                        ),
                      ),
                      verticalSpace(3),
                      TitleHeading3Widget(
                        text: Strings.upload,
                        color:
                            CustomColor.primaryLightTextColor.withOpacity(.2),
                      ),
                    ],
                  )
                : isImage(file!)
                    ? Image.file(
                        file!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(getFileNameFromPath(file!),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                      ),
          ),
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox * .7),
        Visibility(
          visible: widget.hint.isNotEmpty,
          child: TitleHeading4Widget(
            text: widget.hint.tr,
            opacity: .4,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.headingTextSize4 * .8,
          ),
        )
      ],
    );
  }
}

// Function to check if the file is an image
bool isImage(File file) {
  String? mimeType = lookupMimeType(file.path);

  if (mimeType != null && mimeType.split('/').first == 'image') {
    return true;
  }
  return false;
}

String getFileNameFromPath(File file) {
  String fileName = p.basename(file.path);
  return fileName;
}
