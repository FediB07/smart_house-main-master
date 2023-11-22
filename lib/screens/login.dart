





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotproject/widgets/custom_scaffold.dart';

import '../fireauth.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formloginKey =GlobalKey<FormState>();
  bool rememberPassword = true ;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
              )
              ),
          Expanded(
            flex: 7,
            child: Container(
              padding:const EdgeInsets.all(25),
              decoration: const  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)
                )
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formloginKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20,),
                      const Text(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.blue
                        ),
                      ),
                      const SizedBox(height: 40,),
                      TextFormField(
                        controller: emailController,
                       validator:(value){
                        if(value == null  || value.isEmpty){
                          return 'Please entre Email';
                        }
                        return null;
                       },
                  decoration: InputDecoration(
                    contentPadding:const EdgeInsets.symmetric(horizontal: 22),
                    label: const Text('Email'),
                    hintText: 'Enter Email',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12
                      ),
                      borderRadius:BorderRadius.circular(10),
                      
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color:Colors.black12 ),
                        borderRadius: BorderRadius.circular(10),
                        )
                  ),
                  
                ),
                      const SizedBox(height: 40,),
                      TextFormField(
                        controller: passwordController,
                      obscureText: true,
                      obscuringCharacter: '*',
                       validator:(value){
                        if(value == null  || value.isEmpty){
                          return 'Please entre Password';
                        }
                        return null;
                       },
                  decoration: InputDecoration(
                     contentPadding: const EdgeInsets.symmetric(horizontal: 22),
                    label: const Text('Password'),
                    hintText: 'Enter Password',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12
                      ),
                      borderRadius:BorderRadius.circular(10),
                      
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color:Colors.black12 ),
                        borderRadius: BorderRadius.circular(10),
                        )
                  ),
                  
                )
                      ,const SizedBox(height: 40,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            String statusFirebaseMessage = '';
                            if (_formloginKey.currentState!.validate() &&
                                rememberPassword) {
                              try {
                                var userAuth =
                                    await Fireauth().fireAuth.signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                );
                                if (userAuth.user != null) {
                                  var userData = await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userAuth.user!.uid)
                                      .get();
                                  var userRole = userData['role'];
                                  if (userRole == 'admin') {
                                    statusFirebaseMessage =
                                        'Login successful (Admin)';
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                        'admin', (route) => false);
                                  } else {
                                    statusFirebaseMessage =
                                        'Login successful (User)';
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            'user', (route) => false);
                                  }
                                }
                              } on FirebaseAuthException catch (e) {
                                statusFirebaseMessage = e.code;
                              }
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(statusFirebaseMessage),
                              ),
                            );
                          },
                          child: const Text('Login'),
                        ),
                      )
                      ,const SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Divider(
                            thickness: 0.7,
                            color: Colors.grey.withOpacity(0.5),

                          )),
                          const Padding(padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,

                          ),

                          ),

                        ],
                      ),
                      const SizedBox(height: 40,),
                      Row(
                        children: [

                        ],
                      )

                    ],
                  )),
              ),
            ),
          )
        ],
      ),
    );
  }
}