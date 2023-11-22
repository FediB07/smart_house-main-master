import 'package:flutter/material.dart';
//import 'package:iotproject/screens/sign_Up.dart';


class WelcomeButton extends StatelessWidget {
  const WelcomeButton({super.key,this.buttontext,this.onTap});
  final String? buttontext;
  final Widget?  onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Navigator.push(
          context,
           MaterialPageRoute(
            builder: (e)=> onTap!,
            ),
            );
      },
      child: Container(
        width: 150,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))    ),
          child: Center(
            child: Text(buttontext!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
      ),
    );
  }
}