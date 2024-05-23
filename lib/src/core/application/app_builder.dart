import 'package:flutter/material.dart';
import 'package:jetcare/src/core/application/test_widget.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/utils/enums.dart';

Widget defaultAppBuilder(BuildContext context, Widget? child) {
  return SafeArea(
    top: false,
    child: Column(
      children: [
        Expanded(child: child ?? const SizedBox()),
        if(EndPoints.environment != Environment.production)
        const TestWidget(),
      ],
    ),
  );
}
