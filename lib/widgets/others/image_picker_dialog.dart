import 'dart:io';

import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog{
  static void pickImage(BuildContext context, { required Function onPicked}){
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeHorizontal * .5,
            vertical: Dimensions.paddingSizeVertical * .5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal,
                vertical: Dimensions.paddingSizeVertical,
            ),
              child: IconButton(
                  onPressed: () async{
                    onPicked(await _pickImage(ImageSource.gallery));
                  },
                  icon: Animate(
                    effects: const [FadeEffect(), ScaleEffect()],
                    child: Icon(
                      Icons.image,
                      color: Theme.of(context).primaryColor,
                      size: Dimensions.iconSizeLarge * 2,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal,
                vertical: Dimensions.paddingSizeVertical,
            ),
              child: IconButton(
                  onPressed: ()async{
                    onPicked(await _pickImage(ImageSource.camera));
                  },
                  icon: Animate(
                    effects: const [FadeEffect(), ScaleEffect()],
                    child: Icon(
                      Icons.camera,
                      color: Theme.of(context).primaryColor,
                      size: Dimensions.iconSizeLarge * 2,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }



  static File? file;

  static Future<File?> _pickImage(imageSource) async {
    try {
      final image =
      await ImagePicker().pickImage(source: imageSource, imageQuality: 100);
      if (image == null) return null;

      file = File(image.path);
      Get.close(1);
      return file;
    } on PlatformException catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }
}