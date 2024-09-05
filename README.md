# MuqSnackbar - [![pub package](https://img.shields.io/badge/pub.dev-i)](https://pub.dev/packages/muq_snackbar)

## Media
![Simulator Screen Recording - iPhone 11 - 2024-09-05 at 13 21 26](https://github.com/user-attachments/assets/15107d9d-176e-4231-9e90-e94f2656e9f1)

## How to Use
```dart
OutlinedButton(
  onPressed: () {
    MuqSnackbar(
      context: context,
      title: "MuqSnackbar",
      content: "This is a MuqSnackbar with bottom position",
      leading: const Icon(Icons.info, color: Colors.blue),
      position: MuqPosition.bottom,
      closeBuilder: (context, closeFunction) {
        return IconButton(
          onPressed: closeFunction,
          icon: const Icon(Icons.close),
        );
      },
    );
  },
  child: const Text(
    "Show MuqSnackbar",
    style: TextStyle(color: Colors.black, fontSize: 18),
  ),
),
```

and all parameters

```dart
/// BuildContext of snackbar
final BuildContext context;

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

/// Snackbar's close function returns a widget
final CloseBuilder? closeBuilder;
```


