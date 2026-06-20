# gn_list_animator

A highly customizable Flutter widget for creating animated lists with smooth index-based scrolling, scroll direction detection, and beautiful staggered animations.

[![GitHub license](https://img.shields.io/github/license/GeorgeNady/flutter_gn_list_animator)](https://github.com/GeorgeNady/flutter_gn_list_animator/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/GeorgeNady/flutter_gn_list_animator)](https://github.com/GeorgeNady/flutter_gn_list_animator/stargazers)

## Features

- **Unified Controller**: `GnListAnimatorController` extends `ScrollController`, giving you standard offset control PLUS index-based scrolling (`scrollToIndex`).
- **Scroll Callbacks**: Detect scroll direction easily with `onScrollUp` and `onScrollDown` callbacks.
- **Staggered Animations**: Apply smooth entrance animations (slide, fade) to list items automatically.
- **Index-Based Scrolling**: Jump or scroll to any item in the list by its index.
- **Position Tracking**: Get the current visible indices (`firstVisibleIndex`, `lastVisibleIndex`) at any time.
- **Flexible Layout**: Supports vertical and horizontal scrolling, separators, and custom physics.
- **Hybrid Rendering**: Automatically chooses between `ListView` and `ScrollablePositionedList` for optimal performance.

## Getting started

Since this package is hosted on GitHub, you can add it to your `pubspec.yaml` using:

### Using the Latest Version (Main Branch)
```yaml
dependencies:
  gn_list_animator:
    git:
      url: https://github.com/GeorgeNady/flutter_gn_list_animator.git
      ref: main
```

### Using a Specific Release (Recommended for Stability)
To use a specific version, you can point to its tag:
```yaml
dependencies:
  gn_list_animator:
    git:
      url: https://github.com/GeorgeNady/flutter_gn_list_animator.git
      ref: v1.1.1
```

## Usage

### Simple Example with Scroll Callbacks

```dart
GnListAnimator(
  onScrollDown: () => print("User is scrolling down"),
  onScrollUp: () => print("User is scrolling up"),
  children: List.generate(
    20,
    (index) => ListTile(title: Text('Item $index')),
  ),
)
```

### Using the Unified Controller

The `GnListAnimatorController` works exactly like a `ScrollController` but adds `scrollToIndex`.

```dart
final GnListAnimatorController _controller = GnListAnimatorController();

@override
void initState() {
  super.initState();
  _controller.addListener(() {
    print("Current Offset: ${_controller.offset}");
  });
}

// Scroll to the 10th item
void _goToItemTen() {
  _controller.scrollToIndex(10);
}

// Check which items are currently visible
void _checkPosition() {
  print("First visible index: ${_controller.firstVisibleIndex}");
  print("Last visible index: ${_controller.lastVisibleIndex}");
}

@override
Widget build(BuildContext context) {
  return GnListAnimator(
    controller: _controller,
    children: myWidgets,
  );
}
```

## Parameters

### GnListAnimator

| Parameter | Type | Default | Description |
|---|---|---|---|
| `children` | `List<Widget>` | **Required** | The list of widgets to animate. |
| `controller` | `ScrollController?` | `null` | Pass a `GnListAnimatorController` for index-based features or a standard `ScrollController`. |
| `onScrollDown` | `VoidCallback?` | `null` | Triggered when user scrolls towards the bottom. |
| `onScrollUp` | `VoidCallback?` | `null` | Triggered when user scrolls towards the top. |
| `separator` | `Widget?` | `null` | Optional widget to display between items. |
| `durationInMillis` | `int?` | `100` | Stagger delay between item animations. |
| `verticalOffset` | `double?` | `50.0` | Initial vertical offset for the slide animation. |
| `horizontalOffset` | `double?` | `null` | Initial horizontal offset for the slide animation. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding around the list. |
| `scrollDirection` | `Axis` | `Axis.vertical` | The direction in which the list scrolls. |
| `curve` | `Curve?` | `Curves.easeInOut` | The animation curve for item entrance. |
| `physics` | `ScrollPhysics?` | `ScrollPhysics()` | How the list should respond to user input. |
| `shrinkWrap` | `bool` | `true` | Whether the list should wrap its content. |
| `clipBehavior` | `Clip` | `Clip.none` | How to clip the list's content. |

## License

MIT
