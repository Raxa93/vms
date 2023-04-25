// // ignore_for_file: use_build_context_synchronously
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../../configurations/size_config.dart';
// import '../../constants/app_styles.dart';
// import '../brewery/brewery_main.dart';
// import 'home_vm.dart';
//
// class HomeView extends StatelessWidget {
//   static const routeName = 'home_screen';
//
//   HomeView({Key? key}) : super(key: key);
//   final picker = ImagePicker();
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Consumer<HomeViewModel>(builder: ((context, vm, _) {
//       return SafeArea(
//           child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               }),
//           actions: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context)
//                       .pushReplacementNamed(BreweryMainView.routeName);
//                 },
//                 child: const Text('Show Brewery'))
//           ],
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Add Image', style: AppStyle.headline1),
//             Container(
//                 width: SizeConfig.screenWidth,
//                 height: SizeConfig.screenHeight! * 0.25,
//                 margin: EdgeInsets.all(SizeConfig.screenHeight! * 0.01),
//                 padding: const EdgeInsets.all(5),
//                 decoration: AppStyle.borderedContainer,
//                 child: vm.imageFile != null
//                     ? Container(
//                         margin: const EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image: FileImage(vm.imageFile!),
//                                 fit: BoxFit.cover)),
//                       )
//                     : const Icon(Icons.image)),
//             ElevatedButton(
//                 onPressed: () async {
//                   debugPrint('Before Image was ${vm.imageFile}');
//                   _showPicker(context, vm);
//                 },
//                 child: const Text('Pick Image')),
//             ElevatedButton(
//                 onPressed: () async {
//                   // await vm.scanImageForText(context);
//                 },
//                 child: const Text('Scan Text')),
//             Expanded(
//               flex: 8,
//               child: Container(
//                 // height: 400,
//                 margin: EdgeInsets.all(SizeConfig.screenHeight! * 0.01),
//                 decoration: AppStyle.borderedContainer,
//                 padding: EdgeInsets.symmetric(
//                     horizontal: SizeConfig.screenWidth! * 0.08),
//                 alignment: Alignment.topLeft,
//                 child: SelectableText(
//                   vm.scannedText.isEmpty || vm.scannedText == ''
//                       ? 'Scan an Image to get text'
//                       : vm.scannedText.toString(),
//                   textAlign: TextAlign.justify,
//                   style: TextStyle(fontSize: SizeConfig.screenHeight! * 0.025),
//                   strutStyle:
//                       StrutStyle(fontSize: SizeConfig.screenHeight! * 0.042),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ));
//     }));
//   }
//
//   Future _showPicker(context, vm) async {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Wrap(
//               children: <Widget>[
//                 ListTile(
//                     leading: const Icon(Icons.photo_library),
//                     title: const Text('Gallery'),
//                     onTap: () async {
//                       await pickImageForScanning(
//                           context, vm, ImageSource.gallery);
//                       Navigator.of(context).pop();
//                     }),
//                 ListTile(
//                   leading: const Icon(Icons.photo_camera),
//                   title: const Text('Camera'),
//                   onTap: () async {
//                     await pickImageForScanning(context, vm, ImageSource.camera);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
//
//   Future pickImageForScanning(
//       BuildContext context, var vm, ImageSource source) async {
//     final pickedImages = await picker.pickImage(source: source);
//     if (pickedImages != null) {
//       vm.setImage = File(pickedImages.path);
//     }
//   }
// }
