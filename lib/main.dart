import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ice Creams FTW',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[50],
      ),
      home: const HomePage(title: 'Ice Cream Stores in SF'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot> _iceCreamStores;

  @override
  void initState() {
    super.initState();
    _iceCreamStores = Firestore.instance
        .collection('ice_cream_stores')
        .orderBy('name')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _iceCreamStores,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: const Text('Loading...'));
          }

          return Column(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: StoreMap(
                  documents: snapshot.data.documents,
                  initialPosition: const LatLng(37.7786, -122.4375),
                ),
              ),
              Flexible(
                flex: 3,
                child: StoreList(documents: snapshot.data.documents),
              ),
            ],
          );
        },
      ),
    );
  }
}

class StoreList extends StatelessWidget {
  const StoreList({
    Key key,
    @required this.documents,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (builder, index) {
        final document = documents[index];
        return ListTile(
          title: Text(document['name']),
          subtitle: Text(document['address']),
        );
      },
    );
  }
}

class StoreMap extends StatelessWidget {
  const StoreMap({
    Key key,
    @required this.documents,
    @required this.initialPosition,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final LatLng initialPosition;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 12,
      ),
    );
  }
}
