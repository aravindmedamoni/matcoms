import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcoms/model/matcom.dart';
import 'package:matcoms/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController cityNameController = TextEditingController();
  List<Matcom> searchInfo;

  String searchStr;
  ApiService _apiService = GetIt.I<ApiService>();
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: cityNameController,
              onSubmitted: submitCityName,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: "search here",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: GestureDetector(
                  child: Icon(Icons.search),
                  onTap: () {
                    setState(() {
                      isLoaded = true;
                    });
                    if (cityNameController.text != "") {
                      searchStr = cityNameController.text;
                      submitCityName(cityNameController.text);
                    } else {
                      setState(() {
                        isLoaded = false;
                      });
                      print("Fail");
                    }
                  },
                ),
              ),
            ),
            if (isLoaded)
              Expanded(
                child: StreamBuilder(
                    stream: _apiService.getSearchInfo(searchString: searchStr),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            searchInfo = snapshot.data;
//                        print("DATA ${snapshot.data}");
//                        print("LENGTH : ${searchInfo.length}");
                            return Padding(
                              padding: const EdgeInsets.only(top:14.0),
                              child: ListView.separated(
                                itemCount: searchInfo.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical:8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                      Text(
                                        '${searchInfo[index].name}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      RichText(text: TextSpan(
                                        text: '${searchInfo[index].url}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.blue,
                                            decoration: TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()..onTap = () async{
                                          if(await canLaunch(searchInfo[index].url)){
                                          await launch(searchInfo[index].url);
                                          }else{
                                          throw 'Could not launch ${searchInfo[index].url}';
                                          }
                                        }
                                      )),
//                                  GestureDetector(
//                                    child: Text(
//                                      '${searchInfo[index].url}',
//                                      style: TextStyle(
//                                          fontSize: 18.0,
//                                          color: Colors.blue,
//                                          decoration: TextDecoration.underline),
//                                    ),
//                                    onTap: () async{
//                                     if(await canLaunch(searchInfo[index].url)){
//                                       await launch(searchInfo[index].url);
//                                     }else{
//                                       throw 'Could not launch ${searchInfo[index].url}';
//                                     }
//                                    },
//                                  ),
                                      Text(
                                        '${searchInfo[index].snippet}',
                                        style: TextStyle(fontSize: 18.0),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                                  );
                                },
                                separatorBuilder: (_, __) => Divider(
                                  color: Colors.green[800],
                                  height: 2,
                                  thickness: 2.0,
                                ),
                              ),
                            );
                          }
                      }
                      return Text("");
                    }),
              )
            else
              Text("")
          ],
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  void submitCityName(String searchString) {
    print("NAME : $searchString");
    _apiService.getSearchInfo(searchString: searchString);
  }
}
