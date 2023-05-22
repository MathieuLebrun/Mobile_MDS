import 'package:flutter/material.dart';
import 'package:mobile_mds/models/login_request.dart';
import 'package:mobile_mds/services/APIService.dart';

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
                          var response=  await APIService.login(model,queryParams);
                          if(response.statusCode==200){
                              showInSnackBar("gg  tu tes co ;) ✅✅✅✅");
                          }else{
                            showInSnackBar("un effort frerot tu sais pas rentrer le boñ mdp;❌❌❌❌❌");
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


