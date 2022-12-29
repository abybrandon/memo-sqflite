import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../database services/databases.dart';
import 'memomodel.dart';

class DetailMemo extends StatefulWidget {
  MemoClas memoClas;

  DetailMemo(this.memoClas);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailMemoState(memoClas);
  }
}

enum Options { delete, update }

class _DetailMemoState extends State {
  MemoClas memoClas;
  _DetailMemoState(this.memoClas);
  var dbHelper = DbHelper();
  var txtTitle = TextEditingController();
  var txtDescription = TextEditingController();
  // var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    txtTitle.text = memoClas.title;
    txtDescription.text = memoClas.description;
    warna = memoClas.warna;
    int colorInt = int.parse(warna ?? "0");
    baru = colorInt;
    super.initState();
  }

  String warna;
  int baru;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Icon(
              Iconsax.arrow_left_34,
              color: Color(0xFF3C4048),
            ),
          ),
        ),
        backgroundColor: Color(baru ?? Colors.blue),
        title: Text(
          "Memo  ${memoClas.title}",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Color(0xFF3C4048)),
        ),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<Options>(
            icon: Icon(
              Iconsax.menu,
              color: Color(0xFF3C4048),
            ),
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Hapus"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Update"),
              ),
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  Widget buildProductDetail() {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, left: 10, right: 10),
      child: Column(
        children: <Widget>[
          buildTitleField(),
          SizedBox(
            height: 60,
          ),
          buildDescriptionField(),
          //   buildUnitPriceField(),
        ],
      ),
    );
  }

  Widget buildTitleField() {
    return TextField(
      autofocus: false,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF3C4048), width: 2),
        ),
        fillColor: Colors.white,
        labelText: "Masukan Judul Memo : ",
      ),
      controller: txtTitle,
    );
  }

  Widget buildDescriptionField() {
    return TextFormField(
      autofocus: false,
      maxLines: 10,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF3C4048), width: 2),
        ),
        fillColor: Colors.white,
        labelText: "Masukan Catatan Kamu : ",
      ),
      controller: txtDescription,
    );
  }

  // Widget buildUnitPriceField() {
  //   return TextField(
  //     decoration: InputDecoration(
  //       labelText: "Urunun Fiyati : ",
  //     ),
  //     controller: txtUnitPrice,
  //   );
  // }

  void selectProcess(Options options) async {
    //print(value);
    switch (options) {
      case Options.delete:
        await dbHelper.delete(memoClas.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(MemoClas.withId(
            id: memoClas.id,
            title: txtTitle.text,
            description: txtDescription.text,
            warna: baru.toString()
            //unitPrice: double.tryParse(txtUnitPrice.text)
            ));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
