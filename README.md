# gn_list_animator

A highly customizable Flutter widget for creating animated lists with smooth index-based scrolling and beautiful staggered animations.

[![GitHub license](https://img.shields.io/github/license/GeorgeNady/flutter_gn_list_animator)](https://github.com/GeorgeNady/flutter_gn_list_animator/blob/main/LICENSE)

## Features

- **Staggered Animations**: Easily apply entrance animations (slide, fade) to list items.
- **Index-Based Scrolling**: Jump or scroll to any item in the list by its index using `GnListAnimatorController`.
- **Customizable Animations**: Control duration, vertical/horizontal offsets, and animation curves.
- **Flexible Layout**: Supports vertical and horizontal scrolling, separators, and custom physics.
- **Easy Integration**: Works with standard Flutter widgets and fits seamlessly into any UI.

## Getting started

Since this package is hosted on GitHub, you can add it to your `pubspec.yaml` using:

```yaml
dependencies:
  gn_list_animator:
    git:
      url: https://github.com/GeorgeNady/flutter_gn_list_animator.git
      ref: main
```

## Usage

### Simple Example

```dart
GnListAnimator(
  children: List.generate(
    20,
    (index) => Card(
      child: ListTile(
        title: Text('Item $index'),
      ),
    ),
  ),
)
```

### With Controller (Scroll to Index)

```dart
final GnListAnimatorController _controller = GnListAnimatorController();

// Use the controller to scroll to a specific index
void _scrollToFifthItem() {
  _controller.scrollToIndex(
    5,
    duration: Duration(milliseconds: 800),
    curve: Curves.bounceOut,
  );
}

@override
Widget build(BuildContext context) {
  return GnListAnimator(
    gnController: _controller,
    children: myWidgets,
  );
}
```

## Parameters

### GnListAnimator

| Parameter | Type | Default | Description |
|---|---|---|---|
| `children` | `List<Widget>` | **Required** | The list of widgets to animate. |
| `gnController` | `GnListAnimatorController?` | `null` | Controller for index-based scrolling and jumping. |
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
