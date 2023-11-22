import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '../send_mail.dart';
import '../widgets/snackbar.dart';


Future<void> addDataToFirestore(String name, String email, String role, String password) async {
  try {
    var userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userId = userCredential.user!.uid; // Obtain the user ID

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(userId).set({
      'name': name,
      'email': email,
      'role': role,
      'userId': userId, // Add the user ID to Firestore
    });

    print('Data added to Firestore successfully');
  } catch (e) {
    print('Error adding data to Firestore: $e');
  }
}









Future<void> deleteUser(String userId) async {
  try {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    await usersCollection.doc(userId).delete();

    print('Utilisateur supprimé avec succès');
  } catch (e) {
    print('Erreur lors de la suppression de l\'utilisateur: $e');
  }
}


Future<void> deleteAllUsers() async {
  try {
    final QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();

    for (QueryDocumentSnapshot userDocument in usersSnapshot.docs) {
      String userId = userDocument.id;
      await deleteUser(userId);
    }

    print('Tous les utilisateurs ont été supprimés avec succès');
  } catch (e) {
    print('Erreur lors de la suppression de tous les utilisateurs: $e');
  }
}




class admin extends StatefulWidget {
  @override
  _adminState createState() => _adminState();
}

class _adminState extends State<admin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final namecontroller =TextEditingController();
  final emailController =TextEditingController();
  final roleController =TextEditingController();
  final passwordController =TextEditingController();
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');


  void _showModal() {

    namecontroller.text = '';
    emailController.text = '';
    passwordController.text='';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create User '),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: namecontroller,
                   decoration: InputDecoration(
                    contentPadding:const EdgeInsets.symmetric(horizontal: 22),
                    label: const Text('name'),
                    hintText: 'Enter name',
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
                const SizedBox(height: 10,),

                TextFormField(
                  controller: emailController,
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

                 const SizedBox(height: 10,),
                TextFormField(
                  obscureText: true,
                   obscuringCharacter: '*',
                  controller: passwordController,
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

                ),

               const SizedBox(height: 10,),

                TextFormField(
                  controller:roleController ,
                  decoration: InputDecoration(
                    contentPadding:const EdgeInsets.symmetric(horizontal: 22),
                    label: const Text('state'),
                    hintText: 'Enter state',
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
                const SizedBox(height: 10,),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Traitez les données du formulaire ici
                      // print('Nom: $name');
                      // print('Email: $email');

                      addDataToFirestore(namecontroller.text, emailController.text.toString().trim(), roleController.text,passwordController.text.toString().trim());
                      Navigator.of(context).pop(); // Ferme le modèle
                      Mailer().sendMail(to: emailController.text.toString().trim(), fullName: namecontroller.text.toString().trim(), passwordUser: passwordController.text);

                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void UpdateUser(userDocument) {

    namecontroller.text = userDocument?['name'];

    emailController.text = userDocument?['email'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update User '),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      contentPadding:const EdgeInsets.symmetric(horizontal: 22),
                      label: const Text('name'),
                      hintText: 'Enter name',
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
                const SizedBox(height: 10,),

                TextFormField(
                  controller: emailController,
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

                const SizedBox(height: 10,),




                const SizedBox(height: 10,),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Traitez les données du formulaire ici
                      // print('Nom: $name');
                      // print('Email: $email');
                      try{
                        if (_formKey.currentState?.validate() ?? false) {
                          FirebaseFirestore.instance.collection('users').doc(userDocument!.id)
                              .update({"email":emailController.text , "name":namecontroller.text});
                        }

                      }on FirebaseAuthException catch(e){
                        print(e.code);
                      }
                      addDataToFirestore(namecontroller.text, emailController.text.toString().trim(), roleController.text,passwordController.text.toString().trim());

                      Navigator.of(context).pop();// Ferme le modèle
                      namecontroller.text = '';
                      emailController.text = '';
                      passwordController.text='';
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
// void _deleteAllUsers() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete all users?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Delete all'),
//               onPressed: () async {
//                 await deleteAllUsers();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: _showModal,
        icon: Icon(Icons.add),
        label: Text('Add'),
      ),
      appBar: AppBar(
        elevation:100,
        bottomOpacity:20,
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
              style: TextStyle(
                fontSize: 16,
              ),
              "Admin Dhashboard"
          ),
        ),
        actions: [
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
          )
        ],
      ) ,
      body: Column(
        children: [

        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: usersCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final data = snapshot.data?.docs;

              if (data!.isEmpty) {
          // Display an image or any widget when the list is empty
          return Center(
            child: CircularProgressIndicator(), // Replace with the path to your image asset
          );
        }

              return ListView(
                children: data.map((userDocument) {

                  print('------------------sssss----- ${userDocument.data()}');
                  final user = userDocument.data() as Map<String, dynamic>;

                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: ListTile(
                      title: Text(user['name'].toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${user['email']}'),
                          Text('Role: ${user['role']}'),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Supprimer cet utilisateur?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Annuler'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Supprimer'),
                                          onPressed: () async {
                                            String userId = userDocument.id;
                                            Navigator.of(context).pop();
                                            await deleteUser(userId);

                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                UpdateUser(userDocument);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),

              );
            },
          ),
        ),



        ],
      ),
    );
  }
}
