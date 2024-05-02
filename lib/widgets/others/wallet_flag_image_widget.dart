
import '../../utils/basic_widget_imports.dart';
import 'custom_cached_network_image.dart';

class WalletFlagImageWidget extends StatelessWidget {
  const WalletFlagImageWidget({super.key, required this.imagePath,});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.iconSizeLarge * 4,
      width: Dimensions.iconSizeLarge * 4,
      padding: const EdgeInsets.all(3.5),
      decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          shape:  BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 3,
          )),
      child: CustomCachedNetworkImage(
          imageUrl: imagePath,
          isCircle: true,
          placeHolder: Container(
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/logo/app_launcher.jpg"),
                    fit: BoxFit.fill
                  )))),
    );
  }
}
