// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
        ),
        drawer: Drawer(

          child: Column(
            children: <Widget>[
              SizedBox(
                height: 28,
              ),
              Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://images.unsplash.com/photo-1596643111734-7729183fa628?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80")
                      )
                  )),
              Center(
                  child: Text("Aman!"),),
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: new  ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        EntryItem(data[index]),
                    itemCount: data.length,
                  ),
                ),
              ),

            ],
          ),
        ),
        body: forbody(),

      ),
    );
  }

}
class forbody extends StatefulWidget{
  @override
  mainstate createState() => mainstate();

  }
  class mainstate extends State<forbody>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("asdsadsad"),
    );
  }

  }

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Exercise',
    <Entry>[
      Entry(
        'Activities',
        <Entry>[
          Entry('Harbour Phase'),
          Entry('Sea Phase'),
        ],
      ),
      Entry('Events',
        <Entry>[
          Entry('Opening Cermony'),
          Entry('Reception Dinner'),
          Entry('IMC'),
          Entry('Band Display & CT Demo'),
          Entry('Food Gala & Cultural Show'),
          Entry('IFR(Internal Fleet Review)'),

        ],

      ),
      Entry(
        'Scedule ',
        <Entry>[
          Entry('Events'),
          Entry('Date & time'),
        ],
      ),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(ExpansionTileSample());
}