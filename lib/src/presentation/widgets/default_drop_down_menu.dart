import 'package:flutter/material.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:sizer/sizer.dart';

class DefaultDropDownMenu extends StatefulWidget {
  dynamic value;
  String? hint;
  List<dynamic>? list;
  double? height;
  Color? color;
  Color? borderColor;
  double? paddingHorizontal;
  double? paddingVertical;
  VoidCallback onChanged;

  DefaultDropDownMenu({
    this.list,
    this.value,
    this.borderColor,
    this.height,
    this.color,
    this.hint,
    this.paddingVertical,
    this.paddingHorizontal,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<DefaultDropDownMenu> createState() => _DefaultDropDownMenuState();
}

class _DefaultDropDownMenuState extends State<DefaultDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.paddingHorizontal ?? 15.w,
        vertical: widget.paddingVertical ?? 1.h,
      ),
      child: Container(
        height: widget.height ?? 8.h,
        decoration: BoxDecoration(
          color: widget.color ?? AppColors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: widget.borderColor ?? AppColors.pc,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 5,
          ),
          child: DropdownButton<dynamic>(
            borderRadius: BorderRadius.circular(15),
            value: widget.value,
            underline: const SizedBox(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: 36,
            ),
            hint: Text(
              widget.hint!,
            ),
            isExpanded: true,
            elevation: 1,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            onChanged: (value) {
              setState(() {
                widget.value = value;
                dropDownValue = value;
                widget.onChanged();
              });
            },
            items: widget.list!.map<DropdownMenuItem<dynamic>>((value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(
                  CacheHelper.getDataFromSharedPreference(
                              key: SharedPreferenceKeys.language) ==
                          "ar"
                      ? value.nameAr
                      : value.nameEn,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
