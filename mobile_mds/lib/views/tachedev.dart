import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mobile_mds/services/APIService.dart';
import '../models/get_item.dart';
import '../models/get_data_dev.dart';
import '../models/tachedev_request.dart';
import '../models/tachedev_response.dart';
import '../services/PersistanceHandler.dart';


const List<String> listType = <String>['Développement', 'Opérationnel', 'Support', 'Gestion', 'Congés', 'Recherche'];

class TacheDevScreen extends StatefulWidget {
  TacheDevScreen();

  @override
  TacheScreenState createState() => TacheScreenState();
}



class TacheScreenState extends State<TacheDevScreen> {
  late String token;
  @override
  void initState() {
    // ? La méthode init state c'est une méthode lancer une seule fois quand on arriver dans une view donc au lancement dans l'app on va dans le gestionnaire puis cette methode utiliser qu'une fois
    super.initState();
    init(); 
  }

  init() async {

    token = (await PersistanceHandler().getTokenEDP())!;
    
    getdata();
  }

  final tachecontroller = TextEditingController();
  final commentairecontroller = TextEditingController();

  late List datatableau = [];

  DateTime now = DateTime.now();

  String dropdownType = listType.first;

  // Liste des options du select
  List<String> projet = List<String>.empty(growable: true);
  List<String> sousProjet = List<String>.empty(growable: true);
  List<Client> client = List<Client>.empty(growable: true);
  List<String> nomClient = List<String>.empty(growable: true);

  double value = 0.5;


  void refreshPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => TacheDevScreen()),
    );
  }

  void increment() {
    setState(() {
      value += 0.5;
    });
  }

  void decrement() {
    setState(() {
      if (value > 0.5) {
        value -= 0.5;
      }
    });
  }

  Future<void> getdata() async{
    
    
    Map<String, String> queryParams2 = {
      'action': 'TACHEITEM',
      'token': token,
    }; 

    var response2 =  await APIService.getdata(queryParams2);
    if(response2.statusCode==200){
      var dataResponse = getItemJson(response2.body);
      if(dataResponse.status == 'success'){
        projet = dataResponse.projet;
        sousProjet = dataResponse.sousprojet;
        client = dataResponse.client;

        for( int i=0; i<dataResponse.client.length; i++){
          var clienNom = dataResponse.client[i];
          nomClient.add(clienNom.client);
        }
      }
    }


    Map<String, String> queryParams = {
      'action': 'TACHE',
      'token': token,
      'datatable[query][date]': '',
      'datatable[query][type]': 'false',      
      'datatable[query][projet]': 'false',
      'datatable[query][sousprojet]': 'false',
    }; 

    var response=  await APIService.getdata(queryParams);
    if(response.statusCode==200){
      var DataResponse = getdataDevJson(response.body);
      if(DataResponse.status == 'success'){
        datatableau = DataResponse.data;
        setState(() {
          dataready=true;
        });
      }
    }
  }

  bool dataready=false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var largeurEcran = MediaQuery.of(context).size.width;
    var hauteurEcran = MediaQuery.of(context).size.height;

    DateTime firstDayOfYear = DateTime(now.year, 1, 1);
    int weekNumber = ((now.difference(firstDayOfYear).inDays) / 7).ceil();

    return Scaffold(
        body:(dataready==true) 
        ? Form(
          key: _formKey,
          child: ListView(
          children: [
             
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.1, 0, 0),
                  child: const Text(
                    "Saisir une tâche",
                    style: TextStyle(
                      fontSize: 30, 
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.005, 0, 0),
                  child: const Text(
                    "Dev / Support",
                    style: TextStyle(
                      fontSize: 14, 
                      color: Color.fromARGB(255, 71, 123, 255)
                    ),
                  )
                ),
              ],
            ),
            

            Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.1, 0, 0),
                    child: const Text(
                      "* Type",
                      style: TextStyle(
                        fontSize: 18, 
                      ),
                    )
                ),
              ],
            ),
            dropdown(listType, dropdownType),

            splitebar(),

            Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                const Text(
                  "* Projet",
                  style: TextStyle(
                    fontSize: 18, 
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.001, 0, 0),
                    child: const Text(
                      "(ex : SmartProfile ou Créastore ...)",
                      style: TextStyle(
                        fontSize: 12, 
                      ),
                    )
                ),
              ],
            ),
            selectSearch(),

            splitebar(),

            Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                const Text(
                  "Sous projet",
                  style: TextStyle(
                    fontSize: 18, 
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.001, 0, 0),
                    child: const Text(
                      "(ex : Contacts, Analytics, Builder ...)",
                      style: TextStyle(
                        fontSize: 12, 
                      ),
                    )
                ),
              ],
            ),
            selectSearch2(),
            splitebar(),

            Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                const Text(
                  "Client",
                  style: TextStyle(
                    fontSize: 18, 
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.001, 0, 0),
                    child: const Text(
                      "(Si pour un client en particulier)",
                      style: TextStyle(
                        fontSize: 12, 
                      ),
                    )
                ),
              ],
            ),
            selectSearch3(),

            splitebar(),

            Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                const Text(
                  "* Tâche",
                  style: TextStyle(
                    fontSize: 18, 
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.001, 0, 0),
                    child: const Text(
                      "(Brève description)",
                      style: TextStyle(
                        fontSize: 12, 
                      ),
                      
                    )
                ),
              ],
            ),
            Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(largeurEcran*0.05, hauteurEcran*0.05, largeurEcran*0.05, 0),
                    child: TextFormField(
                      controller: tachecontroller,
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplir ce champs';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      
                    ),
                ),
              ],
            ),

            splitebar(),
            
            Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                const Text(
                  "* Semaine #",
                  style: TextStyle(
                    fontSize: 18, 
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.001, 0, 0),
                    child:  Text(
                      "$weekNumber",
                      style: const TextStyle(
                        fontSize: 18, 
                        color: Colors.blueAccent
                      ),
                    )
                ),
              ],
            ),

            splitebar(),

            Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                const Text(
                  "* Durée (en h)",
                  style: TextStyle(
                    fontSize: 18, 
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.001, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: decrement,
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Text(
                            value.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 24.0),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: increment,
                        ),
                      ],
                    ),
                ),
              ],
            ),

            splitebar(),

            Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(largeurEcran*0.05, hauteurEcran*0.05, largeurEcran*0.05, 0),
                    child: TextField(
                      controller: commentairecontroller,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Commentaire',
                        border: OutlineInputBorder(),
                      ),
                    ),
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.1, 0, 0),
              width: largeurEcran*0.7,
              child: ElevatedButton(
                onPressed: ()async {
                  if (_formKey.currentState!.validate()) {
                    if(selectedValue != null ){
                      if(selectedValue2 != null){
                        if(selectedValue3 != null){
                          int idclient =  client[nomClient.indexOf('$selectedValue3')].id;
                          //String clientdata =  "$selectedValue3";
                          TacheRequestModel model   = TacheRequestModel(action: 'TACHE', token: token, semaine: weekNumber, annee: DateTime.now().year, type: dropdownType, projet: '$selectedValue', sousProjet: '$selectedValue2', client: idclient, tache: tachecontroller.text, commentaire: commentairecontroller.text, duree: value);
                          Map<String, String> queryParams = {
                            'action': 'TACHE',
                            'token': token,
                            'semaine': '$weekNumber',
                            'annee': '${DateTime.now().year}',
                            'type': dropdownType,
                            'projet': '$selectedValue',
                            'sousProjet': '$selectedValue2',
                            'client': '$idclient',
                            'tache': tachecontroller.text,
                            'commentaire': commentairecontroller.text,
                            'duree': '$value',
                          };
                          inspect(idclient);
                          inspect(model);
                          
                          var response =  await APIService.posttache(model,queryParams);
                          if(response.statusCode==200){
                            var tacheResponse = tacheResponseJson(response.body);
                            if(tacheResponse.status == 'success'){
                              showInSnackBar("✅ La tâche a bien été enregistré");
                              refreshPage(context);
                            }else {
                              showInSnackBar("❌ ${tacheResponse.message}");
                            }
                          }else{
                            showInSnackBar("un effort frerot tu sais pas rentrer le bon mdp;❌❌❌❌❌");
                          }
                        }else{
                          showInSnackBar("❌ La soumission du formulaire a échoué. Veuillez remplir tous les champs obligatoires (*) avant de procéder.");
                        }
                      }else{
                        showInSnackBar("❌ La soumission du formulaire a échoué. Veuillez remplir tous les champs obligatoires (*) avant de procéder.");
                      }
                    }else{
                      showInSnackBar("❌ La soumission du formulaire a échoué. Veuillez remplir tous les champs obligatoires (*) avant de procéder.");
                    }
                  }else{
                    showInSnackBar("❌ La soumission du formulaire a échoué. Veuillez remplir tous les champs obligatoires (*) avant de procéder.");
                  }
                  // Logique à exécuter lorsque le bouton est pressé
                  /*LoginRequestModel model   = LoginRequestModel(action: "CONNECT", login: emailcontroller.text, password: mdpcontroller.text, token:"");
                  Map<String, String> queryParams = {
                    'action': 'CONNECT',
                    'login': emailcontroller.text,
                    'password': mdpcontroller.text,
                    'token': ' ',
                  };
                  var response=  await APIService.login(model,queryParams);
                  if(response.statusCode==200){
                      var LoginResponse = loginResponseJson(response.body);
                      if(LoginResponse.status == 'success'){
                        PersistanceHandler().setTokenEDP(LoginResponse.session.token);
                        showInSnackBar("gg  tu tes co ;) ✅✅✅✅");
                          // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TacheDevScreen()), // Remplacez TachePage() par le nom de votre classe de page tache.dart
                        );
                        

                      }else {
                        showInSnackBar("❌${LoginResponse.tokenStatus}");
                      }
                  }else{
                    showInSnackBar("un effort frerot tu sais pas rentrer le boñ mdp;❌❌❌❌❌");
                  }*/
                },
                child: const Text('VALIDÉ LA TÂCHE'),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(largeurEcran*0.05, hauteurEcran*0.15, largeurEcran*0.05, 0),
              child: const Text(
                "Les 5 dernières tâches saisies",
                style: TextStyle(
                  fontSize: 18, 
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(largeurEcran*0.02, hauteurEcran*0.05, largeurEcran*0.02, hauteurEcran*0.05),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: tableau(),
              ),
            )
          
          ],
        ),
      ):const Center(child: CircularProgressIndicator())
    );
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  

  Widget splitebar(){
    var largeurEcran = MediaQuery.of(context).size.width;
    var hauteurEcran = MediaQuery.of(context).size.height;
    return 
      Container(
        margin: EdgeInsets.fromLTRB(largeurEcran*0.1, hauteurEcran*0.08, largeurEcran*0.1, hauteurEcran*0.08),
        height: 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Color.fromARGB(255, 228, 228, 228),
        ),
      );
  }

  


  Widget tableau(){
    List<DataRow> dataRows = [];
    int taille = 0;
    
    if(datatableau.length > 5){
      taille = 5;
    } else{
      taille = datatableau.length;
    }

    for (int i = 0; i < taille; i++) {
      dataRows.add(
        DataRow(
          cells: [
            DataCell(Text('${datatableau[i].creationDate}')),
            DataCell(Text('${datatableau[i].semaine}')),
            DataCell(Text('${datatableau[i].type}')),
            DataCell(Text('${datatableau[i].projet}')),
            DataCell(Text('${datatableau[i].sousProjet}')),
            DataCell(Text('${datatableau[i].client}')),
            DataCell(Text('${datatableau[i].tache}')),
            DataCell(Text('${datatableau[i].duree}')),
          ],
        ),
      );
    }
    setState(() {
      dataready=true;
    });

    return  
    DataTable(
    columns: const [
      DataColumn(
        label: Text("Date d'ajout"),
      ),
      DataColumn(
        label: Text('Sem. #'),
      ),
      DataColumn(
        label: Text('Type'),
      ),
      DataColumn(
        label: Text('Projet'),
      ),
      DataColumn(
        label: Text('Sous projet'),
      ),
      DataColumn(
        label: Text('Client'),
      ),
      DataColumn(
        label: Text('Tâche'),
      ),
      DataColumn(
        label: Text('Durée (h)'),
      ),
    ],
    rows: dataRows,
    );
                    
  }

  Widget dropdown(List<String> item, String selected ) {
    var hauteurEcran = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.01, 0, 0),
            //width: largeurEcran*0.9,
            child: DropdownButton2<String>(
              value: selected,
              hint: const Icon(Icons.arrow_downward),
              //elevation: 18,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownType = value!;
                }); 
              },
              items: item.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
        ),
      ],
    );
  }

  

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Widget selectSearch() {
    var hauteurEcran = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.01, 0, 0),
            child:  DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: projet
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                
                selectedValue = value as String;
              });
            },
            buttonStyleData: const ButtonStyleData(
              height: 40,
              width: 200,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for an item...',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return (item.value.toString().contains(searchValue));
              },
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
          ),
        ),
      ],
    );
  }

  
  String? selectedValue2;
  final TextEditingController textEditingController2 = TextEditingController();

  void dispose2() {
    textEditingController2.dispose();
    super.dispose();
  }

  Widget selectSearch2() {
    var hauteurEcran = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.01, 0, 0),
            child:  DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: sousProjet
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue2,
            onChanged: (value) {
              setState(() {
                
                selectedValue2 = value as String;
              });
            },
            buttonStyleData: const ButtonStyleData(
              height: 40,
              width: 200,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController2,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController2,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for an item...',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return (item.value.toString().contains(searchValue));
              },
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController2.clear();
              }
            },
          ),
        ),
      ],
    );
  }

  String? selectedValue3;
  
  final TextEditingController textEditingController3 = TextEditingController();

  void dispose3() {
    textEditingController3.dispose();
    super.dispose();
  }

  Widget selectSearch3() {
    var hauteurEcran = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, hauteurEcran*0.01, 0, 0),
            child:  DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: nomClient
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue3,
            onChanged: (value) {
              setState(() {
                
                selectedValue3 = value as String;
              });
            },
            buttonStyleData: const ButtonStyleData(
              height: 40,
              width: 200,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController3,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController3,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for an item...',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return (item.value.toString().contains(searchValue));
              },
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController3.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}

