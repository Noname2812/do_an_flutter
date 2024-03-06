// import 'package:do_an/api/index.dart';
// import 'package:do_an/modals/Product.dart';
// import 'package:do_an/ui/widgets/Loading.dart';
// import 'package:flutter/material.dart';

// class DetailProductPage extends StatefulWidget {
//   const DetailProductPage({super.key, required this.id});
//   final String id;

//   @override
//   State<DetailProductPage> createState() => _DetailProductState();
// }

// class _DetailProductState extends State<DetailProductPage> {
//   DetailProduct product = DetailProduct.constructor();
//   bool isLoading = true;
//   void getDataDetailProducts(String id) async {
//     final res = await getDetailProduct(id);
//     Iterable data = res['product'];
//     setState(() {
//       product = data as DetailProduct;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leading: ElevatedButton(
//             child: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: isLoading
//             ? Loading()
//             : Stack(
//                 children: [],
//               ));
//   }
// }
