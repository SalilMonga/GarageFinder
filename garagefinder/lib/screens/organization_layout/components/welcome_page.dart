import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  final String firstName;
  final VoidCallback onAnimationComplete;

  const WelcomePage({
    super.key,
    required this.firstName,
    required this.onAnimationComplete,
  });

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shrinkAnimation;
  Offset? _circleCenter;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate the center point after the first frame is rendered
      final size = MediaQuery.of(context).size;
      setState(() {
        _circleCenter =
            size.center(Offset.zero) - const Offset(0, 50); // Move 50 pixels up
      });
      _controller.forward().then((_) {
        widget.onAnimationComplete(); // Notify parent when animation finishes
      });
      // Start the animation after a short delay
      // Future.delayed(const Duration(milliseconds: 10), () {

      // });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set up the shrinking animation
    final size = MediaQuery.of(context).size;
    _shrinkAnimation = Tween<double>(
      begin: size.longestSide * 1.5, // Start fully covering the screen
      end: 0, // Shrink to a point
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Show a placeholder while waiting for layout to calculate the center
    if (_circleCenter == null) {
      return Container(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.blue.shade900
            : Colors.blue.shade200,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            // Underlying page content (OrganizationsPage)
            Positioned.fill(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            // Shrinking circle overlay
            Positioned.fill(
              child: ClipPath(
                clipper: CircleRevealClipper(
                  radius: _shrinkAnimation.value,
                  center: _circleCenter!,
                ),
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.blue.shade900
                      : Colors.blue.shade200,
                  child: Center(
                    child: _shrinkAnimation.value >
                            50 // Show text while the circle is large
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Hi, ${widget.firstName}!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Welcome to Garage Finder',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.white70,
                                    ),
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Custom clipper for shrinking circle
class CircleRevealClipper extends CustomClipper<Path> {
  final double radius;
  final Offset center;

  CircleRevealClipper({required this.radius, required this.center});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(Rect.fromCircle(center: center, radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return oldClipper.radius != radius || oldClipper.center != center;
  }
}
