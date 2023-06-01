/*late List<String> Projet = <String>[];
  late List<String> SousProjet = <String>[];
  late List Client = [];
  late List<String> NomClient = <String>[];

  Future<void> getItem() async{
    
    Map<String, String> queryParams = {
      'action': 'TACHEITEM',
      'token': '$token',
    }; 

    var response=  await APIService.getdata(queryParams);
    if(response.statusCode==200){
      var DataResponse = getItemJson(response.body);
      if(DataResponse.status == 'success'){
        
        Projet = DataResponse.projet as List<String>;
        SousProjet = DataResponse.sousprojet as List<String>;
        Client = DataResponse.client;
        for( int i=0; i<DataResponse.client.length; i++){
          NomClient.add(DataResponse.client[i].client);
        }
        print(Projet);
        setState(() {
          dataready=true;
        });
      }
    }
  }*/