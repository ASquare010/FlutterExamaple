import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  DataBase({this.uid});

  Map<String,dynamic> _map = {};

  //to get the user id to create his unique database in fre store
  final String uid;

  //Collection reference
  final CollectionReference boardCollection = FirebaseFirestore.instance.collection('Board');

  // to update and create dataBase
  Future updateUserData({String title, num price, String description, String imageLink}) async {
    return boardCollection.doc(uid).set(<String, dynamic>{
      'cost': price,
      'description': description,
      'image link': imageLink,
      'title': title,
    });
  }
  List<Board> _boardList(QuerySnapshot snapshots) {
    return snapshots.docs.map((doc) {
      _map = doc.data();
      return Board(
        price: _map['cost'] ?? 0,
        description: _map['description'] ?? '',
        imageLink: _map['image link'] ?? '',
        title: _map['title'] ?? '',
      );
    }).toList();
  }
  // to get the stream of data from fireStore
  Stream<List<Board>> get board {
    return boardCollection.snapshots().map(_boardList);
  }


  // map DocumentSnapshot stream to UserData
  UserData _userDataFormSnapshot(DocumentSnapshot doc) {
    _map = doc.data();
    return UserData(
      uid: uid,
      price: _map['cost'] ?? 0,
      description: _map['description'] ?? '',
      imageLink: _map['image link'] ?? '',
      title: _map['title'] ?? '',
    );
  }

  // get user doc
  Stream<UserData> get userData {
    return boardCollection.doc(uid).snapshots().map(_userDataFormSnapshot);
  }
}

class Board {
  final num price;
  final String description;
  final String imageLink;
  final String title;

  const Board({ this.price, this.description, this.imageLink, this.title});
}

class UserData {
  final num price;
  final String uid;
  final String description;
  final String imageLink;
  final String title;

  UserData({this.uid, this.price, this.description, this.imageLink, this.title});
}
