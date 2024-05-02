import 'dart:io';

import 'package:flutter_animate/flutter_animate.dart';

import '../../controller/dashboard/profiles/update_profile_controller.dart';
import '../../utils/basic_widget_imports.dart';
import 'custom_cached_network_image.dart';
import 'image_picker_dialog.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({super.key, this.isCircle = false, this.onTap});

  final bool isCircle;
  final Function? onTap;

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        FadeEffect(),
        ScaleEffect(),
      ],
      child: Container(
        height: Dimensions.iconSizeLarge *
            (widget.isCircle
                ? 3.5
                : widget.onTap == null
                    ? 4.4
                    : 5),
        width: Dimensions.iconSizeLarge *
            (widget.isCircle
                ? 3.5
                : widget.onTap == null
                    ? 4.4
                    : 5),
        padding: EdgeInsets.all(widget.isCircle ? 3.5 : 0),
        decoration: BoxDecoration(
            color: CustomColor.whiteColor,
            shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: widget.isCircle
                ? null
                : BorderRadius.circular(Dimensions.radius * 1.5),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: widget.isCircle ? 3 : 4,
            )),
        child: Stack(
          children: [
            file == null
                ? CustomCachedNetworkImage(
                    imageUrl: Get.find<UpdateProfileController>().profileModel.data.user.userImage,
                    isCircle: widget.isCircle,
                    placeHolder: Container()
            )
                : Container(
                    decoration: BoxDecoration(
                        color: CustomColor.primaryBGLightColor.withOpacity(.3),
                        shape: widget.isCircle
                            ? BoxShape.circle
                            : BoxShape.rectangle,
                        borderRadius: widget.isCircle
                            ? null
                            : BorderRadius.circular(Dimensions.radius * 1.5),
                        image: DecorationImage(image: FileImage(file!), fit: BoxFit.fill))),
            Visibility(
                visible: widget.onTap != null,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: CustomColor.primaryBGLightColor.withOpacity(.3),
                    borderRadius: widget.isCircle
                        ? null
                        : BorderRadius.circular(Dimensions.radius * 1),
                  ),
                  child: IconButton(
                      onPressed: () {
                        ImagePickerDialog.pickImage(context,
                            onPicked: (File value) {
                          file = value;
                          setState(() {
                            widget.onTap!(value);
                          });
                        });
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: CustomColor.whiteColor,
                        size: Dimensions.iconSizeDefault,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
