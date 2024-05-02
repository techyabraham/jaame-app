import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../../../controller/dashboard/my_wallets/add_money_controller.dart';
import '../../../../widgets/text_labels/title_sub_title_widget.dart';


class AddMoneyManualScreen extends StatelessWidget {
  AddMoneyManualScreen({super.key});

  final controller = Get.put(AddMoneyController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: PrimaryAppBar(
            title: controller.information.gatewayCurrencyName,
          ),
          body: _bottomBodyWidget(context),
        ),
      ),
    );
  }

  _bottomBodyWidget(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
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
            child: TitleSubTitleWidget(
              fromStart: true,
              title: "",
              subTitle: controller.addMoneyManualModel.data.details,
            ),
          ),
          Column(
            children: [
              verticalSpace(Dimensions.paddingSizeVertical * 0),
              _inputWidget(context),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeHorizontal * .5),
                child: Obx(() => controller.isLoading
                    ? const CustomLoadingWidget()
                    : PrimaryButton(
                  title: Strings.submit,
                  onPressed: () =>
                      controller.onManualSubmit(context),
                )),
              ),
              verticalSpace(Dimensions.paddingSizeVertical * 1.5),
            ],
          )
        ],
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
