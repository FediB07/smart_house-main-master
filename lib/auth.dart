
import 'package:firebase_auth/firebase_auth.dart';



class Auth  {
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  User? get currentUser => fireAuth.currentUser;
  Stream<User?> get authStateHandle => fireAuth.authStateChanges();




}