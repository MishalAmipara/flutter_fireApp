import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OwnProducts extends StatefulWidget {
  const OwnProducts({super.key});

  @override
  State<OwnProducts> createState() => _OwnProductsState();
}

class _OwnProductsState extends State<OwnProducts> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Own Products List"),
      ),
      body: FutureBuilder(
        future: showOwnProducts(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Row(
              children: [
                Text("Please Waiting...."),
                CircularProgressIndicator(),
              ],
            ));
          } else {
            return ListView.builder(

              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                      elevation: 10,
                      color: Colors.amberAccent,
                      child: ListTile(
                        leading: CircleAvatar(
                        //   backgroundImage: viewDataList!
                        //           .productdata![index].pIMG!.isNotEmpty
                        //       ? NetworkImage(
                        //           "https://amiparaandroid.000webhostapp.com/Myapp/${viewDataList!.productdata![index].pIMG}")
                        //       : NetworkImage(
                        //       "https://t3.ftcdn.net/jpg/04/60/01/36/360_F_460013622_6xF8uN6ubMvLx0tAJECBHfKPoNOR5cRa.jpg"),
                        // ),
                        // title:
                        //     Text("${viewDataList!.productdata![index].pNAME}"),
                        // subtitle:
                        //     Text("${viewDataList!.productdata![index].pDES}"),
                        // trailing: Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     Text("${viewDataList!.productdata![index].pPRICE}"),
                        //     Icon(Icons.more_vert),
                        //],
                        ),
                      )),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> showOwnProducts() async {

  }
}
