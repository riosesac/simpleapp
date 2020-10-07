import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleapp/akses/service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = new ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final a = Provider.of<CommentsSrvice>(context, listen: false);
    return Scaffold(
      body: RefreshIndicator(
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
                future: a.getComments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<CommentsSrvice>(builder: (context, data, _) {
                    return ListView.builder(
                        controller: _scrollController,
                        itemCount: data.dataComments.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${data.dataComments[i].id}(${data.dataComments[i].postId})",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "email: ${data.dataComments[i].email}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text("body: ${data.dataComments[i].body}"),
                                ],
                              ),
                            ),
                          );
                        });
                  });
                }),
          ),
          onRefresh: () => a.getComments()),
    );
  }
}
