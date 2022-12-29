// class ProductModel {
//   int id;
//   String name, category, createdAt, updatedAt;

//   ProductModel(
//       {this.id, this.category, this.createdAt, this.name, this.updatedAt});
//   //ini mirip firebse , klo yang di databases itu model database ke frontend, klo ini kebalikannya
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     //factory ini klo pengen kita dari model tapi value nya mw berbeda diambil dr json mapping
//     return ProductModel(
//         id: json['id'],
//         name: json['name'],
//         category: json['category'],
//         createdAt: json['createdAt'],
//         updatedAt: json['updatedAt']);
//   }
// }

class MemoClas {
  int id;
  String title;
  String description;
  String warna;

  MemoClas({this.title, this.description, this.warna});
  MemoClas.withId({this.id, this.title, this.description, this.warna});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["title"] = title;
    map["description"] = description;
    map['warna'] = warna;

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  MemoClas.fromObject(dynamic o) {
    this.id = int.tryParse(o["id"].toString());
    this.title = o["title"];
    this.description = o["description"];
    this.warna = o['warna'];

    //this.unitPrice = double.tryParse(o["unitPrice"].toString());
  }

  // var a(){
  //   var urun = new Product(name: "Laptop", description: "Aciklama", unitPrice: 2500);
  //   var mapUrun = urun.toMap();
  // }

}
