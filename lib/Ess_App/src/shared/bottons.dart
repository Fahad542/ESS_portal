import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Widget? icon;
  final Function onTap;
  final bool isEnabled;
  final bool isBusy;
  final BorderRadiusGeometry? borderRadius;

  const MainButton(
      {Key? key,
      required this.text,
      this.width,
      this.height,
      this.icon,
      required this.onTap,
      this.isEnabled = true,
      this.borderRadius,
      this.isBusy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isEnabled || (isBusy == false)) onTap();
      },
      child: Container(
        width: width ?? context.screenSize().width,
        height: height ?? 60,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          boxShadow: [
            if (isEnabled)
              BoxShadow(
                color: AppColors.primary.withOpacity(0.06),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
          ],
          gradient: LinearGradient(
            colors: [ AppColors.primary, AppColors.primary],

          ),
          color: isEnabled
              ? AppColors.primary
              : AppColors.primary.withOpacity(0.3),
        ),
        padding: const EdgeInsets.all(10),
        child: isBusy
            ? Center(
                child: CircularProgressIndicator(
                color: AppColors.white,
              ))
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyling.bold18.copyWith(color: AppColors.white),
                  ),
                  if (icon != null) SizedBox(width: 8),
                  if (icon != null) icon ?? SizedBox.shrink()
                ],
              ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Widget? icon;
  final Function onTap;
  final Color? color;

  const SecondaryButton({
    Key? key,
    required this.text,
    this.width,
    this.height,
    this.icon,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: width ?? context.screenSize().width,
        height: height ?? 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color ?? AppColors.border),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyling.bold18
                  .copyWith(color: color ?? AppColors.primary),
            ),
            if (icon != null) SizedBox(width: 8),
            if (icon != null) icon ?? SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final String icon;
  final Function onTap;

  const RoundIconButton({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x1e000000),
              blurRadius: 64,
              offset: Offset(0, 32),
            ),
          ],
        ),
        width: 48,
        height: 48,
        child: Center(
            child: Image.asset(
          icon,
          height: 24,
          width: 24,
        )),
      ),
    );
  }
}
