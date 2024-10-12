import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

/// {@template raw_slide_countdown_builder}
/// Signature for a function that builds a widget for a raw slide countdown.
///
/// The [context] parameter is the [BuildContext] for the widget being built.
///
/// The [duration] parameter is the remaining duration for the countdown.
///
/// The function should return a [Widget] that represents the current state of
/// the countdown.
///
/// This typedef is typically used in conjunction with raw slide countdown
/// widgets to customize the appearance and behavior of the countdown display.
/// {@endtemplate}
typedef RawSlideCountdownBuilder = Widget Function(
  BuildContext context,
  Duration duration,
);

/// {@template raw_slide_countdown}
/// A widget that displays a countdown based on a [StreamDuration].
///
/// The [RawSlideCountdown] widget listens to the streamDuration.durationLeft
/// stream and updates its display based on the received duration values.
///
/// The [builder] function is used to build the widget based on the current
/// [BuildContext] and the remaining [Duration] received from the stream.
///
/// Example:
///
/// ```dart
/// RawSlideCountdown(
///   streamDuration: myStreamDuration,
///   builder: (BuildContext context, Duration remainingDuration) {
///     return RawDigitItem(
///         duration: remainingDuration,
///         timeUnit: TimeUnit.seconds,
///         digitType: DigitType.second,
///         countUp: myStreamDuration.isCountUp,
///     );
///   },
/// )
/// ```
///
/// In the above example, the `RawSlideCountdown` widget listens to the
/// `myStreamDuration.durationLeft` stream and updates the displayed text
/// based on the remaining duration.
///
/// See also:
///
/// - [StreamDuration], which represents a stream of countdown durations.
/// - [RawSlideCountdownBuilder], a function signature for the builder used
///   to create the countdown widget.
/// {@endtemplate}
class RawSlideCountdown extends StatelessWidget {
  /// {@macro raw_slide_countdown}
  const RawSlideCountdown({
    required this.streamDuration,
    required this.builder,
    super.key,
  });

  /// The [StreamDuration] that provides the countdown duration.
  final StreamDuration streamDuration;

  /// The builder function used to create the countdown widget.
  /// {@macro raw_slide_countdown_builder}
  final RawSlideCountdownBuilder builder;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ValueListenableBuilder(
        valueListenable: streamDuration,
        builder: (_, duration, __) => builder(context, duration),
      ),
    );
  }
}
