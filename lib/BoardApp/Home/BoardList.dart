import 'package:flutter/material.dart';
import 'package:flutter_app/BoardApp/Home/BottomSheet.dart';
import 'package:flutter_app/BoardApp/Services/Auth.dart';
import 'package:flutter_app/BoardApp/Services/DataBase.dart';
import 'package:flutter_app/NetWorkCall/ModalClass.dart';
import 'package:provider/provider.dart';

class BoardList extends StatefulWidget {
  const BoardList({Key key}) : super(key: key);

  @override
  _BoardListState createState() => _BoardListState();
}

class _BoardListState extends State<BoardList> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final List board = Provider.of<List<Board>>(context);
    print('${user.userId} Awais');
    if (user.userId == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else
      return ListView.builder(
          itemCount: board.length,
          itemBuilder: (context, index) {
            return ListViewCard(
              title: board[index].title,
              imageLink: board[index].imageLink,
              description: board[index].description,
              price: board[index].price ?? 0,
              onTap: () {
                showModalBottomSheet<void>(
                  enableDrag: true,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return BottomSheetBoard(uid: user.userId);
                  },
                );
              },
            );
          });
  }
}
