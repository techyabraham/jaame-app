import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../utils/basic_screen_imports.dart';

abstract class DropdownModel {
  String get id;
  String get title;
  String get img;
  String get mcode;
  String get type;
  String get currencyCode;
  String get currencySymbol;
  double get max;
  double get min;
  double get pCharge;
  double get fCharge;
  double get rate;
}

class CustomDropDown<T extends DropdownModel> extends StatefulWidget {
  final String hint;
  final String title;
  final String customTitle;
  final Color? borderColor;
  final List<T> items;
  final void Function(T?) onChanged;
  final BoxBorder? border;
  final double? fieldBorderRadius;
  final Color? dropDownIconColor;
  final Color? titleTextColor;
  final Color dropDownFieldColor;
  final Color? dropDownColor;
  final bool isExpanded;
  final bool borderEnable;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? titleStyle;
  final BorderRadiusGeometry? customBorderRadius;
  final bool? isCurrencyDropDown;

  const CustomDropDown({
    super.key,
    required this.items,
    required this.onChanged,
    this.border,
    this.fieldBorderRadius,
    this.dropDownIconColor,
    this.titleTextColor,
    this.dropDownFieldColor = Colors.transparent,
    this.isExpanded = true,
    this.padding,
    this.margin,
    this.titleStyle,
    this.borderColor,
    this.dropDownColor,
    required this.hint,
    this.borderEnable = true,
    this.title = '',
    this.customBorderRadius,
    this.isCurrencyDropDown = false, this.customTitle = "",
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T extends DropdownModel>
    extends State<CustomDropDown<T>> {
  T? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return widget.title != ''
        ? Visibility(
        visible: widget.title != '',
        child: Column(
          crossAxisAlignment: crossStart,
          mainAxisSize: mainMin,
          children: [
            TitleHeading4Widget(
              text: widget.title,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.headingTextSize3,
            ).paddingOnly(bottom: Dimensions.marginBetweenInputTitleAndBox),
            _dropDown()
          ],
        ))
        : _dropDown();
  }

  _dropDown() {
    return Container(
      height: Dimensions.inputBoxHeight * 0.69,
      // margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.dropDownFieldColor,
        border: widget.borderEnable
            ? widget.border ??
            Border.all(
              color: widget.borderColor ??
                  (_selectedItem != null
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.15)),
              width: 1.5,
            )
            : null,
        borderRadius: widget.customBorderRadius ??
            BorderRadius.circular(
              widget.fieldBorderRadius ?? Dimensions.radius * 0.5,
            ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          hint: Text(
            widget.hint,
            style: CustomStyle.darkHeading3TextStyle.copyWith(
              fontSize: Dimensions.headingTextSize3,
              fontWeight: FontWeight.w500,
              color: widget.isCurrencyDropDown!
                  ? CustomColor.whiteColor
                  : CustomColor.primaryLightColor,
            ),
          ),
          value: _selectedItem,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: Dimensions.headingTextSize3,
            fontWeight: FontWeight.w500,
          ),
          iconStyleData: IconStyleData(
            icon: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(
                Icons.arrow_drop_down_rounded,
                color: widget.dropDownIconColor ??
                    (_selectedItem != null
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor),
              ),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: MediaQuery.sizeOf(context).height * .25,
            decoration: BoxDecoration(
              color: widget.dropDownColor ?? CustomColor.whiteColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
          ),
          isExpanded: widget.isExpanded,
          underline: Container(),
          onChanged: (T? newValue) {
            setState(() {
              _selectedItem = newValue;
              widget.onChanged(_selectedItem);
            });
          },
          items: widget.items.map<DropdownMenuItem<T>>(
                (T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  // value.title,
                  value.title == "" ? widget.customTitle: value.title,
                  style: CustomStyle.darkHeading3TextStyle.copyWith(
                    fontSize: Dimensions.headingTextSize3,
                    fontWeight: FontWeight.w500,
                    color: widget.isCurrencyDropDown!
                        ? CustomColor.whiteColor
                        : CustomColor.primaryLightColor,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}