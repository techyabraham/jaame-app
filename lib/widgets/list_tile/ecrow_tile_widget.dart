import 'package:intl/intl.dart';

import '../../backend/download_file.dart';
import '../../backend/models/escrow/escrow_index_model.dart';
import '../../utils/basic_widget_imports.dart';
import '../text_labels/title_heading5_widget.dart';
import 'status_widget.dart';
import 'text_descrption_form_widget.dart';
import 'text_status_form_widget.dart';
import 'text_value_form_widget.dart';

class EscrowTileWidget extends StatefulWidget with DownloadFile {
  const EscrowTileWidget(
      {super.key,
      required this.onSelected,
      required this.data,
      this.havePayment = false,
      required this.onTap,
      required this.expansion});

  final Function(String)? onSelected;
  final EscrowDatum data;
  final bool havePayment;
  final VoidCallback onTap;
  final bool expansion;

  @override
  State<EscrowTileWidget> createState() => _EscrowTileWidgetState();
}

class _EscrowTileWidgetState extends State<EscrowTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          child: Container(
            margin: EdgeInsets.only(
              left: Dimensions.paddingSizeHorizontal * .8,
              right: Dimensions.paddingSizeHorizontal * .8,
            ),
            padding: EdgeInsets.only(
              left: Dimensions.paddingSizeHorizontal * .4,
              top: Dimensions.paddingSizeVertical * .3,
              bottom: Dimensions.paddingSizeVertical * .3,
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(Dimensions.radius)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeHorizontal * .3,
                    vertical: Dimensions.paddingSizeVertical * .3,
                  ),
                  decoration: BoxDecoration(
                      color: CustomColor.whiteColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius)),
                  child: Column(
                    children: [
                      TitleHeading1Widget(
                        text: widget.data.createdAt.day.toString(),
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: Dimensions.headingTextSize3 * 1.7,
                      ),
                      TitleHeading5Widget(
                        text: DateFormat.MMMM().format(widget.data.createdAt),
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.headingTextSize6 * .85,
                      )
                    ],
                  ),
                ),
                horizontalSpace(Dimensions.marginSizeHorizontal * .3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TitleHeading2Widget(
                        text: widget.data.title,
                        fontSize: Dimensions.headingTextSize3 * .85,
                      ),
                      Row(
                        children: [
                          TitleHeading4Widget(
                            text: widget.data.amount,
                            fontSize: Dimensions.headingTextSize4 * .85,
                            color: Theme.of(context).primaryColor,
                            opacity: 1,
                          ),
                          horizontalSpace(4),
                          StatusWidget(
                            statusValue: widget.data.status,
                          )
                        ],
                      )
                    ],
                  ),
                ),

                widget.havePayment
                    ? PopupMenuButton<String>(
                        iconSize: Dimensions.iconSizeDefault * 2.2,
                        onSelected: widget.onSelected,
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem(
                              value: 'message',
                              child: TitleHeading5Widget(text: Strings.message),
                            ),
                            const PopupMenuItem(
                              value: 'pay',
                              child: TitleHeading5Widget(text: Strings.buyerPay,),
                            ),
                          ];
                        },
                      )
                    : PopupMenuButton<String>(
                        iconSize: Dimensions.iconSizeDefault * 2.2,
                        onSelected: widget.onSelected,
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem(
                              value: 'message',
                              child: TitleHeading5Widget(text: Strings.message),
                            )
                          ];
                        },
                      ),
              ],
            ),
          ),
        ),
        Visibility(
            visible: widget.expansion,
            child: Container(
              margin: EdgeInsets.only(
                left: Dimensions.paddingSizeHorizontal * .8,
                right: Dimensions.paddingSizeHorizontal * .8,
              ),
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
                    text: Strings.escrowId,
                    value: widget.data.escrowId,
                  ),
                  _divider(),
                  TextValueFormWidget(
                    text: Strings.title,
                    value: widget.data.title,
                  ),
                  _divider(),
                  TextValueFormWidget(
                    text: Strings.myRole,
                    value: widget.data.role == "seller"
                        ? Strings.seller
                        : Strings.buyer,
                  ),
                  _divider(),
                  TextValueFormWidget(
                    text: Strings.amount,
                    // value: "100.00",
                    currency: widget.data.amount,
                  ),
                  _divider(),
                  TextValueFormWidget(
                    text: Strings.category,
                    value: widget.data.category,
                  ),
                  _divider(),
                  TextValueFormWidget(
                    text: Strings.charge,
                    // value: "3.00",
                    currency: widget.data.totalCharge,
                  ),
                  _divider(),
                  TextValueFormWidget(
                    text: Strings.chargePayer,
                    value: widget.data.chargePayer,
                  ),
                  _divider(),
                  TextStatusFormWidget(
                    text: Strings.status,
                    status: widget.data.status,
                  ),
                  widget.data.attachments!.isEmpty
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            _divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: TextValueFormWidget(
                                    text: Strings.attachments,
                                    currency:
                                        "${widget.data.attachments!.first.fileName.split('.').first.substring(0, 8)}...~.${widget.data.attachments!.first.fileName.split('.').last}",
                                  ),
                                ),
                                horizontalSpace(
                                    Dimensions.paddingSizeHorizontal * .2),
                                InkWell(
                                    onTap: () async {
                                      await widget.downloadFile(
                                          url:
                                              "${widget.data.attachments!.first.filePath}/${widget.data.attachments!.first.fileName}",
                                          name: widget.data.attachments!.first
                                              .fileName);
                                      debugPrint("Download");
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: Dimensions.iconSizeDefault * 1,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.5),
                                    ))
                              ],
                            ),
                          ],
                        ),
                  Visibility(
                      visible: widget.data.remarks.isNotEmpty,
                      child: Column(
                        children: [
                          _divider(),
                          TextDescriptionFormWidget(
                            text: Strings.remarks,
                            value: widget.data.remarks,
                          ),
                        ],
                      )),
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
