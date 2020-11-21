import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyRequest extends StatefulWidget {
  @override
  _MyRequestState createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  var date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(13, 132, 155, 1),
        title: Text('My Requests'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('User Response').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot course = snapshot.data.docs[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  shadowColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black87,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    height: 320,
                    width: 400,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Status',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage('images/a.gif'),
                                ),
                                Text(
                                  'Date',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                    course['image 1 Url'],
                                  ),
                                  radius: 45,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                    course['image 2 Url'],
                                  ),
                                  radius: 45,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                    course['image 3 Url'],
                                  ),
                                  radius: 45,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    course['Location'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepPurple,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'REQUEST',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                                left: 10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      course['Your Request'],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
