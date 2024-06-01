import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/views/loading_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/support/cubit/support_cubit.dart';
import 'package:sizer/sizer.dart';

class InfoScreen extends StatefulWidget {
  final InfoType type;

  const InfoScreen({
    required this.type,
    super.key,
  });

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late SupportCubit cubit = BlocProvider.of(context);

  @override
  void initState() {
    if (widget.type == InfoType.terms) {
      cubit.getTerms();
    } else {
      cubit.getAbout();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: BlocBuilder<SupportCubit, SupportState>(
          builder: (context, state) {
            if (state is GetInfoLoading) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return LoadingView(
                    height: 15.h,
                  );
                },
              );
            }
            return Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                DefaultText(
                  text: isArabic
                      ? widget.type == InfoType.terms
                      ? cubit.terms?.titleAr ?? "الشروط والأحكام"
                      : cubit.about?.titleAr ?? "من نحن"
                      : widget.type == InfoType.terms
                      ? cubit.terms?.titleEn ?? "Terms & Conditions"
                      : cubit.about?.titleEn ?? "About Us",
                  fontSize: 20.sp,
                ),
                Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 5.w,
                          vertical: 2.h),
                      children: [
                        DefaultText(
                          text: isArabic
                              ? widget.type == InfoType.terms
                              ? cubit.terms?.contentAr ?? ""
                              : cubit.about?.contentAr ?? ""
                              : widget.type == InfoType.terms
                              ? cubit.terms?.contentEn ?? ""
                              : cubit.about?.contentEn ?? "",
                          fontSize: 16.sp,
                          maxLines: 300,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
