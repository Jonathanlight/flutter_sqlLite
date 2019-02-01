import 'package:flutter/material.dart';
import 'package:sqlite/model/databaseClient.dart';
import 'dart:async';

import 'package:sqlite/model/item.dart';
import 'package:sqlite/widgets/data_empty.dart';

class HomeController extends StatefulWidget {
  HomeController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {

  String nouvelleListe;
  List<Item> items;

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new FlatButton(
            onPressed: ajouter,
            child: new Text(
              'Ajouter', 
              style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
      body: (items == null || items.length == 0)
      ? new DataEmpty()
      : new ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          Item item = items[i];
          return new ListTile(
            title: new Text(item.nom),
          );
        }
      )
    );
  }

  Future<Null> ajouter() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          title: Text("Ajouter une liste de souhaits"),
          content: TextField(
            decoration: new InputDecoration(
              labelText: 'Liste',
              hintText: "ex: Mes jeux videos"
            ),
            onChanged: (String str) {
              nouvelleListe = str;
            },
          ),
          actions: <Widget>[
            new FlatButton(
              onPressed: (() => Navigator.pop(buildContext)),
              child: new Text('Annuler'),
            ),
            new FlatButton(
              onPressed: () {
                //add function for add liste in database
                if(nouvelleListe != null) {
                  Map<String, dynamic> map = {'nom': nouvelleListe };
                  Item item = new Item();
                  item.fromMap(map);
                  DatabaseClient().ajoutItem(item).then((i) => getItems());
                  nouvelleListe = null;
                }
                
                Navigator.pop(buildContext);
              },
              child: new Text('Valider', style: TextStyle(color: Colors.blue),),
            ),
          ],
        );
      }
    );
  }

  void getItems() {
    DatabaseClient().allItems().then((items) {
      setState(() {
        this.items = items;
      });
    });
  }
}
