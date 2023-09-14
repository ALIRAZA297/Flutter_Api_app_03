import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Model/Data.dart';
import 'detail_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<MaterialColor> _color = [
    Colors.blue,
    Colors.amber,
    Colors.blueGrey,
    Colors.brown,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.green,
    Colors.indigo,
    Colors.pink,
    Colors.teal,
  ];

  Future<List<Data>> getAllData() async {
    var api = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    var data = await http.get(api);

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);

      List<Data> listOfData = [];

      for (var i in jsonData) {
        Data data = Data(i["id"], i["thumbnailUrl"], i["title"], i["url"]);
        listOfData.add(data);
      }

      return listOfData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JSON Parsing App"),
        backgroundColor: Colors.deepOrange[400],
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Ali Raza"),
              accountEmail: const Text("aliraza3331549@gmail.com"),
              decoration: BoxDecoration(
                color: Colors.deepOrange[400],
              ),
            ),
            ListTile(
              title: const Text("First Page"),
              leading: const Icon(Icons.search, color: Colors.deepPurple),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("Second Page"),
              leading:
                  const Icon(Icons.accessibility, color: Colors.blueAccent),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("Third Page"),
              leading: const Icon(Icons.account_box, color: Colors.lime),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("Fourth Page"),
              leading: const Icon(Icons.add_home, color: Colors.lightGreen),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const Divider(
              height: 5.0,
            ),
            ListTile(
              title: const Text("Close"),
              leading: const Icon(Icons.close, color: Colors.red),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            height: 250.0,
            child: FutureBuilder(
              future: getAllData(),
              builder: (BuildContext c, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("Loading Data..."),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext c, int index) {
                      MaterialColor mcolor = _color[index % _color.length];
                      return Card(
                        elevation: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              snapshot.data[index].url,
                              height: 150.0,
                              width: 150.0,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            Container(
                              margin: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: mcolor,
                                    foregroundColor: Colors.white,
                                    child: Text(
                                        snapshot.data[index].id.toString()),
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  SizedBox(
                                    width: 100.0,
                                    child: Text(
                                      snapshot.data[index].title,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.blueGrey),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 7.0,
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: getAllData(),
              builder: (BuildContext c, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("Loading Data..."),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext c, int index) {
                      MaterialColor mcolor = _color[index % _color.length];
                      return Card(
                        elevation: 7.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                snapshot.data[index].thumbnailUrl,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext c) =>
                                          Detail(snapshot.data[index]),
                                    ),
                                  );
                                },
                                child: Text(
                                  snapshot.data[index].title,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundColor: mcolor,
                                  foregroundColor: Colors.white,
                                  child: Text(
                                    snapshot.data[index].id.toString(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
