import 'package:flutter/material.dart';
import 'package:mobile_mds/models/login_request.dart';
import 'package:mobile_mds/services/APIService.dart';
import 'package:flutter/material.dart';

// Liste des options du select
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];



class TacheScreen extends StatefulWidget {
  TacheScreen();

  @override
  TacheScreenState createState() => TacheScreenState();
}



class TacheScreenState extends State<TacheScreen> {
  @override
  final emailcontroller = TextEditingController();
  final mdpcontroller = TextEditingController();

  
  Widget build(BuildContext context) {
    var largeurEcran = MediaQuery.of(context).size.width;
    var hauteurEcran = MediaQuery.of(context).size.height;
    String dropdownValue = list.first;

    return Scaffold(
        body: 
        ListView(
              children: [ 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.1, 0, 0),
                      child: const Text(
                        "Saisir une tache",
                        style: TextStyle(
                          fontSize: 30, 
                        ),
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.1, 0, 0),
                      width: largeurEcran*0.9,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.05, 0, 0),
                      width: largeurEcran*0.9,
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
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.05, 0, 0),
                      width: largeurEcran*0.9,
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
                      margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.05, 0, 0),
                      width: largeurEcran*0.9,
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