import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Animates2 extends StatefulWidget {
  const Animates2({super.key});

  @override
  State<Animates2> createState() => _Animates2State();
}

class _Animates2State extends State<Animates2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<EdgeInsets> _padding;
  late Animation<Color?> _color;
  late Animation<Size?> _size;
  late Animation<BorderRadius?> _radius;
  late Animation<Alignment> _alignment;

  // 👇 Curved animation ke liye alag variables
  late Animation<double> _curvedSize;
  late Animation<Color?> _curvedColor;

  int count = 0;
  bool like = false;

  void increament() {
    setState(() {
      count++;
    });
  }

  void decreament() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      value: 1,
    )..repeat(reverse: true);

    // Normal Animations
    _color = ColorTween(
      begin: Colors.red,
      end: Colors.lightBlue,
    ).animate(_controller);

    _size = SizeTween(
      begin: const Size(50, 100),
      end: const Size(200, 100),
    ).animate(_controller);

    _radius = BorderRadiusTween(
      begin: BorderRadius.circular(100),
      end: BorderRadius.circular(20),
    ).animate(_controller);

    _alignment = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.center,
    ).animate(_controller);

    _padding = EdgeInsetsTween(
      begin: const EdgeInsets.all(8),
      end: const EdgeInsets.all(30),
    ).animate(_controller);

    // 👇 Curved Animation banaya
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut, // bounce effect
    );

    _curvedSize = Tween<double>(begin: 50, end: 150).animate(curved);

    _curvedColor = ColorTween(
      begin: Colors.purple,
      end: Colors.orange,
    ).animate(curved);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Like Button
          GestureDetector(
            onTap: () {
              setState(() {
                like = !like;
              });
            },
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 200),
                height: 50,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: like
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_outline),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Counter
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Colors.blue.shade300,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: increament,
                  child: const Icon(Icons.add, size: 25),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "$count",
                    style: GoogleFonts.nerkoOne(fontSize: 24),
                  ),
                ),
                GestureDetector(
                  onTap: decreament,
                  child: const Icon(Icons.remove, size: 25),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Normal Animated Box with multiple tweens
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  alignment: _alignment.value,
                  padding: _padding.value,
                  child: Container(
                    width: _size.value?.width,
                    height: _size.value?.height,
                    decoration: BoxDecoration(
                      color: _color.value,
                      borderRadius: _radius.value,
                    ),
                    child: const Center(child: Text("Normal Box")),
                  ),
                );
              },
            ),
          ),

          // 👇 Separate Curved Animation Box
          Expanded(
            child: AnimatedBuilder(
              animation: _curvedSize,
              builder: (context, child) {
                return Center(
                  child: Container(
                    width: _curvedSize.value,
                    height: _curvedSize.value,
                    decoration: BoxDecoration(
                      color: _curvedColor.value,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text("Curved Box"),
                    ),
                  ),
                );
              },
            ),
          ),

          // Image with fade animation
          Stack(
            children: [
              FadeTransition(
                opacity: _controller,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    color: const Color(0xddC8C8C8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const Positioned(
                left: 10,
                child: Image(
                  image: AssetImage("assets/images/ali.png"),
                  height: 280,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
