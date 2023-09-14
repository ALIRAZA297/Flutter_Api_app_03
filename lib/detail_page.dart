// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'Model/Data.dart';

class Detail extends StatefulWidget {
  Data data;

  Detail(this.data, {super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
        backgroundColor: Colors.deepOrange[400],
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  widget.data.url,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          child: Text(
                            widget.data.id.toString(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(widget.data.title, style: const TextStyle(fontSize: 20.0),),
                        
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
