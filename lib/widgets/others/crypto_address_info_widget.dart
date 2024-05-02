import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/basic_screen_imports.dart';

class CryptoAddressInfoWidget extends StatelessWidget {
  const CryptoAddressInfoWidget({super.key, required this.address});
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal,
        vertical: Dimensions.paddingSizeVertical,
      ),
      child: Column(
        children: [
          QrImageView(
            data: '1234567890',
            version: QrVersions.auto,
            size: 200.0,
          ),

          verticalSpace(Dimensions.heightSize),

          PrimaryTextInputWidget(
              controller: TextEditingController(text: address),
              labelText: Strings.address,
            suffixIcon: IconButton(
              onPressed: (){
                Clipboard.setData(ClipboardData(text: address));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Copied $address'),
                    duration: const Duration(seconds: 2), // Duration for which Snackbar is visible
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.copy_all, color: CustomColor.primaryLightColor),
            ),
          ),
        ],
      ),
    );
  }
}
