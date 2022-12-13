import 'package:flutter/material.dart';
import 'package:flutter_api_praktikum/pages/resep_by_category.dart';
import 'package:flutter_api_praktikum/service/http_service.dart';

import 'masakan_list.dart';

class KategoriList extends StatefulWidget {
  @override
  _KategoriListState createState() => _KategoriListState();
}

class _KategoriListState extends State<KategoriList> {
  int masakanCount = 0;
  List? masakan;
  late HttpService service;
  final controller = TextEditingController();

  Future initialize() async {
    masakan = [];
    masakan = await service.getListKategori();
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
        title: Text("HF - Kategori"),
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
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: (this.masakanCount == null) ? 0 : this.masakanCount,
            itemBuilder: (BuildContext context, int position) => Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
              child: InkWell(
                onTap: () async {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) => ResepKategoriList(
                        keyword: masakan![position].key,
                        kategori: masakan![position].category),
                  );
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
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            masakan![position].category,
                            style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                          color: Colors.lightGreen,
                          width: double.infinity,
                          height: 100,
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
