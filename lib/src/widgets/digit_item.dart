import 'package:flutter/material.dart';
import 'package:slide_countdown/src/models/base_digit.dart';
import 'package:slide_countdown/src/utils/enum.dart';
import 'package:slide_countdown/src/utils/extensions.dart';
import 'package:slide_countdown/src/widgets/raw_digit_item.dart';
import 'package:slide_countdown/src/widgets/separator.dart';

/// {@template digit_item}
/// A widget that displays a digit item with a separator.
///
/// Inherits all the properties of the [BaseDigits] class.
/// {@endtemplate}
class DigitItem extends BaseDigits {
  /// {@macro digit_item}
  const DigitItem({
    required super.duration,
    required super.timeUnit,
    required super.padding,
    required super.decoration,
    required super.style,
    required super.separatorStyle,
    required super.slideDirection,
    required super.countUp,
    required super.separator,
    required super.textDirection,
    required super.showSeparator,
    super.key,
    super.separatorPadding,
    super.digitsNumber,
  });

  @override
  Widget build(BuildContext context) {
    var digits = <Widget>[];

    if (timeUnit == TimeUnit.days && duration.inDays > 999) {
      final daysThousand = RawDigitItem(
        duration: duration,
        timeUnit: timeUnit,
        digitType: DigitType.daysThousand,
        countUp: countUp,
        style: style,
        slideDirection: slideDirection,
        digitsNumber: digitsNumber,
      );

      digits.add(daysThousand);
    }

    if (timeUnit == TimeUnit.days && duration.inDays > 99) {
      final dayHundred = RawDigitItem(
        duration: duration,
        timeUnit: timeUnit,
        digitType: DigitType.daysHundred,
        countUp: countUp,
        style: style,
        slideDirection: slideDirection,
        digitsNumber: digitsNumber,
      );

      digits.add(dayHundred);
    }

    digits.addAll(
      [
        RawDigitItem(
          duration: duration,
          timeUnit: timeUnit,
          digitType: textDirection.isRtl ? DigitType.second : DigitType.first,
          countUp: countUp,
          style: style,
          slideDirection: slideDirection,
          digitsNumber: digitsNumber,
        ),
        RawDigitItem(
          duration: duration,
          timeUnit: timeUnit,
          digitType: textDirection.isRtl ? DigitType.first : DigitType.second,
          countUp: countUp,
          style: style,
          slideDirection: slideDirection,
          digitsNumber: digitsNumber,
        ),
      ],
    );

    if (textDirection.isRtl) {
      digits = digits.reversed.toList();
    }

    final separatorWidget = showSeparator
        ? Separator(
            padding: separatorPadding,
            show: true,
            separator: separator,
            style: separatorStyle,
          )
        : const SizedBox.shrink();

    return ExcludeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: textDirection.isRtl
            ? [separatorWidget, ...digits]
            : [...digits, separatorWidget],
      ),
    );
  }
}
