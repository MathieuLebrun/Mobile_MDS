import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_mds/models/login_request.dart';
import 'package:mobile_mds/services/APIService.dart';
import '../models/login_response.dart';
import '../models/team_response.dart';
import '../services/PersistanceHandler.dart';
import 'tachedev.dart'; 



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
                        obscureText: true,
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
                        onPressed: ()async {
                          // Logique à exécuter lorsque le bouton est pressé
                        LoginRequestModel model   = LoginRequestModel(action: "CONNECT", login: emailcontroller.text, password: mdpcontroller.text, token:"");
                          Map<String, String> queryParams = {
                            'action': 'CONNECT',
                            'login': emailcontroller.text,
                            'password': mdpcontroller.text,
                            'token': ' ',
                          };
                          var response=  await APIService.postdata(model,queryParams);
                          if(response.statusCode==200){
                              var LoginResponse = loginResponseJson(response.body);
                              if(LoginResponse.status == 'success'){
                                PersistanceHandler().setTokenEDP(LoginResponse.session.token);
                                    Map<String, String> queryParams = {
                                      'action': 'USER',
                                      'token': LoginResponse.session.token,
                                      'type': "login",
                                    };
                                    var response=  await APIService.getdata(queryParams);
                                    if(response.statusCode==200){
                                        var TeamResponse = teamResponseJson(response.body);
                                        if(TeamResponse.status == 'success'){
                                          inspect(TeamResponse.data[0].team);
                                          
                                          if (TeamResponse.data[0].team == 'Dev / Support'){
                                            showInSnackBar("✅ Connexion réussie !");
                                              // ignore: use_build_context_synchronously
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => TacheDevScreen()), // Remplacez TachePage() par le nom de votre classe de page tache.dart
                                            );
                                          }
                                          if (TeamResponse.data[0].team == 'Marketing / Commercial'){
                                            showInSnackBar("✅ Connexion réussie !");
                                              // ignore: use_build_context_synchronously
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => TacheDevScreen()), // Remplacez TachePage() par le nom de votre classe de page tache.dart
                                            );
                                          }
                                          

                                        }else {
                                          showInSnackBar("❌${LoginResponse.tokenStatus}");
                                        }
                                    }else{
                                      showInSnackBar("❌ Une erreur de connexion s'est produite lors de la tentative de connexion. Veuillez vérifier l'état de votre réseau internet.");
                                    }

                              }else {
                                showInSnackBar("❌${LoginResponse.tokenStatus}");
                              }
                          }else{
                            showInSnackBar("❌ Une erreur de connexion s'est produite lors de la tentative de connexion. Veuillez vérifier l'état de votre réseau internet.");
                          }
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
  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}


