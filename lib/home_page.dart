import 'dart:convert';

import 'package:api_fetch/routes/my_route.dart';
import 'package:api_fetch/state_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> items = [];
  int num = 0;
  bool status = false;
  fetchData() async {
    setState(() {
      status = true;
    });
    // print("length of item ");
    // print(status);
    // print(items.length);
    await Future.delayed(const Duration(seconds: 2));
    var url = 'https://randomuser.me/api/?results=30';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var body = response.body;
    var resToJson = jsonDecode(body);
    setState(() {
      items = resToJson['results'];
      status = false;
      // print(status);
    });
  }


  add() {
    setState(() {
      num = num + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api fetch ").centered(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        // onPressed: (){},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer<StateProvider>(
          builder: ((context, value, child) => Container(
                child: status == false
                    ? Column(
                        children: [
                          "${value.count.last}".text.xl2.make(),
                          Expanded(
                            child: ListView.builder(
                              // itemCount: value.count.length,
                              itemCount:items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                final image = item['picture']['thumbnail'];
                                // final listItem = value.count[index];
                                
                                return ListTile(
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(image)),
                                      // child: Text(listItem.toString())),
                                  title: Text(item['email']),
                                );
                              },
                            ),
                          ),
                          ElevatedButton(
                              onPressed: value.add,
                              child: "Add number".text.make()),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyRoutes.stateRoute(5)));
                            },
                            child: "Next Page".text.make(),
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              )),
        ),
      ),
    );
  }
}
