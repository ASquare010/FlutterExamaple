import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  DataBase({this.uid});

  Map _map = {};

  //to get the user id to create his unique database in fre store
  final String uid;

  //Collection reference
  final CollectionReference boardCollection = FirebaseFirestore.instance.collection('Board');

  // to update and create dataBase
  Future updateUserData({String title, double price, String description, String imageLink}) async {
    return boardCollection.doc(uid).set(<String, dynamic>{
      'cost': price,
      'description': description,
      'image link': imageLink,
      'title': title,
    });
  }

  // to get the stream of data from fireStore
  Stream<List<Board>> get board {
    return boardCollection.snapshots().map(_boardList);
  }

  List<Board> _boardList(QuerySnapshot snapshots) {
    return snapshots.docs.map((doc) {
      _map = doc.data();
      return Board(
        price: _map['cost'] ?? '',
        description: _map['description'] ?? '',
        imageLink: _map['image link'] ?? '',
        title: _map['title'] ?? '',
      );
    }).toList();
  }
}

class Board {
  final double price;
  final String description;
  final String imageLink;
  final String title;

  const Board({this.price, this.description, this.imageLink, this.title});
}
