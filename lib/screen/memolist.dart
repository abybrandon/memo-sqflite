import 'package:db_slite/screen/createscreen.dart';
import 'package:db_slite/screen/memodetail.dart';
import 'package:db_slite/screen/memomodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:iconsax/iconsax.dart';
import '../database services/databases.dart';

class MemoList extends StatefulWidget {
  MemoList({Key key});
  @override
  State<StatefulWidget> createState() {
    return _MemoListState();
    // TODO: implement createState
  }
}

class _MemoListState extends State<MemoList> {
  var dbHelper = DbHelper();
  List memoClas;
  int memosCount = 0;

  String _searchText = "";
  @override
  void initState() {
    // TODO: implement initState
    getMemo();
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFF36454F),
      appBar: AppBar(
        actions: [
          Icon(Iconsax.document_filter),
          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 10),
            child: GestureDetector(
                onTap: () {}, child: Icon(Iconsax.search_normal_1)),
          ),
        ],
        backgroundColor: Color(0xFF343434),
        title: Text(
          "My Memo",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Color(0xFFC0C0C0)),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: memosCount,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 5.0,
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            itemBuilder: (BuildContext context, int index) {
              int colorInt = int.parse(memoClas[index].warna ?? "1");
              return GestureDetector(
                onTap: () {
                  goToDetail(memoClas[index]);
                },
                child: Card(
                  color: Color(colorInt),
                  child: Column(children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://www.pngall.com/wp-content/uploads/4/Pin-PNG-Free-Download.png"))),
                      ),
                    ),
                    Text(
                      memoClas[index].title ?? "kosong",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Color(0xFF343434)),
                    ),
                    Text(
                      memoClas[index].description ?? "kosong",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: Color(0xFF343434)),
                    ),
                  ]),
                ),
              );
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFC2C1BE),
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(
          Iconsax.additem,
          color: Color(0xFF36454F),
        ),
        tooltip: "Post Page",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: memosCount,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.red,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text("O"),
              ),
              title: Text(
                memoClas[index].title,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black),
              ),
              subtitle: Text(
                memoClas[index].description,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: Colors.black),
              ),
              onTap: () {
                goToDetail(memoClas[index]);
              },
            ),
          );
        });
  }

  void goToProductAdd() async {
    bool result = await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProductAdd(),
      ),
    );
    if (result != null) {
      if (result) {
        getMemo();
      }
    }
  }

  void getMemo() async {
    var memosFuture = dbHelper.getMemo();
    memosFuture.then((data) {
      setState(() {
        this.memoClas = data;
        memosCount = data.length;
      });
    });
  }

  void goToDetail(memoClas) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailMemo(memoClas)));
    if (result != null) {
      if (result) {
        getMemo();
      }
    }
  }
}
