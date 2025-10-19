# Hourglass Widget

<p align="center">
  <img src="https://raw.githubusercontent.com/Sewmina7/hourglass_widget/47923001a8bf1f13d64349d3267981f15bf42603/preview.gif" height="100" alt="Flutter Favorite" />
</p>
Github: https://github.com/Sewmina7/hourglass_widget
Pub.dev: https://pub.dev/packages/hourglass_widget

A beautiful painted hourglass widget for Flutter with customizable colors and gradients.

## Features

- 🎨 Customizable gradient colors and stops
- ⏱️ Animated fill amount (0.0 to 1.0)
- 📱 Responsive sizing
- 🎯 Smooth animations with CustomPainter
- 🔧 Easy to integrate 

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  hourglass_widget: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:hourglass_widget/hourglass_widget.dart';

// Simple hourglass
Hourglass(
  fillAmount: 0.5, // 50% full
  width: 100,
  height: 150,
)
```

### With Custom Colors

```dart
Hourglass(
  fillAmount: 0.75, // 75% full
  width: 120,
  height: 180,
  colors: [
    Colors.blue,
    Colors.green,
    Colors.red,
  ],
  colorStops: [0.2, 0.6, 1.0],
)
```

### Animated Hourglass

```dart
class AnimatedHourglass extends StatefulWidget {
  @override
  _AnimatedHourglassState createState() => _AnimatedHourglassState();
}

class _AnimatedHourglassState extends State<AnimatedHourglass>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Hourglass(
          fillAmount: _animation.value,
          width: 100,
          height: 150,
          colors: [Colors.purple, Colors.pink],
          colorStops: [0.0, 1.0],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `fillAmount` | `double` | Required | Fill amount from 0.0 (empty) to 1.0 (full) |
| `colors` | `List<Color>` | `[Colors.blue, Colors.green, Colors.red]` | Gradient colors |
| `colorStops` | `List<double>` | `[0.2, 0.6, 1.0]` | Color stops for gradient |
| `width` | `double` | `100` | Width of the hourglass |
| `height` | `double` | `150` | Height of the hourglass |

## Example

Check out the `example/` directory for a complete working example.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

