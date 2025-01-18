import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0; // Current scale
  double _baseScale = 1.0; // Scale at the start of the gesture
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateScaleTo(double targetScale) {
    _animation = Tween<double>(begin: _scale, end: targetScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.reset();
    _controller.forward();

    _controller.addListener(() {
      setState(() {
        _scale = _animation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _baseScale = _scale;
      },
      onScaleUpdate: (details) {
        setState(() {
          _scale = (_baseScale * details.scale).clamp(0.5, 5.0);
        });
      },
      onScaleEnd: (details) {
        // Snap back to a natural scale if out of bounds
        if (_scale < 0.75) {
          _animateScaleTo(1.0); // Snap back to normal size
        } else if (_scale > 4.0) {
          _animateScaleTo(4.0); // Snap back to max size
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Smooth Zoom In & Out Emoji"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Transform.scale(
            scale: _scale,
            child: const Text(
              '😊',
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
      ),
    );
  }
}
