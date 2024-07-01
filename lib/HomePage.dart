import 'dart:convert';
import 'dart:io';

import 'package:fire_app/AddProduct.dart';
import 'package:fire_app/SignIn_Page.dart';
import 'package:flutter/material.dart';

import 'OwnProducts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  var tabTitle = "Home";

  var views;
  int page=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List views = [OwnProducts(), AddProduct()];

    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${tabTitle}"),
      ),
      drawer: Drawer(
        elevation: 40,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("userData.userdata!.nAME"),
              accountEmail: Text("userData.userdata!.eMAIL"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: FileImage(File("img.png")),
              ),
            ),
            Card(
              elevation: 20,
              shadowColor: Colors.orange,
              child: InkWell(
                onTap: () {

                  Navigator.pop(context);
                  tabTitle = "Add Products";
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return AddProduct();
                    },
                  ));
                  setState(() {});
                },
                hoverColor: Colors.yellow,
                child: ListTile(
                  hoverColor: Colors.yellow,
                  leading: Icon(Icons.add),
                  title: Text("Add Products"),
                ),
              ),
            ),
            Card(
              elevation: 20,
              shadowColor: Colors.orange,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  page=1;
                  tabTitle = "Own Products";
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return OwnProducts();
                    },
                  ));
                  setState(() {});
                },
                hoverColor: Colors.yellow,
                child: ListTile(
                  hoverColor: Colors.yellow,
                  leading: Icon(Icons.folder_special),
                  title: Text("Own Products"),
                ),
              ),
            ),
            Card(
                elevation: 20,
                shadowColor: Colors.orange,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      tabTitle = "All Products";
                      setState(() {});
                    },
                    child: ListTile(
                      leading: Icon(Icons.all_inclusive),
                      title: Text("All Products"),
                    ))),
            Card(
                elevation: 20,
                shadowColor: Colors.orange,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return SignIn_Page();
                        },
                      ));
                      setState(() {});
                    },
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                    )))
          ],
        ),
      ),
      body: views[page],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(label: "home",icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "search",icon: Icon(Icons.search)),
        BottomNavigationBarItem(label: "add",icon: Icon(Icons.add)),
      ]),
    );
  }
}
