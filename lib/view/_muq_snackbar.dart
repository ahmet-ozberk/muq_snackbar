part of '../base/muq_snackbar_base.dart';

typedef CloseBuilder = Widget Function(
    BuildContext context, VoidCallback closeFunction);

class _MuqSnackbarWidget extends StatefulWidget {
  final String? title;
  final String? content;
  final Duration animationDuration;
  final Duration snackbarDuration;
  final Curve? animationCurve;
  final bool autoDismiss;
  final MuqPosition snackbarPosition;
  final Function() getscaleFactor;
  final Function() getPosition;
  final Function() onRemove;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final BorderSide? border;
  final Widget? child;
  final Widget? leading;
  final Widget? trailing;
  final List<BoxShadow>? shadows;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final CloseBuilder? closeBuilder;

  const _MuqSnackbarWidget({
    super.key,
    this.title,
    this.content,
    required this.animationDuration,
    required this.snackbarDuration,
    this.animationCurve,
    required this.autoDismiss,
    required this.snackbarPosition,
    required this.getscaleFactor,
    required this.getPosition,
    required this.onRemove,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.child,
    this.leading,
    this.trailing,
    this.shadows,
    this.padding,
    this.margin,
    this.closeBuilder,
  });

  @override
  State<_MuqSnackbarWidget> createState() => _MuqSnackbarWidgetState();
}

class _MuqSnackbarWidgetState extends State<_MuqSnackbarWidget> {
  final GlobalKey positionedKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: widget.animationDuration.inMilliseconds),
      key: positionedKey,
      curve: Curves.easeOutBack,
      top: widget.snackbarPosition == MuqPosition.top
          ? widget.getPosition() + 70
          : null,
      bottom: widget.snackbarPosition == MuqPosition.bottom
          ? widget.getPosition() + 70
          : null,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: AnimatedScale(
          duration: widget.animationDuration,
          curve: Curves.bounceOut,
          scale: widget.getPosition() == 0 ? 1 : widget.getscaleFactor(),
          child: getChildBasedOnDissmiss,
        ),
      ),
    );
  }

  Widget get getChildBasedOnDissmiss {
    return Animate(
      onComplete: (controller) {
        if (widget.autoDismiss) {
          widget.onRemove();
        }
      },
      effects: [
        SlideEffect(
            begin: Offset(
                0, widget.snackbarPosition == MuqPosition.bottom ? 0.6 : -0.6),
            end: Offset.zero,
            duration: Duration(
                milliseconds: 2 * widget.animationDuration.inMilliseconds),
            curve: widget.animationCurve ?? Curves.elasticOut),
        FadeEffect(duration: widget.animationDuration, begin: 0, end: 1),
        if (widget.autoDismiss)
          SlideEffect(
            delay: widget.snackbarDuration,
            duration: widget.animationDuration * 3,
            curve: widget.animationCurve ?? Curves.fastLinearToSlowEaseIn,
            begin: Offset.zero,
            end: Offset(
              0,
              widget.snackbarPosition == MuqPosition.bottom ? 4 : -4,
            ),
          )
      ],
      child: Dismissible(
        direction: DismissDirection.vertical,
        key: UniqueKey(),
        onDismissed: (direction) {
          widget.onRemove();
        },
        child: widget.child ??
            Container(
              padding: widget.padding,
              margin: widget.margin,
              decoration: ShapeDecoration(
                shape: ContinuousRectangleBorder(
                  borderRadius:
                      widget.borderRadius ?? BorderRadius.circular(36),
                  side: widget.border ?? BorderSide.none,
                ),
                color: widget.backgroundColor ??
                    Theme.of(context).dialogBackgroundColor,
                shadows: widget.shadows ??
                    [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12, // Artan blur etkisi
                        spreadRadius: 2,
                        offset: const Offset(0, 4), // Dikey gölge
                      ),
                    ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconTheme(
                    data: const IconThemeData(size: 20),
                    child: Row(
                      children: [
                        if (widget.leading != null) widget.leading!,
                        if (widget.leading != null) const SizedBox(width: 4),
                        if (widget.title != null)
                          Expanded(
                            child: Text(
                              widget.title!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                fontFamily: "Roboto",
                              ),
                              maxLines: 2,
                            ),
                          ),
                        if (widget.trailing != null) const SizedBox(width: 8),
                        if (widget.trailing != null) widget.trailing!,
                        if (widget.closeBuilder != null)
                          const SizedBox(width: 4),
                        if (widget.closeBuilder != null)
                          widget.closeBuilder!(context, () {
                            widget.onRemove();
                          }),
                      ],
                    ),
                  ),
                  if (widget.content != null)
                    Text(
                      widget.content!,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.1,
                        fontFamily: "Inter",
                      ),
                    ),
                ],
              ),
            ),
      ),
    );
  }
}
