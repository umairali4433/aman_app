

import 'dart:convert';
import 'dart:io';

import 'package:aman_app/Cons/Constants.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:aman_app/Views/Participants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Pdfview.dart';
import 'Webviewlogin.dart';

class ShowListItem extends StatefulWidget {
  var ge  = '';
  var val = '';
  ShowListItem(this.ge,this.val);
  @override
  _ShowListItemState createState() => _ShowListItemState(ge,val);
}

class _ShowListItemState extends State<ShowListItem>  with TickerProviderStateMixin{
  var bollcheck = true;
  var get = '';
  var val = '';
  String pathPDF = "";
  _ShowListItemState(this.get,this.val);
  List<chatsdialogmodel> getitemlist = [];


  @override
  void initState() {

    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
    getLatestData();
  }






  Future<void> getLatestData() async {
    final ore = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Basic '+ore.get('counter'),
    };

    Uri uri = Uri.parse(Base_url+"files/"+val);

    var response = await http.get(uri, headers: requestHeaders);

    if (response.statusCode == 401) {
      print('error');
    } else if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var u in responseJson) {
        chatsdialogmodel post = chatsdialogmodel.a1(
            u['fileName'].toString(),
            u['contentType'].toString(),
            u['data'].toString(),
            u['path'].toString());
        getitemlist.add(post);
      }
      setState(() {
        getitemlist;
        bollcheck  = false;
      });


      print('asdad');
    }
  }
  Future<File> createFileOfPdfUrl() async {
    final url = "http://www.africau.edu/images/default/sample.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return bollcheck?Center(
      child: SpinKitSquareCircle(
        color: Colors.white,
        size: 50.0,
        controller: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 1200)),
      ),
    ):
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(get),
      ),
      body: getitemlist.length==0?Center(child: Text('No data found'),):ListView.builder(
          itemCount: getitemlist.length,
          itemBuilder: (context, index) {
            return  Column(
              children: [
                

                (getitemlist[index].contentType.contains('image'))?Padding(
                    padding: EdgeInsets.all(4),
                    child: Card(
                    elevation: 3,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Image.network(getitemlist[index].path)))):

                (getitemlist[index].contentType.contains('text'))?GestureDetector(
                  onTap: (){
                    _launchInWebViewOrVC(getitemlist[index].path);

                  },
                    child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                child: Expanded(
                                  child: Icon(
                                    Icons.text_fields,
                                  ),

                                ),

                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(getitemlist[index].fileName)
                          ],
                        )),
                ):
                    GestureDetector(
                      onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: ( context) { return flutterpdf(getitemlist[index].path); }));
                      },
                      child: Container(
                        width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  child: Expanded(
                                    child: Icon(
                                      Icons.picture_as_pdf,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(getitemlist[index].fileName)
                            ],
                          )),
                    ),
                Divider(
                  height: 20,
                ),
              ],
            );
          }),
    );
  }
  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget krleywr() {

    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text(pathPDF),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
}

class chatsdialogmodel {
  String fileName, contentType, data, path;

  chatsdialogmodel.a1(this.fileName, this.contentType, this.data, this.path);
}
