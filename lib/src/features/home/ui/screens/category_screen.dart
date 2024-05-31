import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/home/data/models/package_model.dart';
import 'package:jetcare/src/features/home/ui/views/card_view.dart';
import 'package:jetcare/src/features/home/ui/views/home_view.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatefulWidget {
  final PackageModel category;

  const CategoryScreen({
    required this.category,
    super.key,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 3.h),
              child: CardView(
                title:
                    isArabic ? widget.category.nameAr : widget.category.nameEn,
                image: widget.category.image,
                height: 19.h,
                mainHeight: 25.h,
                titleFont: 14.sp,
                colorMain: AppColors.primary.withOpacity(0.8),
                colorSub: AppColors.shade.withOpacity(0.4),
                onTap: () {},
              ),
            ),
            if (widget.category.descriptionAr != "" &&
                widget.category.descriptionAr != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultText(
                    text: isArabic
                        ? widget.category.descriptionAr.toString()
                        : widget.category.descriptionEn.toString(),
                    fontSize: 12.sp,
                    maxLines: 5,
                  ),
                ],
              ),
            HomeView(
              title: translate(AppStrings.package),
              type: HomeViewType.package,
              visible: widget.category.packages!.isNotEmpty,
              packageList: widget.category.packages,
            ),
            SizedBox(
              height: 2.h,
            ),
            HomeView(
              title: translate(AppStrings.items),
              type: HomeViewType.extra,
              visible: widget.category.items!.isNotEmpty,
              itemList: widget.category.items,
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
