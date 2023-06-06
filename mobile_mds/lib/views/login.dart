
import 'package:flutter/material.dart';
import 'package:mobile_mds/models/login_request.dart';
import 'package:mobile_mds/services/APIService.dart';
import 'package:mobile_mds/views/tachemarket.dart';
import '../models/login_response.dart';
import '../models/get_team.dart';
import '../services/PersistanceHandler.dart';
import 'tachedev.dart'; 



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}




class LoginScreenState extends State<LoginScreen> {

  final emailcontroller = TextEditingController();
  final mdpcontroller = TextEditingController();
  @override
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
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.16, 0, 0),
                      child: _buildLogo()
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.14, 0, 0),
                      child: const Text(
                        "Connectez-vous",
                        style: TextStyle(
                          fontSize: 30, 
                        ),
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.07, 0, 0),
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
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.05, 0, 0),
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
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.08, 0, 0),
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
                            var loginResponse = loginResponseJson(response.body);
                            if(loginResponse.status == 'success'){
                              PersistanceHandler().setTokenEDP(loginResponse.session.token);
                              Map<String, String> queryParams = {
                                'action': 'USER',
                                'token': loginResponse.session.token,
                                'type': "login",
                              };
                              var response2=  await APIService.getdata(queryParams);
                              if(response2.statusCode==200){
                                var teamResponse = teamResponseJson(response2.body);
                                if(teamResponse.status == 'success'){
                                  if (teamResponse.data[0].team == 'Dev / Support'){
                                    showInSnackBar("✅ Connexion réussie !");
                                      // ignore: use_build_context_synchronously
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const TacheDevScreen()), // Remplacez TachePage() par le nom de votre classe de page tache.dart
                                    );
                                  }
                                  if (teamResponse.data[0].team == 'Marketing / Commercial'){
                                    showInSnackBar("✅ Connexion réussie !");
                                      // ignore: use_build_context_synchronously
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const TacheMarketScreen()), // Remplacez TachePage() par le nom de votre classe de page tache.dart
                                    );
                                  }
                                  

                                }else {
                                  showInSnackBar("❌${loginResponse.tokenStatus}");
                                }
                              }else{
                                showInSnackBar("❌ Une erreur de connexion s'est produite lors de la tentative de connexion. Veuillez vérifier l'état de votre réseau internet.");
                              }
                            }else if(response.statusCode==401){
                              showInSnackBar("❌ ${loginResponse.tokenStatus}.");
                            }
                          }else if(response.statusCode==401){
                              var loginResponse = loginResponseJson(response.body);
                              showInSnackBar("❌ ${loginResponse.tokenStatus}.");
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

  Widget _buildLogo() {
    /// Construit le logo
    return Center(
        child: Image.asset(
      'images/long_logo.png', // Chemin relatif vers l'image
      width: 300, // Largeur souhaitée de l'image
      //height: 175, // Hauteur souhaitée de l'image
    ));
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}


