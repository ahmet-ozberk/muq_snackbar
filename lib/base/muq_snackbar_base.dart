// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:muq_snackbar/utils/muq_snackbar_enum.dart';

import '../utils/utils.dart';

part '../../view/_muq_snackbar.dart';

List<MuqSnackbar> _muqSnackbars = [];

final class MuqSnackbar {
  /// Duration of snackbar when autoDismiss is true
  final Duration duration;

  /// Snackbar position on screen
  final MuqPosition position;

  /// WidgetBuilder of snackbar
  final WidgetBuilder? builder;

  /// Set true to dismiss snackbar automatically
  final bool autoDismiss;

  /// Snackbar title widget
  final String? title;

  /// Snackbar message widget
  final String? content;

  /// Animation duration of snackbar
  final Duration animationDuration;

  /// Animation curve of snackbar
  final Curve? animationCurve;

  /// Info on each snackbar
  late final _SnackBarInfo info;

  /// BorderRadius of snackbar
  final BorderRadiusGeometry? borderRadius;

  /// Background color of snackbar
  final Color? backgroundColor;

  /// Border of snackbar
  final BorderSide? border;

  /// Leading widget of snackbar
  final Widget? leading;

  /// Trailing widget of snackbar
  final Widget? trailing;

  /// Card shadow of snackbar
  final List<BoxShadow>? shadows;

  /// Card padding of snackbar
  final EdgeInsetsGeometry? padding;

  /// Card margin of snackbar
  final EdgeInsetsGeometry? margin;

  /// Close function of snackbar
  final CloseBuilder? closeBuilder;

  /// Constructor of MuqSnackbar
  MuqSnackbar({
    this.duration = const Duration(seconds: 4),
    this.position = MuqPosition.top,
    this.autoDismiss = true,
    this.title,
    this.content,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve,
    this.builder,
    this.borderRadius,
    this.backgroundColor = Colors.white,
    this.border,
    this.leading,
    this.trailing,
    this.shadows,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.closeBuilder,
  })  : assert(duration.inMilliseconds > animationDuration.inMilliseconds),
        assert((content != null) || builder != null,
            'If content are null, builder cannot be null. If builder is null, title and content cannot be null.') {
    _show();
  }

  void remove() {
    info.entry.remove();
    _muqSnackbars.removeWhere((element) => element == this);
  }

  static void removeAll() {
    for (int i = 0; i < _muqSnackbars.length; i++) {
      _muqSnackbars[i].info.entry.remove();
    }
    _muqSnackbars.removeWhere((element) => true);
  }

  void _show() {
    final context = WidgetsBinding.instance.focusManager.primaryFocus!.context!;
    OverlayState overlayState = Overlay.of(context);
    info = _SnackBarInfo(
      key: GlobalKey<_MuqSnackbarWidgetState>(),
      createdAt: DateTime.now(),
    );
    info.entry = OverlayEntry(
      builder: (_) => _MuqSnackbarWidget(
        key: info.key,
        animationDuration: animationDuration,
        snackbarPosition: position,
        animationCurve: animationCurve,
        autoDismiss: autoDismiss,
        getPosition: () => calculatePosition(_muqSnackbars, this),
        getscaleFactor: () => calculateScaleFactor(_muqSnackbars, this),
        snackbarDuration: duration,
        onRemove: remove,
        title: title,
        content: content,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        border: border,
        leading: leading,
        trailing: trailing,
        shadows: shadows,
        padding: padding,
        margin: margin,
        closeBuilder: closeBuilder,
        child: builder != null ? builder!(context) : null,
      ),
    );

    WidgetsBinding.instance.endOfFrame.then((value) {
      _muqSnackbars.add(this);
      overlayState.insert(info.entry);
    });
  }
}

class _SnackBarInfo {
  late final OverlayEntry entry;
  final GlobalKey<_MuqSnackbarWidgetState> key;
  final DateTime createdAt;

  _SnackBarInfo({required this.key, required this.createdAt});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _SnackBarInfo &&
        other.entry == entry &&
        other.key == key &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => entry.hashCode ^ key.hashCode ^ createdAt.hashCode;
}

extension Cleaner on List<MuqSnackbar> {
  List<MuqSnackbar> clean() {
    return where((element) => element.info.key.currentState != null).toList();
  }
}
