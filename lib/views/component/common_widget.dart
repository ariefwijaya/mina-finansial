import 'package:flutter/material.dart';
import 'package:mina_finansial/app/config/themes.dart';
import 'package:shimmer/shimmer.dart';

import 'common_button.dart';

/// Placeholder Widget shared across any screen
class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget(
      {Key? key,
      this.imagePath,
      required this.title,
      this.subtitle,
      this.onPressed,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.fullWidthButton = false,
      this.buttonText})
      : super(key: key);

  /// Optional asset Path Image. Use `AssetsUtils` to get right Asset Path
  final String? imagePath;

  /// Optional Subtitle/description placeholder
  final String? subtitle;
  final String title;

  /// Add onPressed Method will show Button
  final VoidCallback? onPressed;

  /// It can't be empty if onPress is not null
  final String? buttonText;
  final MainAxisAlignment mainAxisAlignment;
  final bool fullWidthButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (imagePath != null)
            Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                child: Image.asset(
                  imagePath!,
                  height: 200,
                )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: ThemeColors.blackNavy,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          if (subtitle != null) SizedBox(height: 8),
          if (subtitle != null)
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ThemeColors.blackNavy, fontSize: 14),
                )),
          SizedBox(height: 15),
          onPressed != null
              ? fullWidthButton
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: double.infinity,
                      child: CButtonFilled(
                          rounded: true,
                          textLabel: buttonText!,
                          onPressed: onPressed!),
                    )
                  : CButtonFilled(
                      rounded: true,
                      textLabel: buttonText!,
                      onPressed: onPressed!)
              : Container()
        ],
      ),
    );
  }
}

class CustomCardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const CustomCardWidget({Key? key, required this.child,this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      padding: padding?? EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black12.withOpacity(0.05))
          ]),
      child: child,
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  const ShimmerWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }
}

class ShimmerWidgetCircle extends StatelessWidget {
  final double size;
  const ShimmerWidgetCircle({Key? key, this.size = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.circle),
        ));
  }
}

class ShimmerWidgetText extends StatelessWidget {
  final double height;
  final double width;
  final bool rounded;
  final BorderRadiusGeometry? borderRadius;
  const ShimmerWidgetText(
      {Key? key,
      this.height = 16,
      this.width = 100,
      this.rounded = true,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: rounded && borderRadius == null
              ? BorderRadius.circular(30)
              : borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class TitlePageWidget extends StatelessWidget {
  final String title;
  const TitlePageWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}
