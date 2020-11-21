import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:hacakthon_app/widgets/image2.dart';
import '../widgets/image3.dart';

import '../widgets/Request_box.dart';
import '../widgets/image_input.dart';

import 'package:hacakthon_app/widgets/info_text.dart';
import '../widgets/your_request.dart';
import '../widgets/bottom_bar.dart';
import '../models/blueprint.dart';
import 'package:intl/intl.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  Position position;
  String _originalAddress;

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    print(position);

    getCurrentAddress();
  }

  void getCurrentAddress() async {
    final query = "1600 Amphiteatre Parkway, Mountain View";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");

// From coordinates

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    final coordinates = Coordinates(position.latitude, position.longitude);

    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    var originalAddress = "${first.featureName} : ${first.addressLine}";

    setState(() {
      _originalAddress = originalAddress;
    });
  }

  void _submitDetails() {
    String _position = _originalAddress;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    print(formatted);

    if (_position != null &&
        Models.image1Url != null &&
        Models.image2Url != null &&
        Models.image3Url != null &&
        Models.userRequest != null) {
      FirebaseFirestore.instance.collection('User Response').doc().set({
        'image 1 Url': Models.image1Url,
        'image 2 Url': Models.image2Url,
        'image 3 Url': Models.image3Url,
        'Location': _position,
        'Date': formatted,
        'Your Request': Models.userRequest,
      });

      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(30),
              )),
              child: Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 60),
                    height: 250,
                    child: Column(
                      children: [
                        Text(
                          'Request Submitted Successfully...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 27,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '"We will  lookout your request as soon as possible.."',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            'Okay',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          color: Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '5');
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -50,
                    child: CircleAvatar(
                      radius: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        child: Image.asset(
                          'images/2.gif',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    } else {
      final snackBar = SnackBar(
        content: Text(
          'Please fill all details...',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green,
      );
      globalKey.currentState.showSnackBar(snackBar);
      print('please fill all ');
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.green,
      //     content: Text(
      //       'Please Fill Each Section...',
      //       style: TextStyle(
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.blueGrey[100],
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(13, 132, 155, 1),
        title: Text(
          'Request Page',
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InfoText(),
            Row(
              //mainAxisAlignment: MainAxisAlignment.S,
              children: <Widget>[
                Expanded(child: ImageInput()),
                Expanded(child: Image2()),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image3(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 17.0),
                        child: Card(
                          shadowColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.indigo,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(top: 15),
                              height: 100,
                              width: 185,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: SingleChildScrollView(
                                        child: _originalAddress != null
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: Text(
                                                  _originalAddress,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              )
                                            : TextFormField(
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.indigo,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: null,

                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Your Location...',
                                                ),

                                                // onSubmitted: (_) {},
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.location_on,
                        ),
                        label: Text(
                          'Current Location',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        textColor: Colors.indigo,
                        onPressed: () {
                          getCurrentLocation();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            YourRequest(),
            SizedBox(
              height: 8.0,
            ),
            RequestBox(),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        heroTag: null,
        onPressed: () {
          _submitDetails();

          // Dialogue box...
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.check_circle,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
