// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotproject/screens/gazscreen.dart';
import 'package:iotproject/screens/tempcontroller.dart';

import '../auth.dart';
import '../widgets/snackbar.dart';

class userinterfaceq extends StatefulWidget {
  const userinterfaceq({Key? key}) : super(key: key);

  @override
  State<userinterfaceq> createState() => _userlistState();
}

class _userlistState extends State<userinterfaceq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(
                    'WELCOME USER',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 50,
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.indigo,
                          size: 25,
                        ),
                        onPressed: () {
                          print('clicbole');
                        },
                      ),
                    ),

                    IconButton(
                      onPressed: () async{
                        String? SignoutStatus = '';
                        String? color = 'success';
                        try{

                          await Auth().fireAuth.signOut();
                          print('Signout pressed');
                          SignoutStatus = 'Signout Success';
                          Navigator.of(context).pushNamedAndRemoveUntil('login' , (Route <dynamic> route ) => false);

                        } on FirebaseAuthException catch(e){
                          SignoutStatus=e.code;
                          color ='danger';
                        }
                        final snackBar = CustomSnackBar.showErrorSnackBar(SignoutStatus, color);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);


                      },
                      icon: Icon(Icons.logout_sharp),
                      color: Colors.indigo,
                    )
                  ],
                ),
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 32),
                    Center(
                      child: Image.asset(
                        'assets/images/banner.png',
                        scale: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        'Smart Home',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Padding(
                      padding: const EdgeInsets.only(left: 48),
                      child: const Text(
                        'SERVICES',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _cardMenu(
                          onTap: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => GazController (),
                                ),
                                );

                          },
                          icon: 'assets/logo/gas.png',
                          title: 'GAZ',
                        ),
                        _cardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const tempcontroller(),
                              ),
                            );
                          },
                          icon: 'assets/images/temperature.png',
                          title: 'TEMPERATURE',
                          color: Colors.indigoAccent,
                          fontColor: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _cardMenu(
                          icon: 'assets/logo/door-knob.png',
                          title: 'DOOR',
                        ),
                        _cardMenu(
                          icon: 'assets/logo/emergency.png',
                          title: 'HUMIDITE',
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardMenu({
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 36,
        ),
        width: 156,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Image.asset(icon,width: 80,height: 80,),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
            )
          ],
        ),
      ),
    );
  }
}
