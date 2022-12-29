// import 'package:db_slite/database%20services/databases.dart';
// import 'package:flutter/material.dart';

// class FormUpdate extends StatefulWidget {
//   @override
//   State<FormUpdate> createState() => _FormUpdateState();
// }

// class _FormUpdateState extends State<FormUpdate> {
//   TextEditingController namaController = TextEditingController();
//   DatabaseInstance databaseInstance = DatabaseInstance();
//   TextEditingController categoryController = TextEditingController();

//   @override
//   void initState() {
//     databaseInstance.database();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Post")),
//       body: Column(
//         children: [
//           TextFormField(
//             controller: namaController,
//             decoration: InputDecoration(
//               helperText: "Nama",
//             ),
//           ),
//           TextFormField(
//             controller: categoryController,
//             decoration: InputDecoration(
//               helperText: "Category",
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: IconButton(
//           color: Colors.green,
//           onPressed: () async {
//             await databaseInstance.insert({
//               'name': namaController.text,
//               'category': categoryController.text,
//               'createdAt': DateTime.now().toString(),
//             });
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.save)),
//     );
//   }
// }
