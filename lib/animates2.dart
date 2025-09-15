import 'package:flutter/material.dart';

class Animates2 extends StatefulWidget {
  const Animates2({super.key});

  @override
  State<Animates2> createState() => _Animates2State();
}

class _Animates2State extends State<Animates2>
with SingleTickerProviderStateMixin{

  bool like=false;

  late AnimationController _controller;


  @override
  void initState() {
    // TODO: implement initState
    _controller= AnimationController(
        vsync: this,
      duration: Duration(seconds: 2)
    )..repeat();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: like? Icon(Icons.favorite_outline): Icon(Icons.favorite),
      ),
    );
  }
}
