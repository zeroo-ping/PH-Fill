import 'package:flutter/material.dart';
import '../models/blueprint.dart';

class RequestBox extends StatefulWidget {
  @override
  _RequestBoxState createState() => _RequestBoxState();
}

class _RequestBoxState extends State<RequestBox> {
  final _formKey = GlobalKey<FormState>();
  var userRequestt = '';
  bool pressed = false;
  bool iconPressed = false;

  final _requestController = TextEditingController();

  void _submitrequest(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Models.userRequest = userRequestt;

      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Response Taken Successfully ...',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.indigo,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black87,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 10,
      child: Container(
        height: 235,
        padding: EdgeInsets.only(
          top: 30,
          left: 20,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your request..';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '--> Your Request...',
                  ),
                  onSaved: (newValue) {
                    userRequestt = newValue;
                    //submitrequest();
                  },
                  controller: _requestController,
                ),
                Stack(
                  children: [
                    new FloatingActionButton(
                      backgroundColor: pressed ? Colors.black : Colors.black,
                      child: Icon(
                        iconPressed ? Icons.thumb_up : Icons.save_alt,
                        size: 30,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          pressed = !pressed;
                          iconPressed = !iconPressed;
                        });
                        _submitrequest(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  child: ClipOval(
//               child: Material(
//                 color: Colors.black, // button color
//                 child: InkWell(
//                   splashColor: Colors.red, // inkwell color
//                   child: SizedBox(
//                     width: 56,
//                     height: 56,
//                     child: Icon(
//                       Icons.save_alt,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onTap: _submitrequest,
//                 ),
//               ),
//             ),
//           ),
