import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AniContainer extends StatefulWidget {
  const AniContainer({super.key});

  @override
  State<AniContainer> createState() => _AniContainerState();
}

class _AniContainerState extends State<AniContainer>
    with SingleTickerProviderStateMixin {
  // Animation controller (if needed later for explicit animations)
  late AnimationController _controller;

  // State variables for Animated widgets
  double _width = 100;
  double _height = 100;
  double _opacity = 1.0;
  Alignment _alignment = Alignment.topCenter;
  bool _showFirst = true;

  // For AnimatedSwitcher (box)
  bool _switcherToggle = true;

  // For AnimatedSwitcher (icon)
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    setState(() {
      // change properties to trigger animations
      _width = _width == 100 ? 150 : 100;
      _height = _height == 200 ? 300 : 200;
      _opacity = _opacity == 1.0 ? 0.3 : 1.0;
      _alignment = _alignment == Alignment.topCenter
          ? Alignment.bottomCenter
          : Alignment.topCenter;
      _showFirst = !_showFirst;
      _switcherToggle = !_switcherToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _startAnimation,
        child: const Icon(Icons.add, size: 24, color: Colors.black),
      ),
      appBar: AppBar(
        title: Text("Explicit", style: GoogleFonts.comicNeue(fontSize: 18)),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 AnimatedContainer
            AnimatedContainer(
              margin: const EdgeInsets.only(left: 20, top: 20),
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                ),
                color: Colors.red.shade500,
                border: const Border(
                  top: BorderSide(width: 1, color: Colors.yellow),
                ),
              ),
              duration: const Duration(seconds: 2),
              child: const Center(child: Text("Ahmad")),
            ),

            // 🔹 AnimatedOpacity
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInBack,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.orangeAccent,
                ),
                child: Center(
                  child: Text(
                    "Riaz",
                    style: GoogleFonts.notoSansNewTaiLue(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // 🔹 AnimatedAlign
            AnimatedAlign(
              alignment: _alignment,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInCubic,
              child: const Text("Ahmad-Riaz"),
            ),

            // 🔹 AnimatedCrossFade
            AnimatedCrossFade(
              firstChild: Container(
                width: 200,
                height: 200,
                color: Colors.lightGreen,
              ),
              secondChild: Image.network(
                "https://static.vecteezy.com/system/resources/thumbnails/028/794/706/small_2x/cartoon-cute-school-boy-photo.jpg",
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              crossFadeState: _showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(seconds: 3),
            ),

            // 🔹 AnimatedSwitcher (Box)
            AnimatedSwitcher(
              duration: const Duration(seconds: 3),
              switchInCurve: Curves.bounceIn,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: _switcherToggle
                  ? Container(
                key: const ValueKey(1),
                width: 200,
                height: 200,
                color: Colors.pink,
                child: const Center(
                  child: Text(
                    "Pink Box",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
                  : Container(
                key: const ValueKey(2),
                width: 200,
                height: 200,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    "Blue Box",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 AnimatedSwitcher (Icon toggle on tap)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: _isFavorite
                    ? const Icon(Icons.favorite,
                    key: ValueKey(1), color: Colors.pink, size: 50)
                    : const Icon(Icons.favorite_border,
                    key: ValueKey(2), color: Colors.grey, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
