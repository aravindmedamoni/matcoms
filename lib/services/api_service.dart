
import 'package:dio/dio.dart';
import 'package:matcoms/model/matcom.dart';

class ApiService{

  //logic for get list of todoItem
  Stream<List<Matcom>> getSearchInfo({String searchString}) async*{
    Dio dio = Dio();
    try{
      print("NAME IS SERVICE : $searchString");
      Response response = await dio.get('https://api.cognitive.microsoft.com/bing/v7.0/search?q=$searchString&count=10&offset=0&mkt=en-ID&safesearch=Moderate',options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key':'4a6cddbf1d934fc9bf315af510a55e87'
        }
      ));
      dynamic jsonData;
      // print("status code ${response.statusCode}");
      if(response.statusCode == 200){
        jsonData = response.data;
        //print("JSONDATA ${jsonData['webPages']['value'][0]}");
        List<Matcom> taskItems = [];
        if(jsonData['webPages']['value'].length!=0){
          for(var json in jsonData['webPages']['value']){
            Matcom taskData = Matcom();
            taskData = Matcom.fromJson(json);
            taskItems.add(taskData);
            yield taskItems;
          }
        }else{
          yield null;
        }
      }else{
        yield null;
      }
    }catch(e){
      yield null;
    }
  }
}