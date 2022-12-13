import 'package:flutter/material.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

class ResepDetail extends StatelessWidget {
  GlobalKey previewContainer = new GlobalKey();
  final Map<String, dynamic>? resep;
  String thumb;
  int originalSize = 800;

  ResepDetail(this.resep, this.thumb);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kembali',
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: RepaintBoundary(
            key: previewContainer,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    // padding: EdgeInsets.all(16),
                    // height: height / 1.5,
                    child: Image.network(resep!['thumb']),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      resep!['title'],
                      style: TextStyle(color: Colors.lightGreen, fontSize: 20),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.only(left: 16, right: 50, bottom: 16),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.group),
                              ),
                              TextSpan(
                                text: ' ' + resep!['servings'],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(right: 50, bottom: 16),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.timelapse),
                              ),
                              TextSpan(
                                text: ' ' + resep!['times'],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 16),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.gas_meter),
                              ),
                              TextSpan(
                                text: ' ' + resep!['difficulty'],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Text(resep!['desc']),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                    child: Text(
                      'Bahan-bahan ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: resep!['ingredient'].length,
                    itemBuilder: (BuildContext context, int position) =>
                        Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 5),
                              alignment: Alignment.topLeft,
                              child: Text((position + 1).toString() + '. ')),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(resep!['ingredient'][position]))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        left: 16, right: 16, bottom: 10, top: 16),
                    child: Text(
                      'Cara Membuat ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: resep!['step'].length,
                    itemBuilder: (BuildContext context, int position) =>
                        Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          // Container(
                          //     padding: EdgeInsets.only(bottom: 5),
                          //     alignment: Alignment.topLeft,
                          //     child: Text((position + 1).toString() + '. ')),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(resep!['step'][position]))),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Ditulis Oleh",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreen,
                              fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          resep!['author']['user'] +
                              " pada " +
                              resep!['author']['datePublished'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShareFilesAndScreenshotWidgets().shareScreenshot(
              previewContainer, originalSize, "Title", "Name.png", "image/png",
              text: resep!['title']);
        },
        child: Icon(
          Icons.share,
          color: Colors.white,
          size: 29,
        ),
        backgroundColor: Colors.lightGreen,
        tooltip: 'Share',
        elevation: 5,
        splashColor: Colors.grey,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.CenterFloat,
    );
  }
}
