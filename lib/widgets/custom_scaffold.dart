import 'package:flutter/material.dart';




class CustomScaffold extends StatelessWidget {
  final Widget? child;
  const CustomScaffold({super.key, this.child});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(children: <Widget>[
        Image.asset('assets/images/wel.jpg',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        ),
        SafeArea(child: child!)
      ]) ,
      
    );
  }
}