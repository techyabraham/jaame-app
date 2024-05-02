import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../../controller/auth/kyc_form_controller.dart';
import '../../../widgets/others/app_icon_widget.dart';
import '../../../widgets/text_labels/title_sub_title_widget.dart';

class KYCFormScreen extends StatelessWidget {
  KYCFormScreen({super.key});

  final controller = Get.put(KYCFormController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const PrimaryAppBar(
            title: Strings.kycForm,
          ),
          body: Obx(() => controller.isLoading
              ? const CustomLoadingWidget()
              : Column(
                  children: [
                    const AppIconWidget(),
                    _bottomBodyWidget(context),
                  ],
                )),
        ),
      ),
    );
  }

  _bottomBodyWidget(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: CustomColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 3),
              topRight: Radius.circular(Dimensions.radius * 3),
            )),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const TitleSubTitleWidget(
                title: Strings.kycFormTitle,
                subTitle: Strings.kycFormSubTitle,
              ),
            ),
            (controller.kycModel.data.kycStatus == 0 ||
                    controller.kycModel.data.kycStatus == 3)
                ? Column(
                    children: [
                      verticalSpace(Dimensions.paddingSizeVertical * 1),
                      _inputWidget(context),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeHorizontal * .5),
                        child: Obx(() => controller.isSubmitLoading
                            ? const CustomLoadingWidget()
                            : PrimaryButton(
                                title: Strings.submit,
                                onPressed: () =>
                                    controller.onSubmitProcess(context),
                              )),
                      ),
                      verticalSpace(Dimensions.paddingSizeVertical * 1.5),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeHorizontal * .7,
                      vertical: Dimensions.paddingSizeVertical * .7,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeHorizontal * .7,
                      vertical: Dimensions.paddingSizeVertical * .7,
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius * 1.5)),
                    child: TitleHeading1Widget(
                      text: controller.kycModel.data.kycStatus == 1
                          ? Strings.verified
                          : Strings.pending,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * .7,
        vertical: Dimensions.paddingSizeVertical * .7,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * .7,
        vertical: Dimensions.paddingSizeVertical * .7,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ...controller.inputFields.map((element) {
              return element;
            }),
            verticalSpace(Dimensions.marginBetweenInputBox),
            Visibility(
              visible: controller.inputFileFields.isNotEmpty,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: .99,
                  ),
                  itemCount: controller.inputFileFields.length,
                  itemBuilder: (BuildContext context, int index) {
                    return controller.inputFileFields[index];
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
