import 'dart:math';
import 'package:db_slite/screen/memolist.dart';
import 'package:db_slite/detaildummy.dart';
import 'package:flutter/material.dart';
import '../database services/databases.dart';
import 'memomodel.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductAddState();
  }
}

class ProductAddState extends State {
  @override
  void initState() {
    super.initState();
  }

  List<Color> colors = [
    Color(0xFF246EE9),
    Color(0xFFFFADAD),
    Color(0xFFFFD6A5),
    Color(0xFFFDFFB6),
    Color(0xFFCAFFBF),
    Color(0xFF9BF6FF),
    Color(0xFFBDB2FF),
    Color(0xFFFFC6FF),
  ];

  var random = new Random();
  Color hasilColor;
  int testColorIndex;
  void generateRandomColor() {
    setState(() {
      int min = 0;

      int max = colors.length;

      // Pilih secara acak salah satu warna dari list
      int selectedColorIndex = random.nextInt(max);

      // Ambil warna yang dipilih dari list
      Color selectedColor = colors[selectedColorIndex];
      hasilColor = selectedColor;
      testColorIndex = selectedColor.value;
    });
  }

  Color color;
  var txtTitle = TextEditingController();
  var txtDescription = TextEditingController();
  //var txtUnitPrice = TextEditingController();
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Posting Form",
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30.0, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              buildTitleField(),
              SizedBox(
                height: 60,
              ),
              buildDescriptionField(),
              buildSavebutton(),
            ],
          ),
        ));
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

  Widget buildSavebutton() {
    return FlatButton(
      child: Text(
        "Save",
        style: TextStyle(
            fontWeight: FontWeight.w900, fontSize: 20, color: Colors.red),
      ),
      onPressed: () {
        generateRandomColor();
        addProduct();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MemoList(),
          ),
        );
      },
    );
  }

  void addProduct() async {
    var result = await dbHelper.insert(MemoClas(
        title: txtTitle.text,
        description: txtDescription.text,
        warna: testColorIndex.toString()
        //unitPrice: double.tryParse(txtUnitPrice.text)
        ));
  }
}
