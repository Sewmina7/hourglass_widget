import 'package:flutter/material.dart';
import 'package:hourglass_widget/hourglass_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hourglass Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hourglass Widget Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Animated Hourglass',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Hourglass(
                    fillAmount: _animation.value,
                    width: 120,
                    height: 180,
                    colors: const [
                      Colors.blue,
                      Colors.green,
                      Colors.red,
                    ],
                    colorStops: const [0.2, 0.6, 1.0],
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Static Hourglass Examples',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('25% Full'),
                      Hourglass(
                        fillAmount: 0.25,
                        width: 80,
                        height: 120,
                        colors: const [Colors.purple, Colors.pink],
                        colorStops: const [0.0, 1.0],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('50% Full'),
                      Hourglass(
                        fillAmount: 0.5,
                        width: 80,
                        height: 120,
                        colors: const [Colors.orange, Colors.yellow],
                        colorStops: const [0.0, 1.0],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('75% Full'),
                      Hourglass(
                        fillAmount: 0.75,
                        width: 80,
                        height: 120,
                        colors: const [Colors.teal, Colors.cyan],
                        colorStops: const [0.0, 1.0],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_animationController.isAnimating) {
                    _animationController.stop();
                  } else {
                    _animationController.repeat(reverse: true);
                  }
                },
                child: Text(_animationController.isAnimating ? 'Stop Animation' : 'Start Animation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
