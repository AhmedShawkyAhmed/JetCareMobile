import 'package:flutter/material.dart';
import 'package:jetcare/src/constants/end_points.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';

class CardViewweb extends StatefulWidget {
  CardViewweb(
      {this.width,
      this.height,
      required this.image,
      this.title,
      this.content,
      this.colorMain,
      this.colorSub,
      this.contentFont,
      this.textColor,
      this.titleFont,
      Key? key})
      : super(key: key);
  double? width, height;
  double? titleFont, contentFont;
  Color? colorMain, colorSub, textColor;
  String? image, title, content;

  @override
  State<CardViewweb> createState() => _CardViewwebState();
}

class _CardViewwebState extends State<CardViewweb> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 350,
      height: widget.height ?? 250,
      child: Stack(
        children: [
          Container(
            width: 350,
            height: 250,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(
                    EndPoints.imageDomain +widget.image!,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            width: 350,
            height: 250,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.centerLeft,
                    colors: [
                      widget.colorSub ?? AppColors.shade.withOpacity(0.1),
                      widget.colorMain ?? AppColors.pc.withOpacity(0.1),
                    ],),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 18,right: 3,bottom: 5),
            child: Text.rich(
              TextSpan(
                style: TextStyle(color: widget.textColor ?? AppColors.white),
                children: [
                  TextSpan(
                    text: widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.titleFont ?? 16,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  TextSpan(
                    text: widget.content,
                    style: TextStyle(
                      fontSize: widget.contentFont ?? 16,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
