import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  final emailcontroller = TextEditingController();
  final mdpcontroller = TextEditingController();
  Widget build(BuildContext context) {
    var largeurEcran = MediaQuery.of(context).size.width;
    var hauteurEcran = MediaQuery.of(context).size.height;
    
    return Scaffold(
        body: 
        ListView(
              children: [ 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.2, 0, 0),
                      child: const Text(
                        "Connectez-vous",
                        style: TextStyle(
                          fontSize: 30, 
                        ),
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.1, 0, 0),
                      width: largeurEcran*0.7,
                      child: TextField(
                      
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Identifiant',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          contentPadding: EdgeInsets.only(left: 16.0),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.07, 0, 0),
                      width: largeurEcran*0.7,
                      child: TextField(
                      
                        controller: mdpcontroller,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Mot de passe',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          contentPadding: EdgeInsets.only(left: 16.0),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.1, 0, 0),
                      width: largeurEcran*0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          // Logique à exécuter lorsque le bouton est pressé
                        },
                        child: const Text('SE CONNECTER'),
                      ),
                    )
                  ],
                ),
                
              ],    
            ),
          );
        
      
    
  }
}


