import 'package:flutter/material.dart';
import 'package:flutter_api_praktikum/pages/kategori_list.dart';
import 'package:flutter_api_praktikum/pages/resep_detail.dart';
import 'package:flutter_api_praktikum/service/http_service.dart';

class MasakanList extends StatefulWidget {
  @override
  _MasakanListState createState() => _MasakanListState();
}

class _MasakanListState extends State<MasakanList> {
  int masakanCount = 0;
  List? masakan;
  late HttpService service;
  final controller = TextEditingController();

  Future initialize() async {
    masakan = [];
    masakan = await service.getMasakanBaru();
    setState(() {
      // masakanCount = masakan.length;
      masakanCount = masakan?.length ?? 0;
      // print(masakanCount);
      masakan = masakan;
    });
  }

  Future search(key) async {
    masakan = [];
    masakan = await service.searchResep(key);
    setState(() {
      // masakanCount = masakan.length;
      masakanCount = masakan?.length ?? 0;
      // print(masakanCount);
      masakan = masakan;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        //
        title: Text("HF - Resep Terbaru"),
        backgroundColor: Colors.lightGreen,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: AssetImage("assets/header.png"),
                      fit: BoxFit.cover)),
              child: Text(''),
            ),
            ListTile(
              title: const Text('Resep Terbaru'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MasakanList()),
                );
              },
            ),
            ListTile(
              title: const Text('Resep Berdasarkan Kategori'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KategoriList()),
                );
              },
            ),
          ],
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Column(children: [
        ListTile(
          title: TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Search', border: InputBorder.none),
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              search(controller.text);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: (this.masakanCount == null) ? 0 : this.masakanCount,
            itemBuilder: (BuildContext context, int position) => Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
              child: InkWell(
                onTap: () async {
                  Map<String, dynamic>? resep =
                      await service.getResep(masakan![position].key);
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) =>
                          ResepDetail(resep, masakan![position].thumb));
                  Navigator.push(context, route);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x32000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.network(
                          masakan![position].thumb,
                          width: double.infinity,
                          height: 190,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                masakan![position].title,
                                // style: FlutterFlowTheme.of(context)
                                //     .title3
                                //     .override(
                                //       fontFamily: 'Outfit',
                                //       color: Color(0xFF101213),
                                //       fontSize: 20,
                                //       fontWeight: FontWeight.w500,
                                //     ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.group,
                                color: Color(0xFFFFA130),
                                size: 24,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: Text(
                                  masakan![position].serving,
                                  // style: FlutterFlowTheme.of(context)
                                  //     .bodyText1
                                  //     .override(
                                  //       fontFamily: 'Outfit',
                                  //       color: Color(0xFF101213),
                                  //       fontSize: 14,
                                  //       fontWeight: FontWeight.normal,
                                  //     ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    140, 0, 8, 0),
                                child: Row(
                                  children: [
                                    Text(
                                      masakan![position].times + ' ',
                                      // style: FlutterFlowTheme.of(context)
                                      //     .bodyText2
                                      //     .override(
                                      //       fontFamily: 'Outfit',
                                      //       color: Color(0xFF57636C),
                                      //       fontSize: 14,
                                      //       fontWeight: FontWeight.normal,
                                      //     ),
                                    ),
                                    Icon(
                                      Icons.timelapse,
                                      color: Color(0xFFFFA130),
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),

      // ListView.builder(
      //     itemCount: (this.masakanCount == null) ? 0 : this.masakanCount,
      //     itemBuilder: (context, int position) {
      //       return Card(
      //         color: Colors.white,
      //         elevation: 2.0,
      //         child: ListTile(
      //           title: Text(masakan![position].title),
      //           subtitle: Text(
      //             masakan![position].difficulty.toString(),
      //           ),
      //           trailing: Image.network(
      //               // '/438QXt1E3WJWb3PqNniK0tAE5c1.jpg',
      //               masakan![position].thumb,
      //               fit: BoxFit.fitWidth),
      //           onTap: () async {
      //             Map<String, dynamic>? resep =
      //                 await service.getResep(masakan![position].key);
      //             print(resep);
      //             MaterialPageRoute route = MaterialPageRoute(
      //                 builder: (_) =>
      //                     ResepDetail(resep, masakan![position].thumb));
      //             Navigator.push(context, route);
      //           },
      //         ),
      //       );
      //     }
      //     ),
    );
  }
}
