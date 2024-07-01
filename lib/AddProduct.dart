import 'dart:convert';
import 'dart:io';


import 'package:fire_app/HomePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';


class AddProduct extends StatefulWidget {
  String? imgPath;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  // String imgPath = "";
  TextEditingController pName = TextEditingController();
  TextEditingController pPrice = TextEditingController();
  TextEditingController pDes = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 500,
      width: 300,
      decoration: BoxDecoration(
          border: Border.all(width: 4),
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber),
      child: Material(
          color: Colors.transparent,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  //print("IMG PICKER IS CALLED");
                  // ImagePicker imgPicker = ImagePicker();
                  // XFile? file =
                  // await imgPicker.pickImage(source: ImageSource.gallery);
                  // widget.imgPath = file!.path;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Container(
                          height: 150,
                          width: 100,
                          color: Colors.white,
                          child: Material(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        print("IMG PICKER IS CALLED");
                                        ImagePicker imgPicker = ImagePicker();
                                        XFile? file = await imgPicker.pickImage(
                                            source: ImageSource.camera);
                                        widget.imgPath = file!.path;
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 50,
                                      )),
                                  InkWell(
                                      onTap: () async {
                                        ImagePicker imgPicker = ImagePicker();
                                        XFile? file = await imgPicker.pickImage(
                                            source: ImageSource.gallery);
                                        widget.imgPath = file!.path;
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Icon(
                                        Icons.sd_storage_outlined,
                                        size: 50,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  setState(() {});
                },
                child: CircleAvatar(
                  maxRadius: 50,
                  backgroundColor: Colors.brown,
                  backgroundImage: widget.imgPath != null
                      ? FileImage(File(widget.imgPath!))
                      : null,
                  child: widget.imgPath == null
                      ? Icon(Icons.person, size: 50)
                      : null,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: TextField(
                  controller: pName,
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Product Name",
                      prefixIcon: Icon(Icons.person))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: TextField(
                //autofocus: true,
                controller: pPrice,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Price",
                    prefixIcon: Icon(Icons.numbers)),
                //controller: widget.numberCtrl,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: TextField(
                //autofocus: true,
                controller: pDes,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                    prefixIcon: Icon(Icons.numbers)),
                //controller: widget.numberCtrl,
              ),
            ),
            ElevatedButton(
                //onPressed: onSave,
                onPressed: () async {
                  EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.fadingCircle;
                  EasyLoading.show(status: "Loading...");
                  CallAPI();
                },
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 20),
                )),
          ])),
    ));
  }

  Future CallAPI() async {
    //https://amiparaandroid.000webhostapp.com/Myapp/addProduct.php
    Uint8List list = await File(widget.imgPath!).readAsBytes();

    String imagestring = base64Encode(list);
  }
}

class ProductData {
  int? connection;
  int? productaddd;

  ProductData({this.connection, this.productaddd});

  ProductData.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    productaddd = json['productaddd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['productaddd'] = this.productaddd;
    return data;
  }
}
