import 'package:flutter/material.dart';
import 'package:iotproject/screens/login.dart';
import 'package:iotproject/widgets/custom_scaffold.dart';
import 'package:iotproject/widgets/welcome_button.dart';







class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return  CustomScaffold(
      child:Column(
        children: [
          SizedBox(height: 380,),
          Flexible(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              WelcomeButton(
                buttontext: 'Login',
                onTap: LoginScreen(),
              ),
              
             
            ],
          ))
        ],
    
      ),
    );
  }

}