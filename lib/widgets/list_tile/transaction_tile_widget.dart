import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/widgets/list_tile/text_value_form_widget.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../backend/models/dashboard/home_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../controller/dashboard/btm_navs_controller/home_controller.dart';
import '../../extensions/custom_extensions.dart';
import '../text_labels/title_heading5_widget.dart';

class TransactionTileWidget extends StatefulWidget {
  const TransactionTileWidget(
      {super.key,
      this.inDashboard = true,
      this.transaction,
      required this.onTap,
      required this.expansion});

  final bool inDashboard;
  final Transaction? transaction;
  final bool expansion;
  final VoidCallback onTap;

  @override
  State<TransactionTileWidget> createState() => _TransactionTileWidgetState();
}

class _TransactionTileWidgetState extends State<TransactionTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeHorizontal * .6,
              vertical: Dimensions.paddingSizeHorizontal * .4,
            ),
            decoration: BoxDecoration(
                color: widget.inDashboard
                    ? Theme.of(context).scaffoldBackgroundColor
                    : CustomColor.whiteColor,
                borderRadius: BorderRadius.circular(Dimensions.radius)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeHorizontal * .4,
                    vertical: Dimensions.paddingSizeHorizontal * .3,
                  ),
                  decoration: BoxDecoration(
                      color: widget.inDashboard
                          ? CustomColor.whiteColor
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius)),
                  child: Column(
                    children: [
                      TitleHeading1Widget(
                        text: getDate(
                                widget.transaction!.createdAt.toString())["day"]
                            .toString(),
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: Dimensions.headingTextSize3 * 1.7,
                      ),
                      TitleHeading5Widget(
                        text: getDate(widget.transaction!.createdAt.toString())[
                                "month"]
                            .toString(),
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.headingTextSize6 * .85,
                      )
                    ],
                  ),
                ),
                horizontalSpace(Dimensions.marginSizeHorizontal * .5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TitleHeading2Widget(
                        text: widget.transaction!.transactionType,
                        fontSize: Dimensions.headingTextSize3 * .85,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleHeading5Widget(
                            text: "#${widget.transaction!.trxId}",
                            fontSize: Dimensions.headingTextSize5 * .85,
                            opacity: 1,
                          ),
                          const Spacer(),
                          TitleHeading3Widget(
                            text:
                                "${makeBalance(widget.transaction!.totalPayable)} ${widget.transaction!.transactionType == "MONEY-EXCHANGE" ? widget.transaction!.senderCurrencyCode : widget.transaction!.gatewayCurrencyCode}",
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: Dimensions.headingTextSize3 * .85,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
            visible: widget.expansion,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .5,
                vertical: Dimensions.paddingSizeVertical * .5,
              ),
              decoration: BoxDecoration(
                  color: CustomColor.whiteColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.radius * 1.5),
                    bottomRight: Radius.circular(Dimensions.radius * 1.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: CustomColor.blackColor.withOpacity(.2),
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                        blurRadius: 10)
                  ]),
              child: Column(
                children: [
                  TextValueFormWidget(
                    text: Strings.trxID,
                    value: "#${widget.transaction!.trxId}",
                  ),
                  _divider(),
                  TextValueFormWidget(
                    text: Strings.transactionType,
                    value: widget.transaction!.transactionType,
                  ),
                  _divider(),
                  widget.transaction!.transactionType == "MONEY-EXCHANGE"
                      ? TextValueFormWidget(
                          text: Strings.exchangeAmount,
                          value: makeMultiplyBalance(
                              widget.transaction!.senderRequestAmount
                                  .toString(),
                              widget.transaction!.exchangeRate.toString()),
                          currency: widget.transaction!.exchangeCurrency,
                        )
                      : TextValueFormWidget(
                          text: Strings.gatewayCurrency,
                          value: widget.transaction!.gatewayCurrency,
                        ),
                  _divider(),
                  TextValueFormWidget(
                    text: Strings.requestAmount,
                    value: makeBalance(
                        widget.transaction!.senderRequestAmount.toString()),
                    currency: widget.transaction!.senderCurrencyCode,
                  ),
                  _divider(),
                  Visibility(
                    visible:
                        widget.transaction!.transactionType == "MONEY-EXCHANGE",
                    child: Column(
                      children: [
                        TextValueFormWidget(
                          text: Strings.exchangeRate,
                          value:
                              "1 ${widget.transaction!.senderCurrencyCode} =",
                          currency:
                              "${(double.parse(widget.transaction!.exchangeRate.toString())).toStringAsFixed(2)} ${widget.transaction!.exchangeCurrency}",
                        ),
                        _divider(),
                      ],
                    ),
                  ),
                  TextValueFormWidget(
                    text: Strings.charge,
                    value: makeBalance(widget.transaction!.fee.toString()),
                    currency:
                        widget.transaction!.transactionType == "MONEY-EXCHANGE"
                            ? widget.transaction!.senderCurrencyCode
                            : widget.transaction!.gatewayCurrencyCode,
                  ),
                  _divider(),
                  TextValueFormWidget(
                    text: Strings.totalPayable,
                    value: makeBalance(widget.transaction!.totalPayable),
                    currency:
                        widget.transaction!.transactionType == "MONEY-EXCHANGE"
                            ? widget.transaction!.senderCurrencyCode
                            : widget.transaction!.gatewayCurrencyCode,
                  ),
                  _divider(),
                  TextValueFormWidget(
                      text: Strings.status,
                      currency: widget.transaction!.stringStatus),
                  Visibility(
                    visible: widget.transaction!.gatewayCurrency
                            .toLowerCase()
                            .contains("tatum") &&
                        widget.transaction!.status == 5,
                    child: Column(
                      children: [
                        _divider(),
                        Obx(() => Get.find<HomeController>().isSubmitLoading
                            ? const CustomLoadingWidget()
                            : PrimaryButton(
                                title: Strings.confirmPay,
                                onPressed: () {
                                  Get.find<HomeController>().cachedTatumProcess(
                                      id: widget.transaction!.trxId,
                                      apiUrl: ApiEndpoint.addMoneyTatumURL);
                                }))
                      ],
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  _divider() {
    return Divider(
      color: CustomColor.primaryLightTextColor.withOpacity(.1),
    );
  }
}
