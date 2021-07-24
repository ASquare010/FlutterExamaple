import 'package:flutter/material.dart';
import 'package:flutter_app/AppTheme.dart';
import 'package:flutter_app/NetWorkCall/ModalClass.dart';

class NetWorkCallTwo extends StatefulWidget {
  @override
  _NetWorkCallTowState createState() => _NetWorkCallTowState();
}

class _NetWorkCallTowState extends State<NetWorkCallTwo> {
  List<JsonApi> data;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Connection.getData().then((value) {
      /// Need to Set State As new data Has to be updated on the screen
      setState(() {
        data = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        shadowColor: purple,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: Text(
          "Total Images",
          style: TextStyle(color: purple),
        ),
      ),
      body: FutureBuilder(
        future: Connection.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scrollbar(
              child: ListView.builder(
                itemBuilder: (builder, index) {
                  return ListViewCard(
                    title: data[index].title,
                    imageLink: data[index].url,
                    price: data[index].id,
                    onTap: () {},
                  );
                },
                itemCount: (data == null) ? 0 : data.length,
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: purple,
              strokeWidth: 2,
              valueColor: new AlwaysStoppedAnimation<Color>(lightGrey),
            ));
          }
        },
      ),
    );
  }
}
